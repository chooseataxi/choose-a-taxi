<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create search_logs table
    $sql = "CREATE TABLE IF NOT EXISTS search_logs (
        id INT AUTO_INCREMENT PRIMARY KEY,
        main_tab VARCHAR(50),
        trip_type VARCHAR(50) NOT NULL,
        pickup TEXT NOT NULL,
        drop_location TEXT,
        stops TEXT, -- Stored as JSON string
        start_date DATE,
        start_time TIME,
        return_date DATE,
        return_time TIME,
        phone VARCHAR(20),
        distance_km DECIMAL(8, 2) DEFAULT 0.00,
        ip_address VARCHAR(45),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

    $pdo->exec($sql);
    echo "search_logs table created or already exists.\n";

} catch (PDOException $e) {
    die("Error setting up search_logs table: " . $e->getMessage());
}
