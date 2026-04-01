<?php
require_once __DIR__ . '/../../../includes/db.php';

header('Content-Type: application/json');

try {
    // 1. Create Trip Types Table
    $pdo->exec("CREATE TABLE IF NOT EXISTS trip_types (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. Seed Trip Types
    $types = ['Local', 'Outstation', 'One Way', 'Round Trip'];
    foreach ($types as $type) {
        $check = $pdo->prepare("SELECT id FROM trip_types WHERE name = ?");
        $check->execute([$type]);
        if (!$check->fetch()) {
            $stmt = $pdo->prepare("INSERT INTO trip_types (name) VALUES (?)");
            $stmt->execute([$type]);
        }
    }

    // 3. Create Cars Table
    $pdo->exec("CREATE TABLE IF NOT EXISTS cars (
        id INT AUTO_INCREMENT PRIMARY KEY,
        brand_id INT NOT NULL,
        type_id INT NOT NULL,
        trip_type_id INT NOT NULL,
        name VARCHAR(255) NOT NULL,
        model VARCHAR(100),
        base_fare DECIMAL(10, 2) DEFAULT 0.00,
        min_km INT DEFAULT 0,
        extra_km_price DECIMAL(10, 2) DEFAULT 0.00,
        description TEXT,
        youtube_url TEXT,
        image VARCHAR(255),
        seo_title VARCHAR(255),
        seo_description TEXT,
        meta_keywords TEXT,
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (brand_id) REFERENCES car_brands(id) ON DELETE CASCADE,
        FOREIGN KEY (type_id) REFERENCES car_types(id) ON DELETE CASCADE,
        FOREIGN KEY (trip_type_id) REFERENCES trip_types(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    echo json_encode(['success' => true, 'message' => 'Database tables created and seeded successfully!']);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Database Error: ' . $e->getMessage()]);
}
