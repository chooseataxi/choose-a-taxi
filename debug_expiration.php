<?php
require_once __DIR__ . '/includes/db.php';
header("Content-Type: application/json");

$id = '2627669';
$stmt = $pdo->prepare("SELECT id, start_date, start_time, status FROM partner_bookings WHERE id = ?");
$stmt->execute([$id]);
$row = $stmt->fetch();

if (!$row) {
    echo json_encode(["error" => "Booking not found"]);
    exit;
}

$now = $pdo->query("SELECT NOW() as now")->fetch()['now'];
$parsed = $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%d-%m-%Y %h:%i %p') as parsed")->fetch()['parsed'];

echo json_encode([
    "booking" => $row,
    "db_now" => $now,
    "parsed_booking_time" => $parsed,
    "diff_seconds" => strtotime($now) - strtotime($parsed),
    "should_be_expired_if_0_grace" => (strtotime($now) > strtotime($parsed)),
    "should_be_expired_if_2h_grace" => (strtotime($now) > (strtotime($parsed) + 7200))
], JSON_PRETTY_PRINT);
