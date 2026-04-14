<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../includes/notification_helper.php';

header('Content-Type: application/json');

$res = NotificationHelper::broadcastToAll($pdo, "Test Notification", "Checking OneSignal integration", ['test' => true]);

echo json_encode([
    'result' => json_decode($res, true) ?: $res,
    'status' => 'attempted'
]);
