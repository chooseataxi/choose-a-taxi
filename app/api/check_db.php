<?php
require_once __DIR__ . '/../../includes/db.php';
try {
    $stmt = $pdo->query("EXPLAIN partner_bookings");
    print_r($stmt->fetchAll(PDO::FETCH_ASSOC));
} catch (Exception $e) {
    echo "DB ERROR: " . $e->getMessage();
}
