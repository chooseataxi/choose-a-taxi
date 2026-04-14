<?php
require_once __DIR__ . '/../../includes/db.php';
header('Content-Type: application/json');

$id = 14;

$stmt = $pdo->prepare("SELECT id, full_name, fcm_token, 'partner' as role FROM partners WHERE id = ?");
$stmt->execute([$id]);
$p = $stmt->fetch();

$stmt = $pdo->prepare("SELECT id, full_name, fcm_token, 'driver' as role FROM drivers WHERE id = ?");
$stmt->execute([$id]);
$d = $stmt->fetch();

echo json_encode([
    'partner' => $p,
    'driver' => $d
], JSON_PRETTY_PRINT);
