<?php
require_once __DIR__ . '/../../includes/db.php';
try {
    $stmt = $pdo->query("SELECT * FROM partner_bookings ORDER BY id DESC LIMIT 5");
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    print_r($rows);
} catch (Exception $e) {
    echo "DB ERROR: " . $e->getMessage();
}
