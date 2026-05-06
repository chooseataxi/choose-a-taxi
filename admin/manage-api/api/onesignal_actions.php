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
        // Save settings
        $settings = [
            'onesignal_app_id' => $_POST['onesignal_app_id'] ?? '',
            'onesignal_rest_api_key' => $_POST['onesignal_rest_api_key'] ?? '',
            'onesignal_new_booking_channel' => $_POST['onesignal_new_booking_channel'] ?? '',
            'onesignal_chat_channel' => $_POST['onesignal_chat_channel'] ?? '',
            'onesignal_commission_channel' => $_POST['onesignal_commission_channel'] ?? '',
            'onesignal_accept_channel' => $_POST['onesignal_accept_channel'] ?? '',
            'onesignal_cancel_channel' => $_POST['onesignal_cancel_channel'] ?? '',
            'onesignal_trip_status_channel' => $_POST['onesignal_trip_status_channel'] ?? ''
        ];

        $saved_count = 0;
        foreach ($settings as $key => $val) {
            $stmt = $pdo->prepare("INSERT INTO site_settings (setting_key, setting_value) VALUES (?, ?) 
                                   ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
            if ($stmt->execute([$key, $val])) {
                $saved_count++;
            }
        }


        echo json_encode(['success' => true, 'message' => "Settings updated successfully ($saved_count fields)"]);
    } 
    elseif ($action === 'send_test') {
        require_once __DIR__ . '/../../../app/includes/notification_helper.php';
        
        $box = $_POST['box'] ?? 1;
        $title = $_POST['title'] ?? 'Test Notification';
        $message = $_POST['message'] ?? 'This is a test notification from admin panel';

        // Check if settings exist in DB
        $apiKey = NotificationHelper::getApiKey($pdo);

        if (!$apiKey) {
            throw new Exception("OneSignal REST API Key is not configured. Please save settings first.");
        }

        // We use broadcastToAll for testing
        $response = NotificationHelper::broadcastToAll($pdo, $title, $message, ['type' => 'test'], $box);
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
