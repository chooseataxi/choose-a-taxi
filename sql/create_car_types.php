<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create car_types table
    $pdo->exec("CREATE TABLE IF NOT EXISTS car_types (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE,
        passengers INT DEFAULT 4,
        luggage INT DEFAULT 2,
        image VARCHAR(255),
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. Insert default types
    $defaultTypes = [
        ['Sedan', 4, 3],
        ['Mini / Hatchback', 4, 1],
        ['SUV / MUV', 7, 5],
        ['Luxary / Premium', 4, 4]
    ];

    $stmt = $pdo->prepare("INSERT IGNORE INTO car_types (name, passengers, luggage) VALUES (?, ?, ?)");
    foreach ($defaultTypes as $type) {
        $stmt->execute($type);
    }

    echo "Car types table and default data created successfully!\n";
} catch (PDOException $e) {
    echo "Error creating table: " . $e->getMessage() . "\n";
}
