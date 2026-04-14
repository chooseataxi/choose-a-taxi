<?php
require_once __DIR__ . '/../../includes/db.php';
header('Content-Type: application/json');

$stmt = $pdo->query("SELECT id, full_name, mobile, fcm_token FROM partners WHERE fcm_token IS NOT NULL AND fcm_token != ''");
$partners = $stmt->fetchAll(PDO::FETCH_ASSOC);

$stmt = $pdo->query("SELECT id, full_name, phone, fcm_token FROM drivers WHERE fcm_token IS NOT NULL AND fcm_token != ''");
$drivers = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode([
    'partners' => $partners,
    'drivers' => $drivers
], JSON_PRETTY_PRINT);
