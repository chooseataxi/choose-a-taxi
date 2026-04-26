<?php
require_once __DIR__ . '/../../includes/db.php';
$stmt = $pdo->query("SELECT * FROM car_types");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
