<?php
require_once __DIR__ . '/../../includes/db.php';
try {
    $stmt = $pdo->query("SELECT id, phone, full_name FROM drivers");
    $drivers = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($drivers);
} catch(Exception $e){
    echo $e->getMessage();
}
