<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create car_types table
    $pdo->exec("CREATE TABLE IF NOT EXISTS car_types (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE,
        passengers INT DEFAULT 4,
        luggage INT DEFAULT 2,
        base_price DECIMAL(10,2) DEFAULT 0.00,
        image VARCHAR(255),
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. Insert default types
    $defaultTypes = [
        ['Sedan', 4, 3, 12.00],
        ['Mini / Hatchback', 4, 1, 9.00],
        ['SUV / MUV', 7, 5, 18.00],
        ['Luxary / Premium', 4, 4, 25.00]
    ];

    $stmt = $pdo->prepare("INSERT IGNORE INTO car_types (name, passengers, luggage, base_price) VALUES (?, ?, ?, ?)");
    foreach ($defaultTypes as $type) {
        $stmt->execute($type);
    }

    echo "Car types table and default data created successfully!\n";
} catch (PDOException $e) {
    echo "Error creating table: " . $e->getMessage() . "\n";
}
