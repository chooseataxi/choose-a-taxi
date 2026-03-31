<?php
try {
    require_once __DIR__ . '/includes/db.php';
    echo "DB Connection Successful!\n";
    $stmt = $pdo->query("SELECT 1");
    echo "Query Successful!\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
