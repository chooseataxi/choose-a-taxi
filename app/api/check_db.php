<?php
require_once __DIR__ . '/../../includes/db.php';
try {
    $r = $pdo->query('SHOW TABLES');
    print_r($r->fetchAll(PDO::FETCH_COLUMN));
} catch(Exception $e){
    echo $e->getMessage();
}
