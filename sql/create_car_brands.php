<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $sql = "CREATE TABLE IF NOT EXISTS car_brands (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        logo VARCHAR(255),
        tagline VARCHAR(255),
        description LONGTEXT,
        seo_title VARCHAR(255),
        meta_description TEXT,
        meta_keywords TEXT,
        seo_schema LONGTEXT,
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    $pdo->exec($sql);
    echo "Table 'car_brands' created successfully!<br>";

} catch (PDOException $e) {
    die("Error creating table: " . $e->getMessage());
}
