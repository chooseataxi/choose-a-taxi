<?php
require_once __DIR__ . '/includes/db.php';
$tables = ['cars', 'car_brands', 'car_types', 'trip_types'];
foreach ($tables as $table) {
    try {
        $stmt = $pdo->query("DESC $table");
        echo "--- $table ---\n";
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "{$row['Field']} ({$row['Type']})\n";
        }
    } catch (Exception $e) {
        echo "--- $table: Missing ---\n";
    }
}
