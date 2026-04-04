<?php
// Test File
require_once __DIR__ . '/../../includes/db.php';

try {
    $sql = "INSERT INTO partner_bookings (
        partner_id, booking_type, pickup_location, drop_location, stops, 
        car_type, start_date, start_time, end_date, end_time, 
        pricing_option, total_amount, commission, toll_tax, parking, note, preferences
    ) VALUES (
        ?, ?, ?, ?, ?, 
        ?, ?, ?, ?, ?, 
        ?, ?, ?, ?, ?, ?, ?
    )";
    $stmt = $pdo->prepare($sql);
    $res = $stmt->execute([
        1, 'One Way', 'Delhi', 'Agra', json_encode([]),
        '1', '2026-04-10', '10:00 AM', null, null,
        'quote', null, null, 'Included', 'Included', 'Test Note', json_encode([])
    ]);
    if ($res) echo "SUCCESS";
} catch(PDOException $e) {
    echo "ERROR: " . $e->getMessage();
}
