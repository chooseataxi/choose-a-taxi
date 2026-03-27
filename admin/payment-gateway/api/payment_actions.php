<?php
require_once __DIR__ . '/../../../vendor/autoload.php';
require_once __DIR__ . '/../../../includes/db.php';
require_once __DIR__ . '/../../auth_check.php';

use Razorpay\Api\Api;
use Razorpay\Api\Errors\SignatureVerificationError;

header('Content-Type: application/json');

$adminData = checkAdminAuth();
$action = $_POST['action'] ?? $_GET['action'] ?? '';

function getSetting($pdo, $key) {
    $stmt = $pdo->prepare("SELECT setting_value FROM payment_settings WHERE setting_key = ?");
    $stmt->execute([$key]);
    return $stmt->fetchColumn();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' || $_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        switch ($action) {
            case 'save_settings':
                $keys = [
                    'razorpay_key_id' => $_POST['key_id'] ?? '',
                    'razorpay_key_secret' => $_POST['key_secret'] ?? '',
                    'razorpay_mode' => $_POST['mode'] ?? 'test',
                    'razorpay_status' => $_POST['status'] ?? 'Inactive'
                ];

                foreach ($keys as $key => $value) {
                    $stmt = $pdo->prepare("UPDATE payment_settings SET setting_value = ? WHERE setting_key = ?");
                    $stmt->execute([$value, $key]);
                }

                echo json_encode(['success' => true, 'message' => 'Settings saved successfully!']);
                break;

            case 'create_test_order':
                $keyId = getSetting($pdo, 'razorpay_key_id');
                $keySecret = getSetting($pdo, 'razorpay_key_secret');

                if (empty($keyId) || empty($keySecret)) {
                    throw new Exception("Key ID and Secret are required.");
                }

                $api = new Api($keyId, $keySecret);
                $orderData = [
                    'receipt'         => 'test_receipt_' . time(),
                    'amount'          => 100, // 1 INR in paise
                    'currency'        => 'INR',
                    'payment_capture' => 1
                ];

                $order = $api->order->create($orderData);
                
                // Initialize log
                $stmt = $pdo->prepare("INSERT INTO payment_test_logs (razorpay_order_id, amount, status) VALUES (?, ?, ?)");
                $stmt->execute([$order['id'], 1.00, 'Pending']);

                echo json_encode([
                    'success' => true,
                    'key' => $keyId,
                    'order_id' => $order['id'],
                    'amount' => 100,
                    'name' => 'Choose A Taxi',
                    'description' => 'Test Transaction'
                ]);
                break;

            case 'verify_test_payment':
                $keyId = getSetting($pdo, 'razorpay_key_id');
                $keySecret = getSetting($pdo, 'razorpay_key_secret');

                $payload = $_POST;
                $api = new Api($keyId, $keySecret);

                try {
                    $attributes = [
                        'razorpay_order_id' => $payload['razorpay_order_id'],
                        'razorpay_payment_id' => $payload['razorpay_payment_id'],
                        'razorpay_signature' => $payload['razorpay_signature']
                    ];
                    $api->utility->verifyPaymentSignature($attributes);
                    
                    // Success
                    $stmt = $pdo->prepare("UPDATE payment_test_logs SET razorpay_payment_id = ?, status = ?, response_data = ? WHERE razorpay_order_id = ?");
                    $stmt->execute([$payload['razorpay_payment_id'], 'Success', json_encode($payload), $payload['razorpay_order_id']]);
                    
                    echo json_encode(['success' => true, 'message' => 'Payment verified successfully!']);
                } catch (SignatureVerificationError $e) {
                    // Failed
                    $stmt = $pdo->prepare("UPDATE payment_test_logs SET status = ?, response_data = ? WHERE razorpay_order_id = ?");
                    $stmt->execute(['Failed', $e->getMessage(), $payload['razorpay_order_id']]);
                    
                    throw new Exception("Signature verification failed.");
                }
                break;

            case 'get_logs':
                $stmt = $pdo->query("SELECT * FROM payment_test_logs ORDER BY id DESC LIMIT 10");
                echo json_encode(['success' => true, 'data' => $stmt->fetchAll()]);
                break;

            default:
                throw new Exception("Invalid action.");
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
}
