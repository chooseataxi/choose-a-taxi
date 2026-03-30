<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $pdo->exec("ALTER TABLE car_types DROP COLUMN IF EXISTS base_price");
    // Fallback for older MySQL versions that don't support DROP COLUMN IF EXISTS
    echo "Attempted to drop base_price from car_types.\n";
} catch (PDOException $e) {
    if (strpos($e->getMessage(), "Unknown column 'base_price'") !== false) {
        echo "Column base_price already removed.\n";
    } else {
        echo "Error: " . $e->getMessage() . "\n";
    }
}
