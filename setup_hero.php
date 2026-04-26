<?php
require_once __DIR__ . '/includes/db.php';

try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS hero_slides (
        id INT AUTO_INCREMENT PRIMARY KEY,
        image_path VARCHAR(255) NOT NULL,
        title VARCHAR(100),
        link_url VARCHAR(255),
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )");
    echo "Table 'hero_slides' checked/created successfully.";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
