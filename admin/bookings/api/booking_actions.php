<?php
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$action = $_POST['action'] ?? '';

try {
    switch ($action) {
        case 'cancel_booking':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("Booking ID missing.");

            $pdo->beginTransaction();
            
            // Update booking status
            $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Cancelled' WHERE id = ?");
            $stmt->execute([$id]);

            // Update acceptance status if any
            $stmt = $pdo->prepare("UPDATE accepted_bookings SET status = 'Cancelled' WHERE booking_id = ? AND status != 'Cancelled'");
            $stmt->execute([$id]);

            $pdo->commit();
            
            echo json_encode(['success' => true, 'message' => 'Booking cancelled successfully!']);
            break;

        case 'create_booking':
            $partner_id = $_POST['partner_id'] ?? 0;
            $booking_type = $_POST['booking_type'] ?? '';
            $pickup = $_POST['pickup_location'] ?? '';
            $drop = $_POST['drop_location'] ?? '';
            $stops = isset($_POST['stops']) ? json_encode($_POST['stops']) : '[]';
            $car_type = $_POST['car_type'] ?? '';
            $start_date = $_POST['start_date'] ?? null;
            $start_time = $_POST['start_time'] ?? null;
            $end_date = !empty($_POST['end_date']) ? $_POST['end_date'] : null;
            $end_time = !empty($_POST['end_time']) ? $_POST['end_time'] : null;
            $pricing_option = $_POST['pricing_option'] ?? 'fixed';
            $total_amount = !empty($_POST['total_amount']) ? $_POST['total_amount'] : null;
            $commission = !empty($_POST['commission']) ? $_POST['commission'] : null;
            $toll = $_POST['toll_tax'] ?? 'Included';
            $parking = $_POST['parking'] ?? 'Included';
            $note = $_POST['note'] ?? '';
            $preferences = isset($_POST['preferences']) ? json_encode($_POST['preferences']) : '[]';

            if (empty($partner_id) || empty($booking_type) || empty($pickup) || empty($drop) || empty($car_type)) {
                throw new Exception("Please fill in all required fields.");
            }

            $sql = "INSERT INTO partner_bookings (
                partner_id, booking_type, pickup_location, drop_location, stops, 
                car_type, start_date, start_time, end_date, end_time, 
                pricing_option, total_amount, commission, toll_tax, parking, note, preferences, status
            ) VALUES (
                ?, ?, ?, ?, ?, 
                ?, ?, ?, ?, ?, 
                ?, ?, ?, ?, ?, ?, ?, 'Open'
            )";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                $partner_id, $booking_type, $pickup, $drop, $stops,
                $car_type, $start_date, $start_time, $end_date, $end_time,
                $pricing_option, $total_amount, $commission, $toll, $parking, $note, $preferences
            ]);

            $bookingId = $pdo->lastInsertId();

            // Trigger Real-time update
            require_once __DIR__ . '/../../../includes/pusher_config.php';
            try {
                $pusher->trigger('market-channel', 'list-updated', ['id' => $bookingId]);
            } catch (Exception $e) {}

            echo json_encode(['success' => true, 'message' => 'Booking posted to marketplace successfully!', 'id' => $bookingId]);
            break;

        case 'delete_booking':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("Booking ID missing.");
            
            // Foreign key ON DELETE CASCADE will handle accepted_bookings
            $stmt = $pdo->prepare("DELETE FROM partner_bookings WHERE id = ?");
            $stmt->execute([$id]);

            echo json_encode(['success' => true, 'message' => 'Booking deleted successfully!']);
            break;

        default:
            throw new Exception("Invalid action.");
    }

} catch (Exception $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
