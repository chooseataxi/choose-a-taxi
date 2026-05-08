<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create App Notices Table
    $pdo->exec("CREATE TABLE IF NOT EXISTS app_notices (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        status ENUM('active', 'inactive') DEFAULT 'active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )");
    echo "Table 'app_notices' created successfully.\n";

    // 2. Create Partner Notices Seen Tracking Table
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_notices_seen (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        notice_id INT NOT NULL,
        seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY (partner_id, notice_id)
    )");
    echo "Table 'partner_notices_seen' created successfully.\n";

    // 3. Create Partner Booking Popups Seen Tracking Table
    // This tracks if a partner has seen the "Booking Completed" popup for a specific booking
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_booking_popups_seen (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        booking_id INT NOT NULL,
        seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY (partner_id, booking_id)
    )");
    echo "Table 'partner_booking_popups_seen' created successfully.\n";

} catch (PDOException $e) {
    die("Error creating tables: " . $e->getMessage());
}
?>
