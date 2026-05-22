<?php
$pdo = new PDO("mysql:host=localhost;dbname=u885872058_chooseataxi", "root", "");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

try {
    // 1. Add city_id to cars if it doesn't exist
    try {
        $pdo->query("SELECT city_id FROM cars LIMIT 1");
        echo "Column city_id already exists in cars.\n";
    } catch (PDOException $e) {
        $pdo->exec("ALTER TABLE cars ADD COLUMN city_id INT NULL AFTER type_id");
        echo "Added city_id column to cars table.\n";
    }

    // 2. Ensure "Local / Rental" exists in trip_types
    $stmt = $pdo->prepare("SELECT id FROM trip_types WHERE name = ?");
    $stmt->execute(['Local / Rental']);
    $tripType = $stmt->fetch();

    if (!$tripType) {
        $stmt = $pdo->prepare("INSERT INTO trip_types (name) VALUES (?)");
        $stmt->execute(['Local / Rental']);
        echo "Added 'Local / Rental' to trip_types.\n";
    } else {
        echo "Trip type 'Local / Rental' already exists.\n";
    }

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
