<?php
require_once __DIR__ . '/../../includes/db.php';
header('Content-Type: application/json');

try {
    $tables = ['booking_chats', 'partner_bookings', 'accepted_bookings', 'partners'];
    $schema = [];
    foreach ($tables as $t) {
        $q = $pdo->query("DESCRIBE $t");
        $schema[$t] = $q->fetchAll(PDO::FETCH_ASSOC);
    }
    echo json_encode($schema, JSON_PRETTY_PRINT);
} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
