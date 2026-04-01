<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $stmt = $pdo->query("SELECT id, name, image FROM cars");
    $cars = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "Total Cars: " . count($cars) . "\n";
    foreach ($cars as $car) {
        echo "ID: " . $car['id'] . " | Name: " . $car['name'] . " | Image: [" . $car['image'] . "]\n";
        if (!empty($car['image'])) {
            $path = __DIR__ . "/../uploads/cars/" . $car['image'];
            echo " - Path: $path\n";
            echo " - Exists: " . (file_exists($path) ? "YES" : "NO") . "\n";
        }
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
