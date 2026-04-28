<?php
require_once __DIR__ . '/../includes/db.php';
$stmt = $pdo->query("SELECT * FROM site_settings");
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows, JSON_PRETTY_PRINT);
