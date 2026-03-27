<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. Create payment_settings table
    $pdo->exec("CREATE TABLE IF NOT EXISTS payment_settings (
        id INT AUTO_INCREMENT PRIMARY KEY,
        setting_key VARCHAR(100) NOT NULL UNIQUE,
        setting_value TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. Insert default keys if not exists
    $defaultSettings = [
        'razorpay_key_id' => '',
        'razorpay_key_secret' => '',
        'razorpay_mode' => 'test', // test or live
        'razorpay_status' => 'Inactive'
    ];

    $stmt = $pdo->prepare("INSERT IGNORE INTO payment_settings (setting_key, setting_value) VALUES (?, ?)");
    foreach ($defaultSettings as $key => $value) {
        $stmt->execute([$key, $value]);
    }

    // 3. Create payment_test_logs table
    $pdo->exec("CREATE TABLE IF NOT EXISTS payment_test_logs (
        id INT AUTO_INCREMENT PRIMARY KEY,
        razorpay_order_id VARCHAR(100),
        razorpay_payment_id VARCHAR(100),
        amount DECIMAL(10,2),
        currency VARCHAR(10) DEFAULT 'INR',
        status ENUM('Pending', 'Success', 'Failed') DEFAULT 'Pending',
        response_data TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    echo "Payment settings and logs tables created successfully!\n";
} catch (PDOException $e) {
    echo "Error creating tables: " . $e->getMessage() . "\n";
}
