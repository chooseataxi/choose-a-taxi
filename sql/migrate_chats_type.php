<?php
require_once __DIR__ . '/../includes/db.php';

try {
    echo "Starting migration...\n";
    
    // 1. Alter type column from ENUM to VARCHAR
    $pdo->exec("ALTER TABLE booking_chats MODIFY COLUMN type VARCHAR(50) DEFAULT 'text'");
    echo "Table 'booking_chats' modified successfully: 'type' column changed to VARCHAR(50).\n";
    
    // 2. Also ensure payload is JSON (it should already be, but good to check)
    // No change needed as it was already JSON NULL in original schema.

    echo "Migration completed successfully.\n";
} catch (PDOException $e) {
    die("Migration failed: " . $e->getMessage());
}
?>
