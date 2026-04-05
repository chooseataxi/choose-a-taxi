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

if (empty($partner_id) || empty($booking_id)) {
    if ($action !== 'options') {
        echo json_encode(['status' => 'error', 'message' => 'Partner ID and Booking ID required']);
        exit;
    }
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
    switch ($action) {
        case 'get_details':
            // 1. Get Booking Main Info
            $stmt = $pdo->prepare("SELECT b.*, p.full_name as poster_name 
                                  FROM partner_bookings b 
                                  JOIN partners p ON b.partner_id = p.id 
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
            $pusher->trigger("booking-chat-$booking_id", 'new-message', $event_data);

            echo json_encode(['status' => 'success', 'chat' => $event_data]);
            break;

        case 'get_chat_history':
            $stmt = $pdo->prepare("SELECT * FROM booking_chats WHERE booking_id = ? ORDER BY id ASC");
            $stmt->execute([$booking_id]);
            echo json_encode(['status' => 'success', 'chats' => $stmt->fetchAll()]);
            break;

        case 'accept_booking':
            $driver_id = $_POST['driver_id'] ?? '';
            if (empty($driver_id)) throw new Exception("Driver assignment is mandatory");

            // Check if already taken
            $stmt = $pdo->prepare("SELECT id FROM accepted_bookings WHERE booking_id = ? AND status != 'Cancelled'");
            $stmt->execute([$booking_id]);
            if ($stmt->fetch()) throw new Exception("This booking has already been accepted by another partner");

            $stmt = $pdo->prepare("INSERT INTO accepted_bookings (booking_id, partner_id, driver_id, status) VALUES (?, ?, ?, 'Pending')");
            $stmt->execute([$booking_id, $partner_id, $driver_id]);
            
            echo json_encode(['status' => 'success', 'message' => 'Booking locked. Please complete commission payment.']);
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

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
