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
        $key = $_ENV['ONESIGNAL_API_KEY'] ?? '';
        
        // Manual fallback if Dotenv failed
        if (empty($key)) {
            $path = realpath(__DIR__ . '/../../') . '/.env';
            if (file_exists($path)) {
                $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
                foreach ($lines as $line) {
                    if (strpos(trim($line), '#') === 0) continue;
                    $parts = explode('=', $line, 2);
                    if (count($parts) < 2) continue;
                    list($name, $value) = $parts;
                    $name = trim($name);
                    $value = trim($value, " \t\n\r\0\x0B\"'");
                    if ($name === 'ONESIGNAL_API_KEY') {
                        $key = $value;
                        $_ENV['ONESIGNAL_API_KEY'] = $value;
                        break;
                    }
                }
            }
        }

        if (empty($key)) {
             $logFile = __DIR__ . '/../../tmp/onesignal_log.json';
             $logData = [
                 'timestamp' => date('Y-m-d H:i:s'),
                 'error' => 'API KEY NOT FOUND IN DB, $_ENV OR .ENV MANUALLY',
                 'check_path' => realpath(__DIR__ . '/../../') . '/.env'
             ];
             @file_put_contents($logFile, json_encode($logData, JSON_PRETTY_PRINT) . PHP_EOL . "---" . PHP_EOL, FILE_APPEND);
        }
        return $key;
    }

    /**
     * Sends a notification to specific user(s) using OneSignal External IDs
     * $recipients: can be a single string (e.g. "partner_14") or an array of strings
     */
    public static function send($pdo, $recipients, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);

        if (!$apiKey) {
            error_log("OneSignal Error: REST API KEY is missing");
            return false;
        }

        $recipientList = is_array($recipients) ? $recipients : [$recipients];

        $content = array(
            "en" => $body
        );
        $headings = array(
            "en" => $title
        );

        $fields = array(
            'app_id' => $appId,
            'include_external_user_ids' => $recipientList,
            'data' => $data,
            'contents' => $content,
            'headings' => $headings,
            'android_accent_color' => 'FF1A1F36',
            'small_icon' => 'ic_stat_onesignal_default',
            'android_sound' => 'chat_notification_sound',
            'ios_sound' => 'chat_notification_sound.wav',
            'android_channel_id' => 'fcm_default_channel'
        );

        return self::executeCurl($fields, $apiKey);
    }

    /**
     * Sends notification to ALL users (broadcasting)
     */
    public static function broadcastToAll($pdo, $title, $body, $data = [], $exclude_id = 0) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);

        if (!$apiKey) return false;

        $fields = array(
            'app_id' => $appId,
            'included_segments' => array('All'),
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title),
            'android_sound' => 'chat_notification_sound',
            'ios_sound' => 'chat_notification_sound.wav',
            'android_channel_id' => 'fcm_default_channel'
        );

        return self::executeCurl($fields, $apiKey);
    }

    /**
     * Sends a filtered booking notification to eligible partners
     */
    public static function sendBookingNotification($pdo, $booking) {
        try {
            // Fetch all active partners and their alert settings (if any)
            $stmt = $pdo->query("SELECT p.id as partner_id, pas.vehicle_types, pas.trip_types, pas.notification_types, pas.routes 
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
                $title = "New " . ($booking['trip_type'] ?? 'Booking') . " Alert";
                $body = "Pickup: " . ($booking['pickup_location'] ?? 'N/A') . " \u2192 " . ($booking['drop_location'] ?? 'N/A');
                
                return self::send($pdo, $recipients, $title, $body, [
                    'type' => 'new_booking',
                    'booking_id' => $booking['id']
                ]);
            }
        } catch (Exception $e) {
            error_log("Error in sendBookingNotification: " . $e->getMessage());
        }
        return false;
    }

    private static function shouldNotify($settings, $booking) {
        // If no settings found, they receive everything by default
        if (empty($settings['vehicle_types']) && empty($settings['trip_types']) && empty($settings['routes'])) {
            return true;
        }

        // 1. Check Vehicle types
        if (!empty($settings['vehicle_types'])) {
            $allowedCars = explode(',', $settings['vehicle_types']);
            $carType = $booking['car_type_name'] ?? '';
            if (!in_array($carType, $allowedCars)) return false;
        }

        // 2. Check Trip types
        if (!empty($settings['trip_types'])) {
            $allowedTrips = explode(',', $settings['trip_types']);
            $tripType = $booking['trip_type'] ?? '';
            
            // Normalize: remove spaces and lowercase
            $normTripType = strtolower(str_replace(' ', '', $tripType));
            $normAllowed = array_map(function($t) { return strtolower(str_replace(' ', '', $t)); }, $allowedTrips);
            
            if (!in_array($normTripType, $normAllowed)) return false;
        }

        // 3. Check Routes (City to City)
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

    /**
     * Checks if a specific notification type is enabled for a partner
     */
    public static function isEnabled($pdo, $partner_id, $type) {
        try {
            $stmt = $pdo->prepare("SELECT notification_types FROM partner_alert_settings WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $val = $stmt->fetchColumn();
            
            // If no record exists, default to ENABLED for everything
            if ($val === false || $val === null) return true; 
            
            // If record exists but field is empty, it means everything is DISABLED
            if (trim($val) === '') return false;
            
            $types = explode(',', $val);
            return in_array($type, $types);
        } catch (Exception $e) {
            return true;
        }
    }

    private static function executeCurl($fields, $apiKey) {
        $fields = json_encode($fields);
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json; charset=utf-8',
            'Authorization: Basic ' . $apiKey
        ));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        // Logging
        $logFile = __DIR__ . '/../../tmp/onesignal_log.json';
        $logDir = dirname($logFile);
        if (!is_dir($logDir)) @mkdir($logDir, 0777, true);

        $logData = [
            'timestamp' => date('Y-m-d H:i:s'),
            'http_code' => $httpCode,
            'payload' => json_decode($fields, true),
            'response' => json_decode($response, true) ?: $response
        ];
        file_put_contents($logFile, json_encode($logData, JSON_PRETTY_PRINT) . PHP_EOL . "---" . PHP_EOL, FILE_APPEND);

        return $response;
    }
}
