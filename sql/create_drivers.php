<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create drivers table
    $sql = "CREATE TABLE IF NOT EXISTS drivers (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        full_name VARCHAR(100) NOT NULL,
        license_number VARCHAR(50) UNIQUE NOT NULL,
        dob DATE NOT NULL,
        doe DATE, -- Date of Expiry
        doi DATE, -- Date of Issuance
        gender ENUM('M', 'F', 'X'),
        father_or_husband_name VARCHAR(100),
        state VARCHAR(100),
        permanent_address TEXT,
        profile_image_path TEXT,
        
        -- Meta
        blood_group VARCHAR(10),
        vehicle_classes JSON, -- Storage for MCWG, LMV-NT, etc.
        
        status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active',
        is_partner_self TINYINT(1) DEFAULT 0,
        
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        
        FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    $pdo->exec($sql);
    echo "Drivers table created successfully.\n";

} catch (PDOException $e) {
    die("Error setting up drivers table: " . $e->getMessage());
}
