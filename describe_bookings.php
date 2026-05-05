<?php
require 'includes/db.php';
$stmt = $pdo->query('DESCRIBE partner_bookings');
header('Content-Type: application/json');
echo json_encode($stmt->fetchAll(), JSON_PRETTY_PRINT);
