<?php
require_once __DIR__ . '/../../vendor/autoload.php';

/**
 * Enterprise Notification Helper for OneSignal v5
 * Focused on External ID targeting and Channel Versioning
 */
class NotificationHelper {
    
    // Channel Version (MUST Match Flutter LocalNotificationService)
    private static $channelVersion = 'v2';

    private static function loadEnv() {
        if (!isset($_ENV['ONESIGNAL_APP_ID'])) {
            $rootPath = realpath(__DIR__ . '/../../');
            if (class_exists('Dotenv\Dotenv')) {
                $dotenv = Dotenv\Dotenv::createImmutable($rootPath);
                $dotenv->safeLoad();
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

    /**
     * Production Send Logic
     */
    public static function send($pdo, $recipients, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        if (!$apiKey) return false;

        $recipientList = is_array($recipients) ? $recipients : [$recipients];
        
        // 1. Precise Targeting (External User IDs)
        $externalIds = [];
        foreach ($recipientList as $id) {
            $externalIds[] = str_replace(['partner_', 'driver_'], '', $id);
        }

        $type = $data['type'] ?? 'default';
        $bookingId = $data['booking_id'] ?? 'gen';

        // 2. Channel Mapping with Versioning
        // This ensures settings updates propagate to Android
        $channelKey = 'general_channel_' . self::$channelVersion;
        if (strpos($type, 'booking') !== false) {
            $channelKey = 'onesignal_new_booking_channel_' . self::$channelVersion;
        } elseif (strpos($type, 'chat') !== false) {
            $channelKey = 'onesignal_chat_channel_' . self::$channelVersion;
        } elseif (strpos($type, 'cancel') !== false) {
            $channelKey = 'onesignal_cancel_channel_' . self::$channelVersion;
        }

        // 3. Enterprise Payload
        $fields = array(
            'app_id' => $appId,
            'include_external_user_ids' => $externalIds,
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title),
            'priority' => 10,
            'small_icon' => 'launcher_icon',
            'android_channel_id' => $channelKey,
            'ios_sound' => 'newbooking.mp3', // Map sound for iOS
            'collapse_id' => (strpos($type, 'chat') !== false) ? 'chat_'.$bookingId.'_'.time() : 'booking_'.$bookingId,
            'android_group' => (strpos($type, 'chat') !== false) ? "chat_$bookingId" : "booking_$bookingId",
        );

        return self::executeCurl($fields, $apiKey);
    }

    /**
     * Broadcast to all segments
     */
    public static function broadcastToAll($pdo, $title, $body, $data = []) {
        $appId = self::getAppId($pdo);
        $apiKey = self::getApiKey($pdo);
        
        $fields = array(
            'app_id' => $appId,
            'included_segments' => array('All'),
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title),
            'priority' => 10,
            'android_channel_id' => 'onesignal_new_booking_channel_' . self::$channelVersion,
        );

        return self::executeCurl($fields, $apiKey);
    }

    private static function executeCurl($fields, $apiKey) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'Authorization: Basic ' . $apiKey));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        // Logging
        $logDir = __DIR__ . '/../logs';
        if (!is_dir($logDir)) @mkdir($logDir, 0777, true);
        $logMsg = "[" . date('Y-m-d H:i:s') . "] HTTP $httpCode | Response: $response\n";
        @file_put_contents($logDir . '/notification_v2.log', $logMsg, FILE_APPEND);

        return $response;
    }
}
