<?php
require 'includes/db.php';
$stmt = $pdo->query('DESCRIBE cars');
echo json_encode($stmt->fetchAll(), JSON_PRETTY_PRINT);
