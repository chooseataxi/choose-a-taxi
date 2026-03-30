<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create partners table
    $sql = "CREATE TABLE IF NOT EXISTS partners (
        id INT AUTO_INCREMENT PRIMARY KEY,
        full_name VARCHAR(100),
        email VARCHAR(100) UNIQUE,
        mobile VARCHAR(15) UNIQUE NOT NULL,
        password VARCHAR(255),
        
        -- Verification Status
        mobile_verified TINYINT(1) DEFAULT 0,
        aadhaar_verified TINYINT(1) DEFAULT 0,
        
        -- eKYC Details
        aadhaar_number VARCHAR(12) UNIQUE,
        surepass_client_id VARCHAR(100),
        aadhaar_pdf_link TEXT,
        
        -- Roles (Stored as JSON or comma separated)
        roles VARCHAR(255) DEFAULT 'user', -- user,partner,driver
        
        status ENUM('Pending', 'Active', 'Suspended') DEFAULT 'Pending',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    $pdo->exec($sql);
    echo "Partners table created or already exists.\n";

} catch (PDOException $e) {
    die("Error setting up partners table: " . $e->getMessage());
}
