<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/pusher_config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

    try {
        $pdo->exec("ALTER TABLE accepted_bookings MODIFY COLUMN trip_status ENUM('Pending', 'OnWayToPickup', 'Arrived', 'Started', 'Completed') DEFAULT 'Pending'");
        
        $pdo->exec("CREATE TABLE IF NOT EXISTS driver_trip_logs (
            id INT AUTO_INCREMENT PRIMARY KEY,
            acceptance_id INT NOT NULL,
            booking_id INT NOT NULL,
            start_selfie VARCHAR(255),
            start_time DATETIME,
            start_location TEXT,
            start_odometer_reading INT,
            start_odometer_image VARCHAR(255),
            end_time DATETIME,
            end_location TEXT,
            end_odometer_reading INT,
            end_odometer_image VARCHAR(255),
            total_km DECIMAL(10,2),
            collect_amount DECIMAL(10,2),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE(acceptance_id)
        )");
    } catch(PDOException $e) {}

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

function uploadTripImage($file, $prefix, $booking_id) {
    if (!isset($file['tmp_name']) || empty($file['tmp_name'])) return null;
    $targetDir = __DIR__ . '/../uploads/trips/';
    if (!file_exists($targetDir)) mkdir($targetDir, 0777, true);
    
    $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
    $filename = $prefix . "_" . $booking_id . "_" . time() . "." . $ext;
    $targetFile = $targetDir . $filename;
    
    if (move_uploaded_file($file['tmp_name'], $targetFile)) {
        return "app/uploads/trips/" . $filename;
    }
    return null;
}

$action = $_POST['action'] ?? $_GET['action'] ?? '';
$driver_id = $_POST['driver_id'] ?? $_GET['driver_id'] ?? '';

if (empty($driver_id) && $action !== 'options' && $action !== 'update_trip_status') {
    echo json_encode(['success' => false, 'message' => 'Driver ID is required']);
    exit;
}

try {
    switch ($action) {
        case 'get_my_bookings':
            $stmt = $pdo->prepare("
                SELECT ab.id as acceptance_id, ab.booking_id, ab.driver_id, ab.status as acceptance_status, ab.trip_status,
                       pb.pickup_location, pb.drop_location, pb.start_date, pb.start_time,
                       pb.total_amount, pb.booking_type, pb.toll_tax, pb.parking, pb.stops, pb.commission,
                       ct.name AS car_type_name, ct.image AS car_type_image,
                       p.full_name as partner_name, p.mobile as partner_mobile
                FROM accepted_bookings ab 
                JOIN partner_bookings pb ON ab.booking_id = pb.id 
                JOIN partners p ON pb.partner_id = p.id
                LEFT JOIN cars c ON c.id = pb.car_type
                LEFT JOIN car_types ct ON ct.id = c.type_id
                WHERE ab.driver_id = ? 
                ORDER BY pb.start_date DESC, pb.start_time DESC
            ");
            $stmt->execute([$driver_id]);
            echo json_encode(['success' => true, 'bookings' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
            break;

        case 'update_trip_status':
            $acceptance_id = $_POST['acceptance_id'] ?? '';
            $status = $_POST['status'] ?? ''; // 'Started', 'Completed'

            if (empty($acceptance_id) || empty($status)) throw new Exception("Acceptance ID and Status required");

            // 1. Get current status and commission details
            $stmt = $pdo->prepare("
                SELECT ab.trip_status, ab.commission, ab.booking_id, pb.partner_id as poster_id 
                FROM accepted_bookings ab 
                JOIN partner_bookings pb ON ab.booking_id = pb.id 
                WHERE ab.id = ?
            ");
            $stmt->execute([$acceptance_id]);
            $trip = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$trip) throw new Exception("Trip acceptance record not found");
            
            // Avoid double completion logic
            if ($trip['trip_status'] === 'Completed') {
                echo json_encode(['success' => true, 'message' => "Trip is already completed"]);
                exit;
            }

            $pdo->beginTransaction();
            try {
                // 2. Update trip status
                $stmt = $pdo->prepare("UPDATE accepted_bookings SET trip_status = ? WHERE id = ?");
                $stmt->execute([$status, $acceptance_id]);

                $booking_id = $trip['booking_id'];

                // 2.A Handle Logging Trip Details
                if ($status === 'Started') {
                    $selfie = uploadTripImage($_FILES['start_selfie'] ?? null, 'selfie', $booking_id);
                    $odo_img = uploadTripImage($_FILES['start_odometer_image'] ?? null, 'odo_start', $booking_id);
                    $odo_reading = $_POST['start_odometer_reading'] ?? 0;
                    $location = $_POST['start_location'] ?? '';
                    $now = date('Y-m-d H:i:s');

                    $stmt = $pdo->prepare("INSERT INTO driver_trip_logs (acceptance_id, booking_id, start_selfie, start_time, start_location, start_odometer_reading, start_odometer_image) 
                                           VALUES (?, ?, ?, ?, ?, ?, ?)
                                           ON DUPLICATE KEY UPDATE start_selfie = VALUES(start_selfie), start_time = VALUES(start_time), start_location = VALUES(start_location), start_odometer_reading = VALUES(start_odometer_reading), start_odometer_image = VALUES(start_odometer_image)");
                    $stmt->execute([$acceptance_id, $booking_id, $selfie, $now, $location, $odo_reading, $odo_img]);
                }

                // 2.1 If OnWayToPickup, send tracking link to chat
                if ($status === 'OnWayToPickup') {
                    $poster_id = $trip['poster_id']; // This is the partner who POSTED the booking
                    
                    // The sender of the tracking link should be the one who ACCEPTED the booking
                    $stmt = $pdo->prepare("SELECT partner_id FROM accepted_bookings WHERE id = ?");
                    $stmt->execute([$acceptance_id]);
                    $accepter = $stmt->fetch();
                    $sender_id = $accepter['partner_id'];

                    $tracking_url = "https://chooseataxi.com/driver-location/track_trip.php?booking_id=$booking_id";
                    $msg = "Driver is on the way to Pickup point. Track live here: $tracking_url";
                    
                    $stmt = $pdo->prepare("INSERT INTO booking_chats (booking_id, sender_id, receiver_id, message, type) VALUES (?, ?, ?, ?, 'tracking_link')");
                    $stmt->execute([$booking_id, $sender_id, $poster_id, $msg]);

                    // Trigger pusher for chat update
                    try {
                        $pusher->trigger("chat-$booking_id", 'new-message', [
                            'message' => $msg,
                            'sender_id' => $sender_id,
                            'type' => 'tracking_link'
                        ]);
                    } catch (Exception $e) {}
                }

                // 3. If completed, credit the poster
                if ($status === 'Completed') {
                    $poster_id = $trip['poster_id'];
                    $commission = (float)$trip['commission'];
                    
                    // Log End Details
                    $odo_img = uploadTripImage($_FILES['end_odometer_image'] ?? null, 'odo_end', $booking_id);
                    $odo_reading = $_POST['end_odometer_reading'] ?? 0;
                    $location = $_POST['end_location'] ?? '';
                    $total_km = $_POST['total_km'] ?? 0;
                    $collect_amount = $_POST['collect_amount'] ?? 0;
                    $now = date('Y-m-d H:i:s');

                    $stmt = $pdo->prepare("UPDATE driver_trip_logs SET end_time = ?, end_location = ?, end_odometer_reading = ?, end_odometer_image = ?, total_km = ?, collect_amount = ? WHERE acceptance_id = ?");
                    $stmt->execute([$now, $location, $odo_reading, $odo_img, $total_km, $collect_amount, $acceptance_id]);

                    // Update main booking status too
                    $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Completed' WHERE id = ?");
                    $stmt->execute([$booking_id]);

                    if ($commission > 0) {
                        // Ensure poster wallet exists
                        $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
                        $stmt->execute([$poster_id]);

                        // Credit the commission
                        $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
                        $stmt->execute([$commission, $poster_id]);

                        // Log transaction
                        $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) 
                                               VALUES (?, 'Credit', ?, 'Booking Commission', ?, ?)");
                        $stmt->execute([$poster_id, $commission, $acceptance_id, "Commission for Booking #$booking_id (Trip Completed)"]);
                    }
                }

                $pdo->commit();

                // 4. Trigger Real-time Notification for Poster
                try {
                    $pusher->trigger("partner-$poster_id", 'chat-update', [
                        'type' => 'status_update',
                        'booking_id' => $booking_id,
                        'new_status' => $status
                    ]);
                } catch (Exception $e) {}

                echo json_encode(['success' => true, 'message' => "Trip status updated to $status"]);
            } catch (Exception $e) {
                $pdo->rollBack();
                throw $e;
            }
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
