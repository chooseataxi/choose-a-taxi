<?php
// Try to fix DB connection for CLI if possible, but mainly just debug
require_once __DIR__ . '/../../includes/db.php';
try {
    $stmt = $pdo->query("DESCRIBE drivers");
    $schema = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($schema);
} catch(Exception $e){
    echo $e->getMessage();
}
