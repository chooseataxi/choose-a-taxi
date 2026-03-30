<?php
require_once __DIR__ . '/../includes/db.php';
$stmt = $pdo->query('SELECT id, name, image FROM car_types');
while($row = $stmt->fetch()) {
    echo "ID: " . $row['id'] . " | Name: " . $row['name'] . " | Image: " . ($row['image'] ?? 'NULL') . "\n";
}
