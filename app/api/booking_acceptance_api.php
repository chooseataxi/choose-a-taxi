<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/pusher_config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

use Razorpay\Api\Api;

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$action = $_REQUEST['action'] ?? '';
$partner_id = $_REQUEST['partner_id'] ?? '';
$booking_id = $_REQUEST['booking_id'] ?? '';

$no_booking_id_actions = ['get_chat_list', 'get_my_received', 'options'];
if (empty($partner_id) || (empty($booking_id) && !in_array($action, $no_booking_id_actions))) {
    echo json_encode(['status' => 'error', 'message' => 'Partner ID (and Booking ID if required) is missing']);
    exit;
}

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
    // Helper: Update Wallet & Log Transaction
    function updateWallet($pdo, $partner_id, $amount, $type, $source, $source_id, $description) {
        if (!$pdo->inTransaction()) $pdo->beginTransaction();
        try {
            $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
            $stmt->execute([$partner_id]);

            if ($type === 'Credit') {
                $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
            } else {
                $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance - ? WHERE partner_id = ?");
            }
            $stmt->execute([$amount, $partner_id]);

            $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$partner_id, $type, $amount, $source, $source_id, $description]);
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    switch ($action) {
        case 'get_details':
            // 1. Get Booking Main Info with Car Details
            $stmt = $pdo->prepare("SELECT b.*, p.full_name as poster_name, 
                                         c.name AS car_name, c.model AS car_model, 
                                         ct.name AS car_type_name, ct.image AS car_type_image
                                  FROM partner_bookings b 
                                  JOIN partners p ON b.partner_id = p.id 
                                  LEFT JOIN cars c ON c.id = b.car_type
                                  LEFT JOIN car_types ct ON ct.id = c.type_id
                                  WHERE b.id = ?");
            $stmt->execute([$booking_id]);
            $booking = $stmt->fetch();
            if (!$booking) throw new Exception("Booking not found");

            // 2. Check if already accepted
            $stmt = $pdo->prepare("SELECT a.*, p.full_name as accepter_name 
                                  FROM accepted_bookings a 
                                  JOIN partners p ON a.partner_id = p.id 
                                  WHERE a.booking_id = ? AND a.status != 'Cancelled' LIMIT 1");
            $stmt->execute([$booking_id]);
            $acceptance = $stmt->fetch();

            // 3. Get Drivers for the current partner (to allow acceptance)
            $stmt = $pdo->prepare("SELECT id, full_name as name FROM drivers WHERE partner_id = ? AND status = 'Active'");
            $stmt->execute([$partner_id]);
            $drivers = $stmt->fetchAll();

            echo json_encode([
                'status' => 'success',
                'booking' => $booking,
                'acceptance' => $acceptance,
                'drivers' => $drivers,
                'is_poster' => ($booking['partner_id'] == $partner_id)
            ]);
            break;

        case 'send_message':
            $message = $_POST['message'] ?? '';
            $receiver_id = $_POST['receiver_id'] ?? '';
            $type = $_POST['type'] ?? 'text';
            $payload = $_POST['payload'] ?? null;

            if (empty($message) || empty($receiver_id)) throw new Exception("Message and Receiver required");

            $stmt = $pdo->prepare("INSERT INTO booking_chats (booking_id, sender_id, receiver_id, message, type, payload) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$booking_id, $partner_id, $receiver_id, $message, $type, $payload]);
            $chat_id = $pdo->lastInsertId();

            // Trigger Pusher
            $event_data = [
                'id' => $chat_id,
                'booking_id' => $booking_id,
                'sender_id' => $partner_id,
                'message' => $message,
                'type' => $type,
                'payload' => $payload,
                'created_at' => date('Y-m-d H:i:s')
            ];
            
            try {
                $pusher->trigger("booking-chat-$booking_id", 'new-message', $event_data);
                $pusher->trigger("partner-$receiver_id", 'chat-update', $event_data);
            } catch (Exception $e) { /* Log pusher error but don't fail message insertion */ }

            echo json_encode(['status' => 'success', 'chat' => $event_data]);
            break;

        case 'get_chat_history':
            // We want chats between ME and the OTHER partner for this booking
            $other_id = $_REQUEST['other_id'] ?? '';
            $stmt = $pdo->prepare("SELECT * FROM booking_chats 
                                  WHERE booking_id = ? 
                                  AND ((sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?))
                                  ORDER BY id ASC");
            $stmt->execute([$booking_id, $partner_id, $other_id, $other_id, $partner_id]);
            echo json_encode(['status' => 'success', 'chats' => $stmt->fetchAll()]);
            break;

        case 'accept_booking':
            throw new Exception("Use accept_with_wallet or accept_create_razorpay_order instead");
            break;

        case 'accept_with_wallet':
            $driver_id = $_POST['driver_id'] ?? '';
            $commission = $_POST['commission'] ?? 0;
            if (empty($driver_id)) throw new Exception("Driver assignment is mandatory");

            // 1. Check if already taken
            $stmt = $pdo->prepare("SELECT id FROM accepted_bookings WHERE booking_id = ? AND status != 'Cancelled'");
            $stmt->execute([$booking_id]);
            if ($stmt->fetch()) throw new Exception("Already accepted by another partner");

            // 2. Check Wallet
            $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $wallet = $stmt->fetch();
            if (!$wallet || $wallet['balance'] < $commission) throw new Exception("Insufficient wallet balance. Please add funds.");

            $pdo->beginTransaction();
            try {
                // 3. Update/Insert Acceptance
                $stmt = $pdo->prepare("INSERT INTO accepted_bookings (booking_id, partner_id, driver_id, status) VALUES (?, ?, ?, 'Accepted') ON DUPLICATE KEY UPDATE status='Accepted', driver_id=VALUES(driver_id)");
                $stmt->execute([$booking_id, $partner_id, $driver_id]);
                $acc_id = $pdo->lastInsertId() ?: $booking_id; // Simple fallback

                // 4. Update Main Booking Status
                $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Accepted' WHERE id = ?");
                $stmt->execute([$booking_id]);

                // 5. Deduct Wallet
                if (!updateWallet($pdo, $partner_id, $commission, 'Debit', 'Booking Acceptance', $acc_id, "Commission for Booking #$booking_id")) {
                    throw new Exception("Wallet update failed");
                }

                $pdo->commit();
                echo json_encode(['status' => 'success', 'message' => 'Booking accepted successfully using wallet balance.']);
            } catch (Exception $e) {
                $pdo->rollBack();
                throw $e;
            }
            break;

        case 'accept_create_razorpay_order':
            $commission = $_POST['commission'] ?? 0;
            if ($commission < 1) throw new Exception("Invalid commission amount");

            $config = getRazorpayConfig($pdo);
            if (!$config || $config['status'] !== 'Active') throw new Exception("Payment gateway not active");

            $api = new \Razorpay\Api\Api($config['key_id'], $config['key_secret']);
            $order = $api->order->create([
                'receipt' => 'acc_' . $booking_id . '_' . time(),
                'amount' => $commission * 100,
                'currency' => 'INR'
            ]);

            echo json_encode(['status' => 'success', 'order_id' => $order['id'], 'key_id' => $config['key_id']]);
            break;

        case 'accept_verify_razorpay':
            $order_id = $_POST['razorpay_order_id'] ?? '';
            $payment_id = $_POST['razorpay_payment_id'] ?? '';
            $signature = $_POST['razorpay_signature'] ?? '';
            $driver_id = $_POST['driver_id'] ?? '';
            $commission = $_POST['commission'] ?? 0;

            $config = getRazorpayConfig($pdo);
            $api = new \Razorpay\Api\Api($config['key_id'], $config['key_secret']);

            try {
                $api->utility->verifyPaymentSignature([
                    'razorpay_order_id' => $order_id,
                    'razorpay_payment_id' => $payment_id,
                    'razorpay_signature' => $signature
                ]);

                $pdo->beginTransaction();
                $stmt = $pdo->prepare("INSERT INTO accepted_bookings (booking_id, partner_id, driver_id, status) VALUES (?, ?, ?, 'Accepted') ON DUPLICATE KEY UPDATE status='Accepted', driver_id=VALUES(driver_id)");
                $stmt->execute([$booking_id, $partner_id, $driver_id]);
                
                $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Accepted' WHERE id = ?");
                $stmt->execute([$booking_id]);

                // Log as transaction (Paid but not from wallet, so maybe just log it)
                $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) VALUES (?, 'Debit', ?, 'Razorpay Acceptance', ?, ?)");
                $stmt->execute([$partner_id, $commission, $payment_id, "Commission for Booking #$booking_id via Razorpay"]);

                $pdo->commit();
                echo json_encode(['status' => 'success', 'message' => 'Payment verified. Booking accepted.']);
            } catch (Exception $e) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                throw new Exception("Payment verification failed: " . $e->getMessage());
            }
            break;

        case 'get_my_received':
            if (empty($partner_id)) throw new Exception("Partner ID required");
            $stmt = $pdo->prepare("SELECT a.*, b.*, p.full_name as partner_name 
                                  FROM accepted_bookings a 
                                  JOIN partner_bookings b ON a.booking_id = b.id 
                                  JOIN partners p ON b.partner_id = p.id 
                                  WHERE a.partner_id = ? 
                                  ORDER BY a.id DESC");
            $stmt->execute([$partner_id]);
            echo json_encode(['status' => 'success', 'bookings' => $stmt->fetchAll()]);
            break;

        case 'get_chat_list':
            // ── 1. Posted (My own bookings) ──
            $sqlPosted = "SELECT BC.booking_id, BC.message, BC.created_at, P.full_name as partner_name, BC.type
                          FROM booking_chats BC
                          JOIN partner_bookings PB ON BC.booking_id = PB.id
                          JOIN partners P ON P.id = (CASE WHEN BC.sender_id = ? THEN BC.receiver_id ELSE BC.sender_id END)
                          WHERE PB.partner_id = ?
                          AND BC.id IN (
                              SELECT MAX(id) FROM booking_chats 
                              GROUP BY booking_id, (CASE WHEN sender_id = ? THEN receiver_id ELSE sender_id END)
                          )
                          ORDER BY BC.id DESC";
            $stmt = $pdo->prepare($sqlPosted);
            $stmt->execute([$partner_id, $partner_id, $partner_id]);
            $posted = $stmt->fetchAll();

            // ── 2. Received (Others' bookings I chatted on) ──
            $sqlReceived = "SELECT BC.booking_id, BC.message, BC.created_at, P.full_name as partner_name, BC.type, PB.partner_id as other_id
                            FROM booking_chats BC
                            JOIN partner_bookings PB ON BC.booking_id = PB.id
                            JOIN partners P ON P.id = PB.partner_id
                            WHERE (BC.sender_id = ? OR BC.receiver_id = ?)
                            AND PB.partner_id != ?
                            AND BC.id IN (
                                SELECT MAX(id) FROM booking_chats 
                                GROUP BY booking_id
                            )
                            ORDER BY BC.id DESC";
            $stmt = $pdo->prepare($sqlReceived);
            $stmt->execute([$partner_id, $partner_id, $partner_id]);
            $received = $stmt->fetchAll();

            echo json_encode([
                'status' => 'success',
                'posted' => $posted,
                'received' => $received
            ]);
            break;

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
