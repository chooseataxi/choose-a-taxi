<?php
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");

$id = '2627649';
$stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Open' WHERE id = ? AND status = 'Expired'");
$stmt->execute([$id]);

echo json_encode(["status" => "success", "message" => "Booking #$id has been reset to Open."]);
