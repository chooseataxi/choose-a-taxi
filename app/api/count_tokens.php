<?php
require_once __DIR__ . '/../../includes/db.php';
header('Content-Type: application/json');

$stmt = $pdo->query("SELECT COUNT(*) as count FROM partners WHERE fcm_token IS NOT NULL AND fcm_token != ''");
$pCount = $stmt->fetchColumn();

$stmt = $pdo->query("SELECT COUNT(*) as count FROM drivers WHERE fcm_token IS NOT NULL AND fcm_token != ''");
$dCount = $stmt->fetchColumn();

echo json_encode([
    'partner_tokens' => $pCount,
    'driver_tokens' => $dCount
]);
