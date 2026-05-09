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
                if ($val) {
                    self::logDebug("Using AppID from DB: $val");
                    return $val;
                }
            } catch (Exception $e) {}
        }
        self::loadEnv();
        $id = $_ENV['ONESIGNAL_APP_ID'] ?? $_SERVER['ONESIGNAL_APP_ID'] ?? getenv('ONESIGNAL_APP_ID');
        self::logDebug("Using AppID from ENV: $id");
        return $id ?: '8af20809-09e9-4ce1-9377-989b6b4e4600';
    }

    public static function getApiKey($pdo = null) {
        if ($pdo) {
            try {
                $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = 'onesignal_rest_api_key'");
                $stmt->execute();
                $val = $stmt->fetchColumn();
                if ($val) {
                    self::logDebug("Using API Key from DB");
                    return $val;
                }
            } catch (Exception $e) {}
        }
        self::loadEnv();
        $key = $_ENV['ONESIGNAL_API_KEY'] ?? $_SERVER['ONESIGNAL_API_KEY'] ?? getenv('ONESIGNAL_API_KEY') ?? '';
        self::logDebug("Using API Key from ENV");
        return $key;
    }

    private static function getAppUrl() {
        self::loadEnv();
        $url = $_ENV['APP_URL'] ?? $_SERVER['APP_URL'] ?? getenv('APP_URL');
        if (empty($url) || $url === 'https://chooseataxi.com') {
            $url = 'https://chooseataxi.com';
        }
        return rtrim($url, '/');
    }

    public static function send($pdo, $recipients, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        if (!$apiKey) return false;

        $recipientList = is_array($recipients) ? $recipients : [$recipients];
        
        $data['title'] = $title;
        $data['body'] = $body;

        $type = $data['type'] ?? 'default';
        $sound = 'other';
        if ($type == 'new_booking' || $type == 'booking') $sound = 'newbooking';
        if ($type == 'chat' || $type == 'chat_message') $sound = 'chat';
        if ($type == 'cancelled' || $type == 'cancel') $sound = 'cencel';

        // Use Filters (Tags) for multi-device reliability
        $filters = [];
        foreach ($recipientList as $index => $id) {
            if ($index > 0) $filters[] = ["operator" => "OR"];
            
            if (strpos($id, 'partner_') === 0) {
                $filters[] = ["field" => "tag", "key" => "partner_id", "relation" => "=", "value" => str_replace('partner_', '', $id)];
            } elseif (strpos($id, 'driver_') === 0) {
                $filters[] = ["field" => "tag", "key" => "driver_id", "relation" => "=", "value" => str_replace('driver_', '', $id)];
            }
        }

        $channel = 'booking_channel';
        if ($type == 'chat' || $type == 'chat_message') $channel = 'chat_channel';
        if ($type == 'cancelled' || $type == 'cancel') $channel = 'cancel_channel';

        $collapseId = 'booking_' . ($data['booking_id'] ?? 'general');
        if ($type == 'chat' || $type == 'chat_message') {
            $collapseId = 'chat_' . ($data['booking_id'] ?? 'gen') . '_' . time();
        }

        $fields = array(
            'app_id' => $appId,
            'filters' => $filters,
            'data' => $data,
            'contents' => array("en" => $body), 
            'headings' => array("en" => $title),
            'small_icon' => 'launcher_icon',
            'priority' => 10,
            'content_available' => true,
            'mutable_content' => true,
            'android_channel_id' => $channel,
            'android_sound' => $sound,
            'ios_sound' => $sound . '.mp3',
            'collapse_id' => $collapseId,
            'android_group' => $type == 'chat' ? 'chats' : 'bookings'
        );
        return self::executeCurl($fields, $apiKey);
    }

    public static function broadcastToAll($pdo, $title, $body, $data = [], $boxId = 1) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        if (!$apiKey) return false;

        $data['title'] = $title;
        $data['body'] = $body;

        $type = $data['type'] ?? 'default';
        $sound = 'other';
        if ($type == 'new_booking' || $type == 'booking') $sound = 'newbooking';
        if ($type == 'chat' || $type == 'chat_message') $sound = 'chat';
        if ($type == 'cancelled' || $type == 'cancel') $sound = 'cencel';

        // Map boxId to channel settings in DB
        $channelKey = 'onesignal_new_booking_channel';
        if ($boxId == 2) $channelKey = 'onesignal_chat_channel';
        if ($boxId == 3) $channelKey = 'onesignal_commission_channel';
        if ($boxId == 4) $channelKey = 'onesignal_accept_channel';
        if ($boxId == 5) $channelKey = 'onesignal_cancel_channel';
        if ($boxId == 6) $channelKey = 'onesignal_trip_status_channel';

        $androidChannelId = '';
        if ($pdo) {
            try {
                $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = ?");
                $stmt->execute([$channelKey]);
                $androidChannelId = $stmt->fetchColumn();
            } catch (Exception $e) {}
        }

        $channel = 'booking_channel';
        if ($type == 'chat' || $type == 'chat_message') $channel = 'chat_channel';
        if ($type == 'cancelled' || $type == 'cancel') $channel = 'cancel_channel';

        $collapseId = 'booking_' . ($data['booking_id'] ?? 'general');
        if ($type == 'chat' || $type == 'chat_message') {
            $collapseId = 'chat_' . ($data['booking_id'] ?? 'gen') . '_' . time();
        }

        $fields = array(
            'app_id' => $appId,
            'included_segments' => array('All'),
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title),
            'priority' => 10,
            'small_icon' => 'launcher_icon',
            'content_available' => true,
            'mutable_content' => true,
            'android_channel_id' => !empty($androidChannelId) ? $androidChannelId : $channel,
            'android_sound' => $sound,
            'ios_sound' => $sound . '.mp3',
            'collapse_id' => $collapseId,
            'android_group' => 'bookings',
            'android_group_message' => array("en" => "You have $[notif_count] new bookings")
        );

        return self::executeCurl($fields, $apiKey);
    }

    public static function sendBookingNotification($pdo, $booking) {
        $type = $booking['trip_type'] ?? 'Trip';
        $id = $booking['id'];
        $pickupFull = $booking['pickup_location'] ?? 'N/A';
        $dropFull = $booking['drop_location'] ?? 'N/A';
        $car = $booking['car_type_name'] ?? 'Any';
        $carImg = $booking['car_type_image'] ?? '';
        $date = $booking['start_date'] ?? date('d/m/Y');
        $time = $booking['start_time'] ?? '';

        $pickupCity = self::getCityOnly($pickupFull);
        $dropCity = self::getCityOnly($dropFull);

        $appUrl = self::getAppUrl();
        $fullImageUrl = !empty($carImg) ? $appUrl . '/' . ltrim($carImg, '/') : "";

        // Requested Format: {Trip Type} Booking (Id: {id})
        $title = "$type Booking (Id: $id)";
        
        // Body Format: 
        // Pickup City ➔ Drop City
        // Car Type: {Vehicle Type}
        // Date: {Date} @ Time: {Time}
        $arrow = "➔";
        $body = "$pickupCity $arrow $dropCity\nCar Type: $car\nDate: $date @ Time: $time";
        
        return self::broadcastToAll($pdo, $title, $body, [
            'type' => 'new_booking',
            'booking_id' => $id,
            'pickup_city' => $pickupCity,
            'drop_city' => $dropCity,
            'image_url' => $fullImageUrl
        ]);
    }

    private static function getCityOnly($location) {
        if (!$location || $location == '-') return 'N/A';
        $parts = array_map('trim', explode(',', $location));
        // Common logic: if last is India, city is usually 3rd from last.
        // If not enough parts, take the first one.
        $count = count($parts);
        if ($count >= 3 && strtolower(end($parts)) == 'india') {
            return $parts[$count - 3];
        } elseif ($count >= 2) {
            return $parts[$count - 2];
        }
        return $parts[0];
    }

    private static function logDebug($message) {
        $logFile = __DIR__ . '/../../tmp/onesignal_debug.log';
        $logDir = dirname($logFile);
        if (!is_dir($logDir)) @mkdir($logDir, 0777, true);
        $entry = "[" . date('Y-m-d H:i:s') . "] " . $message . PHP_EOL;
        @file_put_contents($logFile, $entry, FILE_APPEND);
    }

    private static function executeCurl($fields, $apiKey) {
        $fieldsJson = json_encode($fields);
        $keyPrefix = substr($apiKey, 0, 10);
        self::logDebug("Sending to OneSignal with AppId: " . $fields['app_id'] . " and Key Prefix: " . $keyPrefix);
        self::logDebug("Payload: " . $fieldsJson);
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
        } else {
            self::logDebug("OneSignal Response: " . $response);
        }

        return $response;
    }
}
