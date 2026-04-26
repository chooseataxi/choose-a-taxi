<?php
require_once __DIR__ . '/../includes/db.php';
$stmt = $pdo->query("SELECT id, car_type FROM partner_bookings LIMIT 5");
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($results);
