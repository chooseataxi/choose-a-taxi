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
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
