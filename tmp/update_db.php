<?php
require_once __DIR__ . '/../includes/db.php';
try {
    // Add is_read if not exists
    $pdo->exec("ALTER TABLE booking_chats ADD COLUMN IF NOT EXISTS is_read TINYINT(1) DEFAULT 0");
    echo "SUCCESS: Database updated.";
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage();
}
