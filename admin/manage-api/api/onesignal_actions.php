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

        if (empty($app_id) || empty($api_key)) {
            throw new Exception("App ID and API Key are required");
        }

        $stmt = $pdo->prepare("INSERT INTO site_settings (setting_key, setting_value) 
                               VALUES ('onesignal_app_id', ?), ('onesignal_rest_api_key', ?)
                               ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
        
        $pdo->prepare("UPDATE site_settings SET setting_value = ? WHERE setting_key = 'onesignal_app_id'")->execute([$app_id]);
        $pdo->prepare("UPDATE site_settings SET setting_value = ? WHERE setting_key = 'onesignal_rest_api_key'")->execute([$api_key]);

        echo json_encode(['success' => true, 'message' => 'OneSignal settings updated successfully']);
    } 
    elseif ($action === 'send_test') {
        require_once __DIR__ . '/../../../app/includes/notification_helper.php';
        
        $title = $_POST['title'] ?? 'Test Notification';
        $message = $_POST['message'] ?? 'This is a test notification from admin panel';

        // We use broadcastToAll for testing
        $response = NotificationHelper::broadcastToAll($pdo, $title, $message, ['type' => 'test']);
        
        if ($response) {
            echo json_encode(['success' => true, 'message' => 'Test notification sent', 'response' => json_decode($response, true)]);
        } else {
            throw new Exception("Failed to send test notification. Check your API keys.");
        }
    }
    else {
        throw new Exception("Unknown action");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
