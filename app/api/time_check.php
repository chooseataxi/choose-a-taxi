<?php
require_once __DIR__ . '/../../includes/db.php';
echo json_encode([
    "php_time" => date('Y-m-d H:i:s'),
    "db_time" => $pdo->query("SELECT NOW()")->fetchColumn(),
    "db_timezone" => $pdo->query("SELECT @@session.time_zone")->fetchColumn(),
    "system_timezone" => $pdo->query("SELECT @@system_time_zone")->fetchColumn()
]);
