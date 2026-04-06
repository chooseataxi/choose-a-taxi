<?php
require_once __DIR__ . '/../includes/db.php';
try {
    // Add is_read if not exists
    $pdo->exec("ALTER TABLE booking_chats ADD COLUMN is_read TINYINT(1) DEFAULT 0");
    echo "SUCCESS: Database updated.";
} catch (PDOException $e) {
    if (strpos($e->getMessage(), 'Duplicate column name') !== false) {
        echo "SUCCESS: Column already exists.";
    } else {
        echo "ERROR: " . $e->getMessage();
    }
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage();
}
