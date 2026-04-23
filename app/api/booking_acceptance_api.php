<?php
// require_once __DIR__ . '/../../includes/db.php';
set_exception_handler(function($e) {
    header("Content-Type: application/json");
    echo json_encode(["status" => "error", "message" => "Critical Error: " . $e->getMessage()]);
    exit;
});
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
    // Lazy Migration: Add is_read if not exists
    try {
        $pdo->exec("ALTER TABLE booking_chats ADD COLUMN is_read TINYINT(1) DEFAULT 0");
    } catch (PDOException $e) {}

    // Lazy Migration: Add phone to drivers if not exists
    try {
        $pdo->exec("ALTER TABLE drivers ADD COLUMN phone VARCHAR(20) DEFAULT NULL AFTER full_name");
    } catch (PDOException $e) {}

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
            $stmt = $pdo->prepare("SELECT b.*, p.full_name as poster_name, p.manual_verification_status as poster_verification,
                                         c.name AS car_name, c.model AS car_model, 
                                         ct.name AS car_type_name, ct.image AS car_type_image,
                                         p.id AS poster_id, p.selfie_link AS poster_image
                                  FROM partner_bookings b 
                                  JOIN partners p ON b.partner_id = p.id 
                                  LEFT JOIN cars c ON c.id = b.car_type
                                  LEFT JOIN car_types ct ON ct.id = c.type_id
                                  WHERE b.id = ?");
            $stmt->execute([$booking_id]);
            $booking = $stmt->fetch();
            if (!$booking) throw new Exception("Booking not found");

            // 2. Check if already accepted
            $stmt = $pdo->prepare("SELECT a.*, p.full_name as accepter_name, p.id as accepter_id, p.selfie_link as accepter_image,
                                         p.manual_verification_status as accepter_verification
                                  FROM accepted_bookings a 
                                  JOIN partners p ON a.partner_id = p.id 
                                  WHERE a.booking_id = ? AND a.status != 'Cancelled' LIMIT 1");
            $stmt->execute([$booking_id]);
            $acceptance = $stmt->fetch();

            // 3. Get Drivers & Vehicles for the current partner (to allow acceptance/sharing)
            $stmt = $pdo->prepare("SELECT id, full_name as name, phone, profile_image_path as image FROM drivers WHERE partner_id = ? AND status = 'Active'");
            $stmt->execute([$partner_id]);
            $drivers = $stmt->fetchAll();

            $stmt = $pdo->prepare("SELECT id, rc_number, maker_model, front_image as image FROM partner_vehicles WHERE partner_id = ? AND status = 'Active'");
            $stmt->execute([$partner_id]);
            $vehicles = $stmt->fetchAll();

            echo json_encode([
                'status' => 'success',
                'booking' => $booking,
                'acceptance' => $acceptance,
                'drivers' => $drivers,
                'vehicles' => $vehicles,
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
                $pusher->trigger("partner-$partner_id", 'chat-update', $event_data);
            } catch (Exception $e) { /* Log pusher error but don't fail message insertion */ }

            // ── Send OneSignal Push Notification ──
            try {
                require_once __DIR__ . '/../includes/notification_helper.php';
                
                // Identify recipient role to construct External ID
                $isDriver = false;
                $stmtCheck = $pdo->prepare("SELECT id FROM drivers WHERE id = ?");
                $stmtCheck->execute([$receiver_id]);
                if ($stmtCheck->fetch()) {
                    $isDriver = true;
                }

                $externalId = ($isDriver ? "driver_" : "partner_") . $receiver_id;
                
                $stName = $pdo->prepare("SELECT full_name FROM partners WHERE id = ?");
                $stName->execute([$partner_id]);
                $senderName = $stName->fetchColumn() ?: 'Partner';
                
                NotificationHelper::send($externalId, "New message from $senderName", $message, [
                    'type' => 'chat',
                    'booking_id' => $booking_id,
                    'sender_id' => $partner_id
                ]);
            } catch (Exception $nf) {}

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
            $chats = $stmt->fetchAll();
            
            echo json_encode(['status' => 'success', 'chats' => $chats]);
            break;

        case 'mark_as_read':
            $other_id = $_POST['other_id'] ?? '';
            if (empty($other_id)) throw new Exception("Other ID required");
            $stmt = $pdo->prepare("UPDATE booking_chats SET is_read = 1 
                                  WHERE booking_id = ? AND sender_id = ? AND receiver_id = ? AND is_read = 0");
            $stmt->execute([$booking_id, $other_id, $partner_id]);
            echo json_encode(['status' => 'success']);
            break;

        case 'accepter_cancel_booking':
            // Accepter cancels the booking they already accepted
            $stmt = $pdo->prepare("SELECT * FROM accepted_bookings WHERE booking_id = ? AND partner_id = ? AND status = 'Accepted'");
            $stmt->execute([$booking_id, $partner_id]);
            $accepted = $stmt->fetch();
            
            if (!$accepted) throw new Exception("You have not active acceptance for this booking");

            $pdo->beginTransaction();
            try {
                // 1. Calculate Penalty based on time elapsed since acceptance
                $acceptedAt = strtotime($accepted['accepted_at']);
                $currentTime = time();
                $diffMinutes = ($currentTime - $acceptedAt) / 60;
                
                $penalty = 0;
                if ($diffMinutes > 30) {
                    $penalty = 1500;
                } elseif ($diffMinutes > 15) {
                    $penalty = 500;
                } elseif ($diffMinutes > 5) {
                    $penalty = 100;
                }
                
                $penaltyMsg = "";
                if ($penalty > 0) {
                    if (!updateWallet($pdo, $partner_id, $penalty, 'Debit', 'Penalty', $accepted['id'], "Penalty for Cancelling Booking #$booking_id after " . ceil($diffMinutes) . " minutes")) {
                        throw new Exception("Penalty deduction failed");
                    }
                    $penaltyMsg = " A penalty of ₹$penalty has been deducted from your wallet as per the policy.";
                }

                // 2. Delete acceptance entirely (so it can be accepted again)
                $stmt = $pdo->prepare("DELETE FROM accepted_bookings WHERE id = ?");
                $stmt->execute([$accepted['id']]);

                // 3. Set partner_bookings back to Open
                $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Open' WHERE id = ?");
                $stmt->execute([$booking_id]);

                // 4. Refund commission if > 0 (always refund to wallet as Credits)
                $commission = (float)$accepted['commission'];
                if ($commission > 0) {
                    if (!updateWallet($pdo, $partner_id, $commission, 'Credit', 'Refund', $accepted['id'], "Refund for Cancelling Booking #$booking_id")) {
                        throw new Exception("Refund failed");
                    }
                }
                
                $pdo->commit();
                
                try {
                    $pusher->trigger('market-channel', 'list-updated', ['id' => $booking_id, 'action' => 'updated']);
                } catch (Exception $e) {}

                echo json_encode(['status' => 'success', 'message' => 'Booking cancelled and is now Open again. Commission has been refunded.' . $penaltyMsg]);
            } catch (Exception $e) {
                $pdo->rollBack();
                throw $e;
            }
            break;

        case 'accept_booking':
            throw new Exception("Use accept_with_wallet or accept_create_razorpay_order instead");
            break;

        case 'accept_with_wallet':
            $driver_id = $_POST['driver_id'] ?? '';
            $commission = $_POST['commission'] ?? 0;
            if (empty($driver_id)) throw new Exception("Driver assignment is mandatory");

            // 1. Get meta and check for self-acceptance
            $stmt = $pdo->prepare("SELECT partner_id, total_amount FROM partner_bookings WHERE id = ?");
            $stmt->execute([$booking_id]);
            $bookingMeta = $stmt->fetch();
            if (!$bookingMeta) throw new Exception("Booking not found");
            if ($bookingMeta['partner_id'] == $partner_id) throw new Exception("You cannot accept your own booking. Please chat with a partner to request a commission.");

            // 2. Check if already taken by someone else
            $stmt = $pdo->prepare("SELECT partner_id FROM accepted_bookings WHERE booking_id = ? AND status != 'Cancelled'");
            $stmt->execute([$booking_id]);
            $accepted = $stmt->fetch();
            if ($accepted && $accepted['partner_id'] != $partner_id) throw new Exception("Already accepted by another partner");

            // 2. Check Wallet (Must have commission + 300 minimum balance)
            $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $wallet = $stmt->fetch();
            $required = (float)$commission + 300;
            if (!$wallet || $wallet['balance'] < $required) {
                throw new Exception("Insufficient wallet balance. You need a minimum balance of ₹" . number_format($required, 2) . " (₹300 security deposit + ₹" . $commission . " commission) to accept this booking.");
            }

            $pdo->beginTransaction();
            try {
                // 2.5 Fetch Total Amount for DB storage
                $total_amount = $bookingMeta['total_amount'] ?? 0;
                
                // 2.6 Fallback for Negotiable bookings
                if ($total_amount == 0 || $total_amount == 'Negotiable') {
                    $qStmt = $pdo->prepare("SELECT payload FROM booking_chats WHERE booking_id = ? AND type = 'quote_request' ORDER BY id DESC LIMIT 1");
                    $qStmt->execute([$booking_id]);
                    $lastQuote = $qStmt->fetch();
                    if ($lastQuote) {
                        $payload = json_decode($lastQuote['payload'], true);
                        $total_amount = $payload['fare'] ?? $total_amount;
                    }
                }

                // 3. Update/Insert Acceptance
                $stmt = $pdo->prepare("INSERT INTO accepted_bookings (booking_id, partner_id, driver_id, status, total_fare, commission, payment_status) 
                                       VALUES (?, ?, ?, 'Accepted', ?, ?, 'Paid') 
                                       ON DUPLICATE KEY UPDATE status='Accepted', driver_id=VALUES(driver_id), 
                                                               total_fare=VALUES(total_fare), commission=VALUES(commission), payment_status='Paid'");
                $stmt->execute([$booking_id, $partner_id, $driver_id, $total_amount, $commission]);
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

            // 1. Prevent self-payment
            $stmt = $pdo->prepare("SELECT partner_id, total_amount FROM partner_bookings WHERE id = ?");
            $stmt->execute([$booking_id]);
            $bookingMeta = $stmt->fetch();
            if (!$bookingMeta) throw new Exception("Booking not found");
            if ($bookingMeta['partner_id'] == $partner_id) throw new Exception("You cannot accept your own booking.");

            // 2. Already accepted check
            $stmt = $pdo->prepare("SELECT partner_id FROM accepted_bookings WHERE booking_id = ? AND status != 'Cancelled'");
            $stmt->execute([$booking_id]);
            $accepted = $stmt->fetch();
            if ($accepted && $accepted['partner_id'] != $partner_id) throw new Exception("Already accepted by another partner");

            // 2.1 Check Wallet Minimum Balance (₹300)
            $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
            $stmt->execute([$partner_id]);
            $wallet = $stmt->fetch();
            $required_base = 300; // Minimum security deposit
            if (!$wallet || $wallet['balance'] < $required_base) {
                throw new Exception("Minimum wallet balance of ₹300 (security deposit) is required to accept bookings via Razorpay. Please top up your wallet first.");
            }
            if (empty($commission) || $commission == 0) {
                $qStmt = $pdo->prepare("SELECT payload FROM booking_chats WHERE booking_id = ? AND type = 'quote_request' ORDER BY id DESC LIMIT 1");
                $qStmt->execute([$booking_id]);
                $lastQuote = $qStmt->fetch();
                if ($lastQuote) {
                    $p = json_decode($lastQuote['payload'], true);
                    $commission = $p['comm'] ?? $commission;
                }
            }

            $config = getRazorpayConfig($pdo);
            if (!$config || $config['status'] !== 'Active') throw new Exception("Payment gateway not active");

            $amount_paise = (int)(round((float)$commission, 2) * 100);
            if ($amount_paise < 100) {
                throw new Exception("Minimum commission for Razorpay is ₹1.00. Your current commission is ₹$commission. Please use Wallet or request a higher commission.");
            }

            $api = new \Razorpay\Api\Api($config['key_id'], $config['key_secret']);
            $order = $api->order->create([
                'receipt' => 'acc_' . $booking_id . '_' . time(),
                'amount' => $amount_paise,
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
                // 2. Fetch Total Fare from Booking
                $stmt = $pdo->prepare("SELECT total_amount FROM partner_bookings WHERE id = ?");
                $stmt->execute([$booking_id]);
                $bookingMeta = $stmt->fetch();
                $total_fare = $bookingMeta['total_amount'] ?? 0;

                // 2.2 Fallback for Negotiable
                if ($total_fare == 0 || $total_fare == 'Negotiable' || empty($commission) || $commission == 0) {
                    $qStmt = $pdo->prepare("SELECT payload FROM booking_chats WHERE booking_id = ? AND type = 'quote_request' ORDER BY id DESC LIMIT 1");
                    $qStmt->execute([$booking_id]);
                    $lastQuote = $qStmt->fetch();
                    if ($lastQuote) {
                        $p = json_decode($lastQuote['payload'], true);
                        $total_fare = ($total_fare == 0 || $total_fare == 'Negotiable') ? ($p['fare'] ?? $total_fare) : $total_fare;
                        $commission = (empty($commission) || $commission == 0) ? ($p['comm'] ?? $commission) : $commission;
                    }
                }

                $stmt = $pdo->prepare("INSERT INTO accepted_bookings (booking_id, partner_id, driver_id, status, total_fare, commission, payment_status, razorpay_order_id, razorpay_payment_id, razorpay_signature) 
                                       VALUES (?, ?, ?, 'Accepted', ?, ?, 'Paid', ?, ?, ?) 
                                       ON DUPLICATE KEY UPDATE status='Accepted', driver_id=VALUES(driver_id), 
                                                               total_fare=VALUES(total_fare), commission=VALUES(commission), 
                                                               payment_status='Paid', razorpay_order_id=VALUES(razorpay_order_id), 
                                                               razorpay_payment_id=VALUES(razorpay_payment_id), razorpay_signature=VALUES(razorpay_signature)");
                $stmt->execute([$booking_id, $partner_id, $driver_id, $total_fare, $commission, $order_id, $payment_id, $signature]);
                
                $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Accepted' WHERE id = ?");
                $stmt->execute([$booking_id]);

                // Log as transaction (Paid but not from wallet, so maybe just log it)
                $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) VALUES (?, 'Debit', ?, 'Razorpay Acceptance', ?, ?)");
                $stmt->execute([$partner_id, $commission, $payment_id, "Commission payment for Booking #$booking_id via Razorpay"]);

                $pdo->commit();
                echo json_encode(['status' => 'success', 'message' => 'Payment verified. Booking accepted.']);
            } catch (Exception $e) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                throw new Exception("Payment verification failed: " . $e->getMessage());
            }
            break;

        case 'get_my_received':
            if (empty($partner_id)) throw new Exception("Partner ID required");
            $stmt = $pdo->prepare("SELECT a.id as acceptance_id, a.booking_id, a.status as acceptance_status, a.driver_id,
                                  b.pickup_location, b.drop_location, b.start_date, b.start_time, b.status as booking_status,
                                  a.total_fare as total_amount, a.commission as commission, 
                                  b.booking_type, 'fixed' as pricing_option, b.toll_tax, b.parking, b.note,
                                  p.full_name as partner_name, 
                                  p.mobile as partner_phone,
                                  ct.name as car_type_name, ct.image as car_type_image, 
                                  c.name as car_name, c.model as car_model
                                  FROM accepted_bookings a 
                                  JOIN partner_bookings b ON a.booking_id = b.id 
                                  JOIN partners p ON b.partner_id = p.id 
                                  LEFT JOIN cars c ON b.car_type = c.id
                                  LEFT JOIN car_types ct ON c.type_id = ct.id
                                  WHERE a.partner_id = ? 
                                  ORDER BY a.id DESC");
            $stmt->execute([$partner_id]);
            echo json_encode(['status' => 'success', 'bookings' => $stmt->fetchAll()]);
            break;

        case 'get_chat_list':
            // ── 1. Open (My own bookings) ──
            $sqlPosted = "SELECT BC.booking_id, BC.message, BC.created_at, P.full_name as partner_name, BC.type, P.id as other_id, P.selfie_link as partner_image, P.manual_verification_status as partner_verification,
                          (SELECT COUNT(*) FROM booking_chats WHERE booking_id = BC.booking_id AND receiver_id = ? AND sender_id = P.id AND is_read = 0) as unread_count
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
            $stmt->execute([$partner_id, $partner_id, $partner_id, $partner_id]);
            $posted = $stmt->fetchAll();

            // ── 2. Received (Others' bookings I chatted on / Accepted) ──
            $sqlReceived = "SELECT BC.booking_id, BC.message, BC.created_at, P.full_name as partner_name, BC.type, PB.partner_id as other_id, P.selfie_link as partner_image, P.manual_verification_status as partner_verification,
                            (SELECT COUNT(*) FROM booking_chats WHERE booking_id = BC.booking_id AND receiver_id = ? AND sender_id = P.id AND is_read = 0) as unread_count
                            FROM booking_chats BC
                            JOIN partner_bookings PB ON BC.booking_id = PB.id
                            JOIN partners P ON P.id = PB.partner_id
                            WHERE (BC.sender_id = ? OR BC.receiver_id = ?)
                            AND PB.partner_id != ?
                            AND BC.id IN (
                                SELECT MAX(id) FROM booking_chats 
                                GROUP BY booking_id, (CASE WHEN sender_id = ? THEN receiver_id ELSE sender_id END)
                            )
                            ORDER BY BC.id DESC";
            $stmt = $pdo->prepare($sqlReceived);
            $stmt->execute([$partner_id, $partner_id, $partner_id, $partner_id, $partner_id]);
            $received = $stmt->fetchAll();

            echo json_encode([
                'status' => 'success',
                'open' => $posted,
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
