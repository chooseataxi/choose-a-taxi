<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../vendor/autoload.php';

use Razorpay\Api\Api;

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$action = $_REQUEST['action'] ?? '';
$partner_id = $_REQUEST['partner_id'] ?? '';

// Helper: Get Razorpay Keys
function getRazorpayConfig($pdo) {
    try {
        $stmt = $pdo->query("SELECT setting_key, setting_value FROM payment_settings WHERE setting_key LIKE 'razorpay_%'");
        $settings = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
        return [
            'key_id'     => $settings['razorpay_key_id'] ?? '',
            'key_secret' => $settings['razorpay_key_secret'] ?? '',
            'status'     => $settings['razorpay_status'] ?? 'Inactive'
        ];
    } catch (Exception $e) { return null; }
}

try {
    switch ($action) {
        case 'get_plans':
            $stmt = $pdo->query("SELECT id, name, price, duration_value, duration_unit, terms 
                                FROM partner_subscription_plans 
                                WHERE status = 'active' 
                                ORDER BY price ASC");
            echo json_encode(['status' => 'success', 'plans' => $stmt->fetchAll()]);
            break;

        case 'create_order':
            if (empty($partner_id)) throw new Exception("Partner ID required");
            $plan_id = $_POST['plan_id'] ?? '';
            
            $stmt = $pdo->prepare("SELECT * FROM partner_subscription_plans WHERE id = ? AND status = 'active'");
            $stmt->execute([$plan_id]);
            $plan = $stmt->fetch();
            if (!$plan) throw new Exception("Invalid or inactive plan");

            $config = getRazorpayConfig($pdo);
            if (!$config || $config['status'] !== 'Active') throw new Exception("Payment gateway inactive");

            $api = new Api($config['key_id'], $config['key_secret']);
            $order = $api->order->create([
                'receipt' => 'sub_' . $partner_id . '_' . time(),
                'amount'  => $plan['price'] * 100,
                'currency' => 'INR',
                'payment_capture' => 1
            ]);

            echo json_encode([
                'status' => 'success',
                'order_id' => $order['id'],
                'amount' => $plan['price'],
                'key_id' => $config['key_id'],
                'plan_name' => $plan['name']
            ]);
            break;

        case 'verify_payment':
            if (empty($partner_id)) throw new Exception("Partner ID required");
            $plan_id = $_POST['plan_id'] ?? '';
            $order_id = $_POST['razorpay_order_id'] ?? '';
            $payment_id = $_POST['razorpay_payment_id'] ?? '';
            $signature = $_POST['razorpay_signature'] ?? '';

            $config = getRazorpayConfig($pdo);
            $api = new Api($config['key_id'], $config['key_secret']);
            
            $api->utility->verifyPaymentSignature([
                'razorpay_order_id' => $order_id,
                'razorpay_payment_id' => $payment_id,
                'razorpay_signature' => $signature
            ]);

            // Fetch plan for duration
            $stmt = $pdo->prepare("SELECT * FROM partner_subscription_plans WHERE id = ?");
            $stmt->execute([$plan_id]);
            $plan = $stmt->fetch();

            $start = date('Y-m-d H:i:s');
            $val = $plan['duration_value'];
            $unit = $plan['duration_unit']; // days, months, years
            $expiry = date('Y-m-d H:i:s', strtotime("+$val $unit", strtotime($start)));

            // Deactivate existing active plans for this partner
            $pdo->prepare("UPDATE partner_subscriptions SET status = 'expired' WHERE partner_id = ? AND status = 'active'")->execute([$partner_id]);

            // Insert new subscription
            $stmt = $pdo->prepare("INSERT INTO partner_subscriptions (partner_id, plan_id, razorpay_payment_id, razorpay_order_id, amount, status, start_date, expiry_date) VALUES (?, ?, ?, ?, ?, 'active', ?, ?)");
            $stmt->execute([$partner_id, $plan_id, $payment_id, $order_id, $plan['price'], $start, $expiry]);

            echo json_encode(['status' => 'success', 'message' => 'Subscription active until ' . date('d M Y', strtotime($expiry))]);
            break;

        case 'get_my_subscriptions':
            if (empty($partner_id)) throw new Exception("Partner ID required");
            
            $stmt = $pdo->prepare("SELECT s.*, p.name as plan_name, p.duration_value, p.duration_unit 
                                  FROM partner_subscriptions s 
                                  JOIN partner_subscription_plans p ON s.plan_id = p.id 
                                  WHERE s.partner_id = ? 
                                  ORDER BY s.id DESC");
            $stmt->execute([$partner_id]);
            echo json_encode(['status' => 'success', 'subscriptions' => $stmt->fetchAll()]);
            break;

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
