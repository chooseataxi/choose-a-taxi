<?php
/**
 * NotificationHelper - Handles Sending Firebase Cloud Messages (FCM) 
 * Supports both Legacy (Server Key) and recommended for this project setup.
 */

class NotificationHelper {
    
    // Set your FCM Server Key in the .env file as FIREBASE_SERVER_KEY
    private static function getServerKey() {
        return $_ENV['FIREBASE_SERVER_KEY'] ?? 'YOUR_FCM_SERVER_KEY_HERE';
    }

    /**
     * Sends a notification to a specific FCM token
     */
    public static function send($token, $title, $body, $data = []) {
        if (empty($token)) return false;

        $url = 'https://fcm.googleapis.com/fcm/send';
        
        $notification = [
            'title' => $title,
            'body' => $body,
            'sound' => 'chat_notification_sound.wav', // Custom sound from assets/raw
            'android_channel_id' => 'high_importance_channel',
        ];

        $payload = [
            'to' => $token,
            'notification' => $notification,
            'data' => array_merge($data, [
                'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
            ]),
            'priority' => 'high'
        ];

        return self::executeCurl($url, $payload);
    }

    /**
     * Sends a notification to all active partners/drivers (e.g. for new bookings)
     */
    public static function broadcastToAll($pdo, $title, $body, $data = [], $exclude_id = 0) {
        // Collect all tokens from both partners and drivers
        $tokens = [];
        
        // Partners
        $stmt = $pdo->prepare("SELECT fcm_token FROM partners WHERE fcm_token IS NOT NULL AND id != ?");
        $stmt->execute([$exclude_id]);
        while ($row = $stmt->fetch()) {
            $tokens[] = $row['fcm_token'];
        }

        // Drivers
        $stmt = $pdo->prepare("SELECT fcm_token FROM drivers WHERE fcm_token IS NOT NULL");
        $stmt->execute();
        while ($row = $stmt->fetch()) {
            $tokens[] = $row['fcm_token'];
        }

        if (empty($tokens)) return true;

        // FCM supports up to 1000 tokens per multicast request
        $chunks = array_chunk($tokens, 1000);
        foreach ($chunks as $chunk) {
            self::sendMulticast($chunk, $title, $body, $data);
        }
        return true;
    }

    private static function sendMulticast($registration_ids, $title, $body, $data) {
        $url = 'https://fcm.googleapis.com/fcm/send';
        
        $payload = [
            'registration_ids' => $registration_ids,
            'notification' => [
                'title' => $title,
                'body' => $body,
                'sound' => 'chat_notification_sound.wav',
                'android_channel_id' => 'high_importance_channel',
            ],
            'data' => $data,
            'priority' => 'high'
        ];

        return self::executeCurl($url, $payload);
    }

    private static function executeCurl($url, $payload) {
        $serverKey = self::getServerKey();
        $headers = [
            'Authorization: key=' . $serverKey,
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
        curl_close($ch);
        
        return $result;
    }
}
