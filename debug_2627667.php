<?php
require 'includes/db.php';
$stmt = $pdo->prepare('SELECT * FROM partner_bookings WHERE id = 2627667');
$stmt->execute();
$booking = $stmt->fetch();
header('Content-Type: application/json');
echo json_encode($booking, JSON_PRETTY_PRINT);
