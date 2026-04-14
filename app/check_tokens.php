<?php
require_once __DIR__ . '/includes/db.php';
$stmt = $pdo->query("SELECT id, full_name, mobile, fcm_token FROM partners WHERE fcm_token IS NOT NULL");
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($results, JSON_PRETTY_PRINT);
