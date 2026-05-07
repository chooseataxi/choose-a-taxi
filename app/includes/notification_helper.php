<?php
require_once __DIR__ . '/../../vendor/autoload.php';

class NotificationHelper {
    
    private static function loadEnv() {
        if (!isset($_ENV['ONESIGNAL_APP_ID']) || empty($_ENV['ONESIGNAL_API_KEY'])) {
            try {
                $rootPath = realpath(__DIR__ . '/../../');
                if (class_exists('Dotenv\Dotenv')) {
                    $dotenv = Dotenv\Dotenv::createImmutable($rootPath);
                    $dotenv->safeLoad();
                }
            } catch (Exception $e) {
                error_log("OneSignal loadEnv Error: " . $e->getMessage());
            }
        }
    }

    public static function getAppId($pdo = null) {
        if ($pdo) {
            try {
                $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = 'onesignal_app_id'");
                $stmt->execute();
                $val = $stmt->fetchColumn();
                if ($val) return $val;
            } catch (Exception $e) {}
        }
        self::loadEnv();
        return $_ENV['ONESIGNAL_APP_ID'] ?? '8af20809-09e9-4ce1-9377-989b6b4e4600';
    }

    public static function getApiKey($pdo = null) {
        if ($pdo) {
            try {
                $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = 'onesignal_rest_api_key'");
                $stmt->execute();
                $val = $stmt->fetchColumn();
                if ($val) return $val;
            } catch (Exception $e) {}
        }
        self::loadEnv();
        return $_ENV['ONESIGNAL_API_KEY'] ?? '';
    }

    public static function getChannelId($pdo, $box = 1) {
        $key = 'onesignal_new_booking_channel';
        if ($box == 2) $key = 'onesignal_chat_channel';
        if ($box == 3) $key = 'onesignal_commission_channel';
        if ($box == 4) $key = 'onesignal_accept_channel';
        if ($box == 5) $key = 'onesignal_cancel_channel';
        if ($box == 6) $key = 'onesignal_trip_status_channel';

        if ($pdo) {
            try {
                $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = ?");
                $stmt->execute([$key]);
                $val = $stmt->fetchColumn();
                if ($val) return $val;
            } catch (Exception $e) {}
        }
        return '';
    }

    public static function send($pdo, $recipients, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        
        $type = $data['type'] ?? '';
        $chat_type = $data['chat_type'] ?? '';
        $box = 1;
        if ($type === 'chat' && $chat_type === 'quote_request') $box = 3;
        elseif (in_array($type, ['chat', 'chat_message'])) $box = 2;
        elseif (in_array($type, ['commission_request', 'payment_request'])) $box = 3;
        elseif (in_array($type, ['booking_accepted', 'assign_success'])) $box = 4;
        elseif (in_array($type, ['booking_cancelled', 'cancel'])) $box = 5;
        elseif (in_array($type, ['trip_start', 'trip_end', 'trip_complete', 'trip_update', 'status_update'])) $box = 6;
        
        $channelId = self::getChannelId($pdo, $box);
        if (!$apiKey) return false;

        $recipientList = is_array($recipients) ? $recipients : [$recipients];

        // Store title/body in data too for the extension
        $data['title'] = $title;
        $data['body'] = $body;

        $fields = array(
            'app_id' => $appId,
            'include_external_user_ids' => $recipientList,
            'data' => $data,
            'contents' => array("en" => $body), 
            'headings' => array("en" => $title),
            'android_accent_color' => 'FF1A1F36',
            'small_icon' => 'ic_stat_onesignal_default',
            'priority' => 10 // High priority
        );

        if ($channelId) {
            $fields['android_channel_id'] = $channelId;
        }

        return self::executeCurl($fields, $apiKey);
    }

    public static function broadcastToAll($pdo, $title, $body, $data = [], $box = 1) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        $channelId = self::getChannelId($pdo, $box);

        if (!$apiKey) return false;

        $data['title'] = $title;
        $data['body'] = $body;

        $fields = array(
            'app_id' => $appId,
            'included_segments' => array('All'),
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title),
            'priority' => 10
        );

        if ($channelId) {
            $fields['android_channel_id'] = $channelId;
        }

        return self::executeCurl($fields, $apiKey);
    }

    public static function sendBookingNotification($pdo, $booking) {
        try {
            $stmt = $pdo->query("SELECT p.id as partner_id, pas.vehicle_types, pas.trip_types, pas.routes 
                                 FROM partners p 
                                 LEFT JOIN partner_alert_settings pas ON p.id = pas.partner_id 
                                 WHERE p.status = 'Active'");
            $allPartners = $stmt->fetchAll(PDO::FETCH_ASSOC);

            $recipients = [];
            foreach ($allPartners as $partner) {
                if (self::shouldNotify($partner, $booking)) {
                    $recipients[] = "partner_" . $partner['partner_id'];
                }
            }

            if (!empty($recipients)) {
                $type = $booking['trip_type'] ?? 'Trip';
                $id = $booking['id'];
                $pickup = $booking['pickup_location'] ?? 'N/A';
                $drop = $booking['drop_location'] ?? 'N/A';
                $car = $booking['car_type_name'] ?? 'Any';
                $date = $booking['start_date'] ?? date('d/m/y');
                $time = $booking['start_time'] ?? '';

                $title = "New $type Available";
                $body = "$type booking ($id)\n$pickup ----- $drop\nCar type :- $car\nDate :- $date @ $time";
                
                return self::send($pdo, $recipients, $title, $body, [
                    'type' => 'new_booking',
                    'booking_id' => $id
                ]);
            }
        } catch (Exception $e) {
            error_log("Error in sendBookingNotification: " . $e->getMessage());
        }
        return false;
    }

    private static function shouldNotify($settings, $booking) {
        if (empty($settings['vehicle_types']) && empty($settings['trip_types']) && empty($settings['routes'])) {
            return true;
        }
        if (!empty($settings['vehicle_types'])) {
            $allowedCars = explode(',', $settings['vehicle_types']);
            if (!in_array($booking['car_type_name'] ?? '', $allowedCars)) return false;
        }
        if (!empty($settings['trip_types'])) {
            $allowedTrips = explode(',', $settings['trip_types']);
            $normTripType = strtolower(str_replace(' ', '', $booking['trip_type'] ?? ''));
            $normAllowed = array_map(function($t) { return strtolower(str_replace(' ', '', $t)); }, $allowedTrips);
            if (!in_array($normTripType, $normAllowed)) return false;
        }
        if (!empty($settings['routes'])) {
            $routes = json_decode($settings['routes'], true);
            if (!empty($routes) && is_array($routes)) {
                $match = false;
                foreach ($routes as $r) {
                    $p1 = strtolower($booking['pickup_location'] ?? '');
                    $d1 = strtolower($booking['drop_location'] ?? '');
                    $p2 = strtolower($r['pickup'] ?? '');
                    $d2 = strtolower($r['drop'] ?? '');
                    if (strpos($p1, $p2) !== false && strpos($d1, $d2) !== false) {
                        $match = true;
                        break;
                    }
                }
                if (!$match) return false;
            }
        }
        return true;
    }

    public static function isEnabled($pdo, $partner_id, $type) {
        try {
            $stmt = $pdo->prepare("SELECT notification_types FROM partner_alert_settings WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $val = $stmt->fetchColumn();
            if ($val === false || $val === null) return true; 
            if (trim($val) === '') return false;
            return in_array($type, explode(',', $val));
        } catch (Exception $e) { return true; }
    }

    private static function executeCurl($fields, $apiKey) {
        $fields = json_encode($fields);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json; charset=utf-8', 'Authorization: Basic ' . $apiKey));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        $response = curl_exec($ch);
        curl_close($ch);
        return $response;
    }
}
