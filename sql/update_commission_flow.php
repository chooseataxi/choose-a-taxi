<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. commission_requests table
    $pdo->exec("CREATE TABLE IF NOT EXISTS commission_requests (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        booking_id INT NOT NULL,
        acceptance_id INT NOT NULL,
        raw_amount DECIMAL(10,2) NOT NULL,
        service_charge DECIMAL(10,2) NOT NULL,
        final_amount DECIMAL(10,2) NOT NULL,
        status ENUM('Processing', 'Approved', 'Rejected') DEFAULT 'Processing',
        admin_note TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX(partner_id),
        INDEX(booking_id),
        INDEX(status)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. Update partner_transactions source enum
    // Note: ALTER TABLE on ENUM can be tricky depending on MySQL version, but this is a common way.
    // However, to be safe, we can just ensure it accepts 'Commission' string if it was TEXT, 
    // but here it is ENUM.
    $pdo->exec("ALTER TABLE partner_transactions MODIFY COLUMN source ENUM('Deposit', 'Withdrawal', 'Booking', 'Bonus', 'Penalty', 'Commission') NOT NULL");

    echo "Commission Requests table created and Transaction source updated successfully!\n";

} catch (PDOException $e) {
    die("Error updating database: " . $e->getMessage());
}
