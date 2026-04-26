<?php
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");

$id = '2627649';
$stmt = $pdo->prepare("SELECT id, start_date, start_time, status, NOW() as current_time FROM partner_bookings WHERE id = ?");
$stmt->execute([$id]);
$row = $stmt->fetch();

echo json_encode([
    "booking" => $row,
    "parsing_1" => $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%d-%m-%Y %h:%i %p') as parsed")->fetch()['parsed'],
    "parsing_2" => $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%Y-%m-%d %h:%i %p') as parsed")->fetch()['parsed'],
    "parsing_3" => $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%d-%m-%Y %H:%i') as parsed")->fetch()['parsed'],
    "parsing_4" => $pdo->query("SELECT STR_TO_DATE(CONCAT('{$row['start_date']}', ' ', '{$row['start_time']}'), '%Y-%m-%d %H:%i') as parsed")->fetch()['parsed'],
]);
