<?php
/**
 * Setup script for Professional App Popups System
 * Run this file once to create necessary database tables.
 */

// Use absolute path for db connection
require_once __DIR__ . '/../includes/db.php';

echo "<h3>Initializing App Popups Database Setup...</h3>";

try {
    // 1. Table for storing the notices themselves
    $sql1 = "CREATE TABLE IF NOT EXISTS app_notices (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        status ENUM('active', 'inactive') DEFAULT 'active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
    
    $pdo->exec($sql1);
    echo "<p style='color:green;'>[SUCCESS] Table 'app_notices' created/verified.</p>";

    // 2. Table to track which partners have seen which notices
    $sql2 = "CREATE TABLE IF NOT EXISTS partner_notices_seen (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        notice_id INT NOT NULL,
        seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY unq_partner_notice (partner_id, notice_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
    
    $pdo->exec($sql2);
    echo "<p style='color:green;'>[SUCCESS] Table 'partner_notices_seen' created/verified.</p>";

    // 3. Table to track seen "Booking Completed" popups
    $sql3 = "CREATE TABLE IF NOT EXISTS partner_booking_popups_seen (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        booking_id INT NOT NULL,
        seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY unq_partner_booking (partner_id, booking_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
    
    $pdo->exec($sql3);
    echo "<p style='color:green;'>[SUCCESS] Table 'partner_booking_popups_seen' created/verified.</p>";

    echo "<hr><h4 style='color:blue;'>Setup completed successfully! You can now manage notices from the Admin Panel.</h4>";
    echo "<p>Path: Admin -> Mobile App -> Manage Notices</p>";

} catch (PDOException $e) {
    echo "<p style='color:red;'>[ERROR] Failed to create tables: " . $e->getMessage() . "</p>";
    echo "<p>Please ensure your database credentials in <b>includes/db.php</b> or <b>.env</b> are correct for your local WAMP environment.</p>";
}
?>
