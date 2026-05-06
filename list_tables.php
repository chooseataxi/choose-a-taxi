<?php
require 'includes/db.php';
$stmt = $pdo->query('SHOW TABLES');
echo json_encode($stmt->fetchAll(PDO::FETCH_COLUMN), JSON_PRETTY_PRINT);
