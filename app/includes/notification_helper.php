<?php
/**
 * NotificationHelper - Updated to use OneSignal REST API
 */

class NotificationHelper {
    
    private static function loadEnv() {
        if (!isset($_ENV['ONESIGNAL_APP_ID'])) {
            try {
                $rootPath = realpath(__DIR__ . '/../../');
                $dotenv = Dotenv\Dotenv::createImmutable($rootPath);
                $dotenv->safeLoad();
            } catch (Exception $e) {}
        }
    }

    private static function getAppId() {
        self::loadEnv();
        return $_ENV['ONESIGNAL_APP_ID'] ?? '8af20809-09e9-4ce1-9377-989b6b4e4600';
    }

    private static function getApiKey() {
        self::loadEnv();
        return $_ENV['ONESIGNAL_API_KEY'] ?? ''; // Needs User Input
    }

    /**
     * Sends a notification to specific user(s) using OneSignal External IDs
     * $recipients: can be a single string (e.g. "partner_14") or an array of strings
     */
    public static function send($recipients, $title, $body, $data = []) {
        $appId = self::getAppId();
        $apiKey = self::getApiKey();

        if (!$apiKey) {
            error_log("OneSignal Error: REST API KEY is missing in .env");
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
            'small_icon' => 'ic_stat_onesignal_default' 
        );

        return self::executeCurl($fields, $apiKey);
    }

    /**
     * Sends notification to ALL users (broadcasting)
     */
    public static function broadcastToAll($pdo, $title, $body, $data = [], $exclude_id = 0) {
        $appId = self::getAppId();
        $apiKey = self::getApiKey();

        if (!$apiKey) return false;

        $fields = array(
            'app_id' => $appId,
            'included_segments' => array('All'),
            'data' => $data,
            'contents' => array("en" => $body),
            'headings' => array("en" => $title)
        );

        return self::executeCurl($fields, $apiKey);
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
