<?php
require_once __DIR__ . '/includes/db.php';
$stmt = $pdo->query("SHOW TABLES LIKE 'site_settings'");
echo $stmt->fetchColumn() ? "site_settings table exists\n" : "site_settings table NOT exists\n";
if ($stmt->fetchColumn()) {
    $stmt = $pdo->query("SELECT * FROM site_settings");
    print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
}
