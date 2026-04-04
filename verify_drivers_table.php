<?php
require_once __DIR__ . '/includes/db.php';
try {
    $stmt = $pdo->query("DESCRIBE drivers");
    $fields = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "TABLE EXISTS. FIELDS: " . implode(", ", $fields) . "\n";
} catch (Exception $e) {
    echo "TABLE NOT FOUND: " . $e->getMessage() . "\n";
}
