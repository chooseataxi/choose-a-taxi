<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $sql = "ALTER TABLE partner_bookings 
            ADD COLUMN IF NOT EXISTS approach_type ENUM('first_driver', 'manual_selection') DEFAULT 'first_driver',
            ADD COLUMN IF NOT EXISTS allow_calls TINYINT(1) DEFAULT 1";
    
    $pdo->exec($sql);
    echo "Migration successful: partner_bookings table updated with approach_type and allow_calls.\n";
} catch (PDOException $e) {
    if (strpos($e->getMessage(), 'Duplicate column name') !== false) {
        echo "Migration already applied or columns exist.\n";
    } else {
        echo "Error: " . $e->getMessage() . "\n";
    }
}
