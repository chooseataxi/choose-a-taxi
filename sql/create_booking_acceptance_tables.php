<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create accepted_bookings table
    $pdo->exec("CREATE TABLE IF NOT EXISTS accepted_bookings (
        id INT AUTO_INCREMENT PRIMARY KEY,
        booking_id INT NOT NULL,
        partner_id INT NOT NULL, -- The partner who accepted
        driver_id INT NULL,    -- Assigned driver
        status ENUM('Pending', 'Accepted', 'In-Progress', 'Completed', 'Cancelled') DEFAULT 'Pending',
        total_fare DECIMAL(10, 2) NULL,
        commission DECIMAL(10, 2) NULL,
        payment_status ENUM('Pending', 'Paid') DEFAULT 'Pending',
        razorpay_order_id VARCHAR(255) NULL,
        razorpay_payment_id VARCHAR(255) NULL,
        razorpay_signature VARCHAR(255) NULL,
        accepted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_booking (booking_id),
        INDEX idx_partner (partner_id),
        FOREIGN KEY (booking_id) REFERENCES partner_bookings(id) ON DELETE CASCADE,
        FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. Create booking_chats table
    $pdo->exec("CREATE TABLE IF NOT EXISTS booking_chats (
        id INT AUTO_INCREMENT PRIMARY KEY,
        booking_id INT NOT NULL,
        sender_id INT NOT NULL,
        receiver_id INT NOT NULL,
        message TEXT NOT NULL,
        type ENUM('text', 'quote_request') DEFAULT 'text',
        payload JSON NULL, -- For quote amounts
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_booking_chat (booking_id),
        FOREIGN KEY (booking_id) REFERENCES partner_bookings(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    echo "Tables 'accepted_bookings' and 'booking_chats' created successfully.\n";
} catch (PDOException $e) {
    die("Error setting up acceptance tables: " . $e->getMessage());
}
?>
