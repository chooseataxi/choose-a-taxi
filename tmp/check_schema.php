<?php
require_once __DIR__ . '/../includes/db.php';
try {
    $stmt = $pdo->query("DESCRIBE booking_chats");
    $columns = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($columns, JSON_PRETTY_PRINT);
} catch (Exception $e) {
    echo $e->getMessage();
}
