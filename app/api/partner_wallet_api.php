<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/../../includes/db.php';

use Razorpay\Api\Api;

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$action = $_REQUEST['action'] ?? '';
$partner_id = $_REQUEST['partner_id'] ?? '';

if (empty($partner_id) && $action !== 'options') {
    echo json_encode(["status" => "error", "message" => "partner_id is required"]);
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// Helper: Get Razorpay Keys from Database
// ──────────────────────────────────────────────────────────────────────────────
function getRazorpayConfig($pdo) {
    try {
        $stmt = $pdo->query("SELECT setting_key, setting_value FROM payment_settings WHERE setting_key LIKE 'razorpay_%'");
        $settings = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
        return [
            'key_id'     => $settings['razorpay_key_id'] ?? '',
            'key_secret' => $settings['razorpay_key_secret'] ?? '',
            'mode'       => $settings['razorpay_mode'] ?? 'test',
            'status'     => $settings['razorpay_status'] ?? 'Inactive'
        ];
    } catch (Exception $e) {
        return null;
    }
}

// ──────────────────────────────────────────────────────────────────────────────
// Helper: Update Wallet & Log Transaction
// ──────────────────────────────────────────────────────────────────────────────
function updateWallet($pdo, $partner_id, $amount, $type, $source, $source_id, $description) {
    $isNested = $pdo->inTransaction();
    if (!$isNested) $pdo->beginTransaction();
    try {
        // 1. Ensure wallet exists
        $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
        $stmt->execute([$partner_id]);

        // 2. Update balance
        if ($type === 'Credit') {
            $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
        } else {
            $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance - ? WHERE partner_id = ?");
        }
        $stmt->execute([$amount, $partner_id]);

        // 3. Log transaction
        $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([$partner_id, $type, $amount, $source, $source_id, $description]);

        if (!$isNested) $pdo->commit();
        return true;
    } catch (Exception $e) {
        if (!$isNested) $pdo->rollBack();
        return false;
    }
}

try {
    switch ($action) {
        // ──────────────────────────────────────────────────
        // GET WALLET SUMMARY (Balance + Recent)
        // ──────────────────────────────────────────────────
        case 'get_summary':
            $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $wallet = $stmt->fetch(PDO::FETCH_ASSOC);
            $balance = $wallet ? $wallet['balance'] : "0.00";

            $stmt = $pdo->prepare("SELECT * FROM partner_transactions WHERE partner_id = ? ORDER BY id DESC LIMIT 20");
            $stmt->execute([$partner_id]);
            $transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Pending Commissions
            $stmt = $pdo->prepare("SELECT SUM(final_amount) as pending FROM commission_requests WHERE partner_id = ? AND status = 'Processing'");
            $stmt->execute([$partner_id]);
            $pComm = $stmt->fetch();
            $pending_commissions = (float)($pComm['pending'] ?? 0);

            // Pending Withdrawals (Balance already deducted, but good to show as processing)
            $stmt = $pdo->prepare("SELECT SUM(amount) as pending FROM partner_withdrawals WHERE partner_id = ? AND status = 'Processing'");
            $stmt->execute([$partner_id]);
            $pWith = $stmt->fetch();
            $pending_withdrawals = (float)($pWith['pending'] ?? 0);

            echo json_encode([
                "status" => "success", 
                "balance" => $balance, 
                "transactions" => $transactions,
                "pending_commissions" => $pending_commissions,
                "pending_withdrawals" => $pending_withdrawals
            ]);
            break;

        // ──────────────────────────────────────────────────
        // CREATE RAZORPAY ORDER
        // ──────────────────────────────────────────────────
        case 'create_order':
            $amount = $_POST['amount'] ?? 0;
            if ($amount < 1) throw new Exception("Invalid amount");

            $config = getRazorpayConfig($pdo);
            if (!$config || $config['status'] !== 'Active') throw new Exception("Payment gateway not active");

            $api = new Api($config['key_id'], $config['key_secret']);
            $orderData = [
                'receipt'         => 'rcpt_p_' . $partner_id . '_' . time(),
                'amount'          => $amount * 100, // In Paise
                'currency'        => 'INR',
                'payment_capture' => 1
            ];

            $razorpayOrder = $api->order->create($orderData);
            
            // Log pending deposit
            $stmt = $pdo->prepare("INSERT INTO partner_deposits (partner_id, amount, razorpay_order_id, status) VALUES (?, ?, ?, 'Pending')");
            $stmt->execute([$partner_id, $amount, $razorpayOrder['id']]);

            echo json_encode([
                "status" => "success", 
                "order_id" => $razorpayOrder['id'],
                "amount" => $amount,
                "key_id" => $config['key_id']
            ]);
            break;

        // ──────────────────────────────────────────────────
        // VERIFY RAZORPAY PAYMENT
        // ──────────────────────────────────────────────────
        case 'verify_payment':
            $order_id = $_POST['razorpay_order_id'] ?? '';
            $payment_id = $_POST['razorpay_payment_id'] ?? '';
            $signature = $_POST['razorpay_signature'] ?? '';

            $config = getRazorpayConfig($pdo);
            $api = new Api($config['key_id'], $config['key_secret']);

            try {
                $attributes = [
                    'razorpay_order_id' => $order_id,
                    'razorpay_payment_id' => $payment_id,
                    'razorpay_signature' => $signature
                ];
                $api->utility->verifyPaymentSignature($attributes);
                
                // Signature valid - Update deposit record
                $stmt = $pdo->prepare("SELECT * FROM partner_deposits WHERE razorpay_order_id = ? AND status = 'Pending'");
                $stmt->execute([$order_id]);
                $deposit = $stmt->fetch(PDO::FETCH_ASSOC);

                if ($deposit) {
                    $stmt = $pdo->prepare("UPDATE partner_deposits SET razorpay_payment_id = ?, razorpay_signature = ?, status = 'Success' WHERE id = ?");
                    $stmt->execute([$payment_id, $signature, $deposit['id']]);

                    // Credit Wallet
                    updateWallet($pdo, $partner_id, $deposit['amount'], 'Credit', 'Deposit', $deposit['id'], "Fund added via Razorpay ($payment_id)");
                    
                    echo json_encode(["status" => "success", "message" => "Payment verified and wallet updated"]);
                } else {
                    throw new Exception("Deposit record not found or already processed");
                }
            } catch (Exception $e) {
                echo json_encode(["status" => "error", "message" => "Signature verification failed: " . $e->getMessage()]);
            }
            break;

        // ──────────────────────────────────────────────────
        // REQUEST WITHDRAWAL
        // ──────────────────────────────────────────────────
        case 'request_withdrawal':
            $amount = $_POST['amount'] ?? 0;
            if ($amount <= 0) throw new Exception("Invalid withdrawal amount");

            $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $wallet = $stmt->fetch(PDO::FETCH_ASSOC);
            $current_balance = $wallet ? (float)$wallet['balance'] : 0.0;
            
            if ($current_balance - $amount < 300) {
                throw new Exception("Withdrawal not allowed. A minimum maintenance balance of ₹300 must remain in your wallet.");
            }

            // Check if bank details exist
            $stmt = $pdo->prepare("SELECT id FROM partner_bank_details WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            if (!$stmt->fetch()) throw new Exception("Please update your bank details first");

            // Process withdrawal
            $pdo->beginTransaction();
            try {
                // Ensure status ENUM supports 'Processing'
                $pdo->exec("ALTER TABLE partner_withdrawals MODIFY COLUMN status ENUM('Pending', 'Processing', 'In-Process', 'Paid', 'Rejected', 'Success') DEFAULT 'Pending'");

                // 1. Create withdrawal record
                $stmt = $pdo->prepare("INSERT INTO partner_withdrawals (partner_id, amount, status) VALUES (?, ?, 'Processing')");
                $stmt->execute([$partner_id, $amount]);
                $withdrawal_id = $pdo->lastInsertId();

                // 2. Update Wallet & Log (Debit)
                updateWallet($pdo, $partner_id, $amount, 'Debit', 'Withdrawal', $withdrawal_id, "Withdrawal request submitted (Processing)");

                $pdo->commit();
                echo json_encode(["status" => "success", "message" => "Withdrawal request submitted successfully"]);
            } catch (Exception $e) {
                $pdo->rollBack();
                throw $e;
            }
            break;

        // ──────────────────────────────────────────────────
        // BANK DETAILS
        // ──────────────────────────────────────────────────
        case 'get_bank_details':
            $stmt = $pdo->prepare("SELECT * FROM partner_bank_details WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $details = $stmt->fetch(PDO::FETCH_ASSOC);
            echo json_encode(["status" => "success", "data" => $details ?: null]);
            break;

        case 'update_bank_details':
            $holder = $_POST['holder_name'] ?? '';
            $bank = $_POST['bank_name'] ?? '';
            $acc = $_POST['account_number'] ?? '';
            $ifsc = $_POST['ifsc_code'] ?? '';

            if (empty($holder) || empty($acc) || empty($ifsc)) throw new Exception("All fields are required");

            $stmt = $pdo->prepare("INSERT INTO partner_bank_details (partner_id, holder_name, bank_name, account_number, ifsc_code) 
                                   VALUES (?, ?, ?, ?, ?) 
                                   ON DUPLICATE KEY UPDATE 
                                   holder_name = VALUES(holder_name), bank_name = VALUES(bank_name), account_number = VALUES(account_number), ifsc_code = VALUES(ifsc_code)");
            $stmt->execute([$partner_id, $holder, $bank, $acc, $ifsc]);
            
            echo json_encode(["status" => "success", "message" => "Bank details updated"]);
            break;

        default:
            echo json_encode(["status" => "error", "message" => "Invalid action"]);
            break;
    }
} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
