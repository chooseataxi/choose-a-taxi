<?php
require 'd:/wamp/www/chooseataxi.com/includes/db.php';
try {
    // Check if column exists
    $check = $pdo->query("SHOW COLUMNS FROM booking_chats LIKE 'quote_status'");
    if (!$check->fetch()) {
        $pdo->exec("ALTER TABLE booking_chats ADD COLUMN quote_status VARCHAR(20) DEFAULT 'active' AFTER payload");
        echo "Column 'quote_status' added successfully.\n";
    } else {
        echo "Column 'quote_status' already exists.\n";
    }

    // Add performance index for chats
    try {
        $pdo->exec("CREATE INDEX IF NOT EXISTS idx_chat_lookup ON booking_chats(booking_id, sender_id, receiver_id)");
        echo "Index 'idx_chat_lookup' created or already exists.\n";
    } catch (Exception $e) {
        // Some older MySQL versions don't support IF NOT EXISTS for indexes
        $pdo->exec("CREATE INDEX idx_chat_lookup ON booking_chats(booking_id, sender_id, receiver_id)");
        echo "Index 'idx_chat_lookup' created.\n";
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
