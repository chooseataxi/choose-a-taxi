<?php
/**
 * Airport Transfer Setup
 * Creates the 'Airport Transfer' trip type in the database
 * Uses CREATE TABLE IF NOT EXISTS pattern
 */
require_once __DIR__ . '/../includes/db.php';

try {
    // First ensure trip_types table exists
    $sql = "CREATE TABLE IF NOT EXISTS trip_types (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    $pdo->exec($sql);
    echo "Table 'trip_types' ensured.<br>";

    // Insert 'Airport Transfer' if it doesn't already exist
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM trip_types WHERE name = 'Airport Transfer'");
    $stmt->execute();
    $count = $stmt->fetchColumn();

    if ($count == 0) {
        $insertStmt = $pdo->prepare("INSERT INTO trip_types (name, description, status) VALUES (?, ?, 'Active')");
        $insertStmt->execute(['Airport Transfer', 'Airport transfer taxi service']);
        echo "Trip type 'Airport Transfer' created successfully!<br>";
    } else {
        echo "Trip type 'Airport Transfer' already exists.<br>";
    }

    echo "Setup complete.";

} catch (PDOException $e) {
    die("Error: " . $e->getMessage());
}
