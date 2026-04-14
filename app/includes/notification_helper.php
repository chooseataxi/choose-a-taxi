<?php
/**
 * NotificationHelper - Handles Sending Firebase Cloud Messages (FCM) 
 * Updated to use FCM HTTP v1 API with Service Account
 */

require_once __DIR__ . '/../../vendor/autoload.php';

use Google\Auth\Credentials\ServiceAccountCredentials;
use Google\Auth\HttpHandler\HttpHandlerFactory;

class NotificationHelper {
    
    private static $accessToken = null;
    private static $tokenExpiry = 0;

    private static function loadEnv() {
        if (!isset($_ENV['FIREBASE_PROJECT_ID'])) {
            try {
                $dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../../');
                $dotenv->safeLoad();
            } catch (Exception $e) {}
        }
    }

    private static function getAccessToken() {
        self::loadEnv();
        
        // Return cached token if valid
        if (self::$accessToken && time() < self::$tokenExpiry - 60) {
            return self::$accessToken;
        }

        $jsonFile = $_ENV['FIREBASE_SERVICE_ACCOUNT_JSON'] ?? 'choose-a-taxi-india-00fd9479b1a4.json';
        $path = __DIR__ . '/../../' . $jsonFile;

        if (!file_exists($path)) {
            error_log("FCM Error: Service account file not found at $path");
            return null;
        }

        try {
            $scopes = ['https://www.googleapis.com/auth/cloud-platform'];
            $credentials = new ServiceAccountCredentials($scopes, $path);
            $token = $credentials->fetchAuthToken(HttpHandlerFactory::build());
            
            self::$accessToken = $token['access_token'];
            self::$tokenExpiry = time() + $token['expires_in'];
            
            return self::$accessToken;
        } catch (Exception $e) {
            error_log("FCM Token Error: " . $e->getMessage());
            return null;
        }
    }

    private static function getProjectId() {
        self::loadEnv();
        return $_ENV['FIREBASE_PROJECT_ID'] ?? 'choose-a-taxi-india';
    }

    /**
     * Sends a notification to a specific FCM token
     */
    public static function send($token, $title, $body, $data = []) {
        if (empty($token)) {
            $logFile = __DIR__ . '/../../tmp/fcm_v1_log.json';
            $logData = [
                'timestamp' => date('Y-m-d H:i:s'),
                'error' => 'FCM Send Failed: Token is empty or null',
                'title' => $title,
                'data' => $data
            ];
            file_put_contents($logFile, json_encode($logData, JSON_PRETTY_PRINT) . PHP_EOL . "---" . PHP_EOL, FILE_APPEND);
            return false;
        }

        $projectId = self::getProjectId();
        $url = "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";
        
        $accessToken = self::getAccessToken();
        if (!$accessToken) return false;

        // HTTP v1 Structure
        $message = [
            'message' => [
                'token' => $token,
                'notification' => [
                    'title' => $title,
                    'body' => $body,
                ],
                'android' => [
                    'notification' => [
                        'sound' => 'chat_notification_sound',
                        'channel_id' => 'high_importance_channel',
                    ],
                    'priority' => 'high'
                ],
                'data' => array_map('strval', $data) // Ensure all data values are strings
            ]
        ];

        return self::executeCurl($url, $message, $accessToken);
    }

    /**
     * Sends a notification to all active partners/drivers (e.g. for new bookings)
     */
    public static function broadcastToAll($pdo, $title, $body, $data = [], $exclude_id = 0) {
        $tokens = [];
        
        // Partners
        $stmt = $pdo->prepare("SELECT fcm_token FROM partners WHERE fcm_token IS NOT NULL AND fcm_token != '' AND id != ?");
        $stmt->execute([$exclude_id]);
        while ($row = $stmt->fetch()) {
            $tokens[] = $row['fcm_token'];
        }

        // Drivers
        $stmt = $pdo->prepare("SELECT fcm_token FROM drivers WHERE fcm_token IS NOT NULL AND fcm_token != ''");
        $stmt->execute();
        while ($row = $stmt->fetch()) {
            $tokens[] = $row['fcm_token'];
        }

        if (empty($tokens)) return true;

        // HTTP v1 does not support multicast with registration_ids. 
        // We must loop or use topics. For this scale, looping is fine.
        foreach ($tokens as $token) {
            self::send($token, $title, $body, $data);
        }
        return true;
    }

    private static function executeCurl($url, $payload, $accessToken) {
        $headers = [
            'Authorization: Bearer ' . $accessToken,
            'Content-Type: application/json'
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));

        $result = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        // Detailed Logging for debugging
        $logFile = __DIR__ . '/../../tmp/fcm_v1_log.json';
        $logDir = dirname($logFile);
        if (!is_dir($logDir)) @mkdir($logDir, 0777, true);
        
        $logData = [
            'timestamp' => date('Y-m-d H:i:s'),
            'url' => $url,
            'http_code' => $httpCode,
            'payload' => $payload,
            'response' => json_decode($result, true) ?: $result
        ];
        file_put_contents($logFile, json_encode($logData, JSON_PRETTY_PRINT) . PHP_EOL . "---" . PHP_EOL, FILE_APPEND);
        
        return $result;
    }
}
