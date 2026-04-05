<?php
require_once __DIR__ . '/../includes/db.php';
$stmt = $pdo->query("DESC bookings");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
?>
