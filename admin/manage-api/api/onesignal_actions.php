<?php
require_once __DIR__ . '/../../../includes/db.php';
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$action = $_POST['action'] ?? '';

try {
    if ($action === 'save_settings') {
        $app_id = $_POST['onesignal_app_id'] ?? '';
        $api_key = $_POST['onesignal_rest_api_key'] ?? '';
        $channel_id = $_POST['onesignal_channel_id'] ?? '';
        $sound_name = $_POST['notification_sound'] ?? 'chat_notification_sound';

        // Ensure table exists
        $pdo->exec("CREATE TABLE IF NOT EXISTS site_settings (
            setting_key VARCHAR(100) PRIMARY KEY,
            setting_value TEXT,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )");

        // Save settings
        $settings = [
            'onesignal_app_id' => $app_id,
            'onesignal_rest_api_key' => $api_key,
            'onesignal_channel_id' => $channel_id,
            'notification_sound' => $sound_name
        ];

        foreach ($settings as $key => $val) {
            $stmt = $pdo->prepare("INSERT INTO site_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
            $stmt->execute([$key, $val]);
        }

        // Handle Sound File Upload
        if (!empty($_FILES['sound_file']['name'])) {
            $uploadDir = __DIR__ . '/../../../assets/sounds/';
            if (!is_dir($uploadDir)) @mkdir($uploadDir, 0777, true);
            
            $ext = pathinfo($_FILES['sound_file']['name'], PATHINFO_EXTENSION);
            $fileName = $sound_name . '.' . $ext;
            move_uploaded_file($_FILES['sound_file']['tmp_name'], $uploadDir . $fileName);
        }

        echo json_encode(['success' => true, 'message' => 'OneSignal settings updated successfully']);
    } 
    elseif ($action === 'send_test') {
        require_once __DIR__ . '/../../../app/includes/notification_helper.php';
        
        $title = $_POST['title'] ?? 'Test Notification';
        $message = $_POST['message'] ?? 'This is a test notification from admin panel';

        // Check if settings exist in DB
        $appId = NotificationHelper::getAppId($pdo);
        $apiKey = NotificationHelper::getApiKey($pdo);

        if (!$apiKey) {
            throw new Exception("OneSignal REST API Key is not configured. Please save settings first.");
        }

        // We use broadcastToAll for testing
        $response = NotificationHelper::broadcastToAll($pdo, $title, $message, ['type' => 'test']);
        $resData = json_decode($response, true);
        
        if ($resData && (isset($resData['id']) || isset($resData['recipients']))) {
            echo json_encode(['success' => true, 'message' => 'Test notification sent', 'response' => $resData]);
        } else {
            $errorMsg = $resData['errors'][0] ?? "Failed to send test notification. Check your API keys and OneSignal dashboard.";
            throw new Exception($errorMsg);
        }
    }
    else {
        throw new Exception("Unknown action");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
