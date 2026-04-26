<?php
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");

// This script resets bookings that were incorrectly marked as 'Expired'
// but are actually in the future.

try {
    $sql = "UPDATE partner_bookings 
            SET status = 'Open' 
            WHERE status = 'Expired' 
            AND (
                (STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %h:%i %p') IS NOT NULL AND STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %h:%i %p') > NOW())
                OR (STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %h:%i %p') IS NOT NULL AND STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %h:%i %p') > NOW())
                OR (STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %H:%i') IS NOT NULL AND STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %H:%i') > NOW())
                OR (STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %H:%i') IS NOT NULL AND STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %H:%i') > NOW())
                OR (STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%e-%c-%Y %h:%i %p') IS NOT NULL AND STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%e-%c-%Y %h:%i %p') > NOW())
                OR (STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%c-%e %h:%i %p') IS NOT NULL AND STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%c-%e %h:%i %p') > NOW())
            )";
    
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $count = $stmt->rowCount();

    echo json_encode([
        "status" => "success", 
        "message" => "Repaired $count incorrectly expired bookings.",
        "current_server_time" => $pdo->query("SELECT NOW()")->fetchColumn()
    ]);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
