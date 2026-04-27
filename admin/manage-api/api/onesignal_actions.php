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

        // Ensure table exists
        $pdo->exec("CREATE TABLE IF NOT EXISTS site_settings (
            setting_key VARCHAR(100) PRIMARY KEY,
            setting_value TEXT,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )");

        // Insert or Update app_id
        $stmt = $pdo->prepare("INSERT INTO site_settings (setting_key, setting_value) VALUES ('onesignal_app_id', ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
        $stmt->execute([$app_id]);

        // Insert or Update api_key
        $stmt = $pdo->prepare("INSERT INTO site_settings (setting_key, setting_value) VALUES ('onesignal_rest_api_key', ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
        $stmt->execute([$api_key]);

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
