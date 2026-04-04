<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // 1. partner_wallet
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_wallet (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL UNIQUE,
        balance DECIMAL(12,2) DEFAULT 0.00,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 2. partner_deposits
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_deposits (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        amount DECIMAL(10,2) NOT NULL,
        razorpay_order_id VARCHAR(100),
        razorpay_payment_id VARCHAR(100),
        razorpay_signature TEXT,
        status ENUM('Pending', 'Success', 'Failed') DEFAULT 'Pending',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX(partner_id),
        INDEX(razorpay_order_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 3. partner_withdrawals
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_withdrawals (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        amount DECIMAL(10,2) NOT NULL,
        status ENUM('Pending', 'In-Process', 'Paid', 'Rejected') DEFAULT 'Pending',
        payout_method VARCHAR(50) DEFAULT 'Bank Transfer',
        transaction_id VARCHAR(100),
        admin_note TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX(partner_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 4. partner_bank_details
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_bank_details (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL UNIQUE,
        holder_name VARCHAR(150),
        bank_name VARCHAR(100),
        account_number VARCHAR(50),
        ifsc_code VARCHAR(20),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX(partner_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    // 5. partner_transactions (Unified Ledger)
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_transactions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        type ENUM('Credit', 'Debit') NOT NULL,
        amount DECIMAL(12,2) NOT NULL,
        source ENUM('Deposit', 'Withdrawal', 'Booking', 'Bonus', 'Penalty') NOT NULL,
        source_id INT, -- ID of the record in partner_deposits, partner_withdrawals, etc.
        description TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX(partner_id),
        INDEX(source_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    echo "Wallet and Transaction tables created successfully!\n";

} catch (PDOException $e) {
    die("Error creating wallet tables: " . $e->getMessage());
}
