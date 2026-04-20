<?php
require 'app/config/database.php';
$stmt = $pdo->query("SELECT id, start_date, status FROM partner_bookings ORDER BY id DESC LIMIT 10");
print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
?>
