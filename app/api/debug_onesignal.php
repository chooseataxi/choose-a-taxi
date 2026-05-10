<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../includes/notification_helper.php';

header('Content-Type: application/json');

$action = $_GET['action'] ?? 'check';

if ($action == 'test_push') {
    $target = $_GET['target'] ?? ''; // e.g. partner_123
    if (!$target) die(json_encode(['error' => 'Target required']));
    
    $res = NotificationHelper::send($pdo, [$target], "Test Notification", "This is a direct test to $target", ['test' => true]);
    echo json_encode(['result' => json_decode($res, true) ?: $res]);
    exit;
}

$keys = ['onesignal_app_id', 'onesignal_rest_api_key'];
$settings = [];
foreach ($keys as $k) {
    $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = ?");
    $stmt->execute([$k]);
    $settings[$k] = $stmt->fetchColumn() ?: "NOT SET";
}

echo json_encode([
    'db_settings' => $settings,
    'helper_app_id' => NotificationHelper::getAppId($pdo),
    'helper_api_key' => !empty(NotificationHelper::getApiKey($pdo)) ? "EXISTS (starts with " . substr(NotificationHelper::getApiKey($pdo), 0, 5) . ")" : "MISSING"
], JSON_PRETTY_PRINT);
