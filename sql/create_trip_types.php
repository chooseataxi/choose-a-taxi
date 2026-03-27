<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $sql = "CREATE TABLE IF NOT EXISTS trip_types (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    $pdo->exec($sql);
    echo "Table 'trip_types' created successfully!<br>";

    // Insert default trip types
    $defaults = [
        ['One Way', 'One way taxi service'],
        ['Round Trip', 'Round trip taxi service'],
        ['Local', 'Local rental service'],
        ['Outstation', 'Outstation taxi service']
    ];

    $stmt = $pdo->prepare("INSERT IGNORE INTO trip_types (name, description) VALUES (?, ?)");
    foreach ($defaults as $type) {
        $stmt->execute($type);
    }
    echo "Default trip types inserted successfully!";

} catch (PDOException $e) {
    die("Error creating table: " . $e->getMessage());
}
