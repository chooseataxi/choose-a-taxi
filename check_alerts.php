<?php
require_once __DIR__ . '/includes/db.php';
$stmt = $pdo->query("SELECT * FROM partner_alert_settings");
print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
