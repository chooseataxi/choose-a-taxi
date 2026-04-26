<?php
require_once __DIR__ . '/../../includes/db.php';
$stmt = $pdo->query("SHOW TABLES");
echo json_encode($stmt->fetchAll(PDO::FETCH_COLUMN));
