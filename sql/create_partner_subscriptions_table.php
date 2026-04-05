<?php
require_once __DIR__ . '/../includes/db.php';

try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_subscriptions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        plan_id INT NOT NULL,
        razorpay_payment_id VARCHAR(255) NOT NULL,
        razorpay_order_id VARCHAR(255) NOT NULL,
        amount DECIMAL(10, 2) NOT NULL,
        status ENUM('active', 'expired', 'cancelled', 'pending') DEFAULT 'active',
        start_date DATETIME NOT NULL,
        expiry_date DATETIME NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_partner (partner_id),
        INDEX idx_status (status)
    )");
    echo "Table 'partner_subscriptions' created successfully.\n";
} catch (PDOException $e) {
    die("Error creating table: " . $e->getMessage());
}
?>
