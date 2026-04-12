<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $sql = "ALTER TABLE partners 
            ADD COLUMN IF NOT EXISTS aadhaar_front_link VARCHAR(255) NULL AFTER rc_book_link,
            ADD COLUMN IF NOT EXISTS aadhaar_back_link VARCHAR(255) NULL AFTER aadhaar_front_link,
            ADD COLUMN IF NOT EXISTS selfie_link VARCHAR(255) NULL AFTER aadhaar_back_link";
    
    $pdo->exec($sql);
    echo "Migration successful: Partners table updated with Aadhar and Selfie columns.\n";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
