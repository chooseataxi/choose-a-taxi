<?php
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");

$id = '2627649';
$stmt = $pdo->prepare("SELECT id, start_date, start_time, status FROM partner_bookings WHERE id = ?");
$stmt->execute([$id]);
$row = $stmt->fetch();

$now = $pdo->query("SELECT NOW() as now")->fetch()['now'];
$parsed = $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%Y-%m-%d %h:%i %p') as parsed")->fetch()['parsed'];
if (!$parsed) {
    $parsed = $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%d-%m-%Y %h:%i %p') as parsed")->fetch()['parsed'];
}

echo json_encode([
    "booking" => $row,
    "db_now" => $now,
    "parsed_booking_time" => $parsed,
    "is_future" => ($parsed > $now),
    "timezone" => $pdo->query("SELECT @@session.time_zone")->fetchColumn()
]);
