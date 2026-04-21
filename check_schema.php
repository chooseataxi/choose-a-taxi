<?php
require 'includes/db.php';
$stmt = $pdo->query("DESCRIBE accepted_bookings");
print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
?>
