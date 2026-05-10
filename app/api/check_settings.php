<?php
require_once __DIR__ . '/../../includes/db.php';
header('Content-Type: application/json');

$keys = [
    'onesignal_app_id',
    'onesignal_rest_api_key',
    'onesignal_new_booking_channel',
    'onesignal_chat_channel',
    'onesignal_cancel_channel',
    'onesignal_commission_channel',
    'onesignal_new_booking_channel_v2',
    'onesignal_chat_channel_v2',
    'onesignal_cancel_channel_v2',
    'onesignal_commission_channel_v2'
];

$results = [];
foreach ($keys as $k) {
    $stmt = $pdo->prepare("SELECT setting_value FROM site_settings WHERE setting_key = ?");
    $stmt->execute([$k]);
    $results[$k] = $stmt->fetchColumn() ?: "NOT SET";
}

echo json_encode($results, JSON_PRETTY_PRINT);
