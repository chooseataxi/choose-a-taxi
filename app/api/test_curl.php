<?php
$data = [
    "partner_id" => 1,
    "booking_type" => "One Way Trip", // We test the exact string mapping
    "pickup_location" => "Delhi",
    "drop_location" => "Agra",
    "car_type" => "1",
    "start_date" => "2026-04-10",
    "start_time" => "10:00 AM",
    "pricing_option" => "quote"
];

$ch = curl_init('https://chooseataxi.com/app/api/partner_bookings_api.php?action=create_booking');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // Crucial for local dev environments
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);

$response = curl_exec($ch);
$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
if(curl_errno($ch)) {
    echo 'Curl error: ' . curl_error($ch);
}
curl_close($ch);

echo "HTTP Code: " . $httpcode . "\n";
echo "Response: " . $response . "\n";
