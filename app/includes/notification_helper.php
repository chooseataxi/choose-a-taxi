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

    public static function send($pdo, $recipients, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        if (!$apiKey) return false;

        $recipientList = is_array($recipients) ? $recipients : [$recipients];

        $data['title'] = $title;
        $data['body'] = $body;

        $fields = array(
            'app_id' => $appId,
            'include_external_user_ids' => $recipientList,
            'data' => $data,
            'contents' => array("en" => $body), 
            'headings' => array("en" => $title),
            'android_accent_color' => 'FF1A1F36',
            'small_icon' => 'ic_launcher',
            'priority' => 10,
            'android_channel_id' => 'chooseataxi_awesome_channel'
        );

        return self::executeCurl($fields, $apiKey);
    }

    public static function broadcastToAll($pdo, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        if (!$apiKey) return false;

        $data['title'] = $title;
        $data['body'] = $body;

        $fields = array(
            'app_id' => $appId,
            'included_segments' => array('All'),
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title),
            'priority' => 10,
            'small_icon' => 'ic_launcher',
            'android_channel_id' => 'chooseataxi_awesome_channel'
        );

        return self::executeCurl($fields, $apiKey);
    }

    public static function sendBookingNotification($pdo, $booking) {
        // Broadacasting to ALL users to ensure 100% delivery like Admin panel
        // This bypasses any login/sync issues.
        $type = $booking['trip_type'] ?? 'Trip';
        $id = $booking['id'];
        $pickup = $booking['pickup_location'] ?? 'N/A';
        $drop = $booking['drop_location'] ?? 'N/A';
        $car = $booking['car_type_name'] ?? 'Any';
        $date = $booking['start_date'] ?? date('d/m/y');
        $time = $booking['start_time'] ?? '';

        $title = "New $type Available";
        $body = "$type booking ($id)\n$pickup ----- $drop\nCar type :- $car\nDate :- $date @ $time";
        
        return self::broadcastToAll($pdo, $title, $body, [
            'type' => 'new_booking',
            'booking_id' => $id
        ]);
    }

    private static function executeCurl($fields, $apiKey) {
        $fieldsJson = json_encode($fields);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json; charset=utf-8', 'Authorization: Basic ' . $apiKey));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fieldsJson);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        
        $response = curl_exec($ch);
        $error = curl_error($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($error) {
            error_log("OneSignal CURL Error: " . $error);
            return json_encode(['error' => $error, 'status' => 'failed']);
        }
        
        if ($httpCode != 200) {
            error_log("OneSignal HTTP Error Code: " . $httpCode . " Response: " . $response);
        }

        return $response;
    }
}
