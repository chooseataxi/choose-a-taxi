<?php
require_once 'includes/db.php';
$res = $pdo->query('SHOW COLUMNS FROM car_types')->fetchAll(PDO::FETCH_COLUMN);
print_r($res);
?>
