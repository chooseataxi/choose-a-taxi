require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/pusher_config.php';
require_once __DIR__ . '/../../vendor/autoload.php';

// Lazy Migration: Add trip_status to accepted_bookings if not exists
try {
    $pdo->query("SELECT trip_status FROM accepted_bookings LIMIT 1");
} catch(PDOException $e) {
    try {
        $pdo->exec("ALTER TABLE accepted_bookings ADD COLUMN trip_status ENUM('Pending', 'Started', 'Completed') DEFAULT 'Pending'");
    } catch(PDOException $e) {}
}

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
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
                       pb.total_amount, pb.booking_type, pb.toll_tax, pb.parking,
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

                // 3. If completed, credit the poster
                if ($status === 'Completed') {
                    $poster_id = $trip['poster_id'];
                    $commission = (float)$trip['commission'];
                    $booking_id = $trip['booking_id'];

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
