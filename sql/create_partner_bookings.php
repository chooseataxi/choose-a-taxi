<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $sql = "CREATE TABLE IF NOT EXISTS partner_bookings (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        booking_type VARCHAR(100) NOT NULL,
        pickup_location TEXT,
        drop_location TEXT,
        stops JSON,
        car_type VARCHAR(255),
        start_date DATE,
        start_time VARCHAR(50),
        end_date DATE NULL,
        end_time VARCHAR(50) NULL,
        pricing_option VARCHAR(50) DEFAULT 'quote',
        total_amount DECIMAL(10,2) NULL,
        commission DECIMAL(10,2) NULL,
        distance_km DECIMAL(10,2) NULL,
        toll_tax VARCHAR(20) DEFAULT 'Included',
        parking VARCHAR(20) DEFAULT 'Included',
        note TEXT NULL,
        preferences JSON NULL,
        status VARCHAR(50) DEFAULT 'Open',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    $pdo->exec($sql);
    echo "Table 'partner_bookings' created successfully!<br>";

} catch (PDOException $e) {
    die("Error creating table: " . $e->getMessage());
}
