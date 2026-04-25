<?php
// error_reporting(0);
// ini_set('display_errors', 0);
set_exception_handler(function ($e) {
    echo json_encode(["status" => "error", "message" => "Critical Error: " . $e->getMessage()]);
    exit;
});
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/pusher_config.php';
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$action = $_REQUEST['action'] ?? '';

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: get_trip_types — for dynamic filter synchronization
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'get_trip_types') {
    try {
        $sql = "SELECT DISTINCT name FROM trip_types WHERE status = 'Active'";
        if (isset($_GET['market_only'])) {
            // Optional: filter for types that actually have active bookings if needed
        }
        $stmt = $pdo->query($sql);
        $types = $stmt->fetchAll(PDO::FETCH_COLUMN);

        // Map common variations for client-side consistency
        $formatted = array_map(function ($t) {
            if ($t === 'One Way')
                return 'One Way Trip';
            return $t;
        }, $types);

        echo json_encode(["status" => "success", "types" => $formatted]);
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: get_cars  — for create booking dropdown
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'get_cars') {
    try {
        $sql = "SELECT id, name, image AS type_image FROM car_types WHERE status = 'Active'";
        $stmt = $pdo->query($sql);
        $cars = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (empty($cars)) {
            echo json_encode([
                "status" => "success",
                "cars" => [],
                "message" => "No car types found"
            ]);
            exit;
        }

        $formatted = array_map(function ($c) {
            return [
                'id' => $c['id'],
                'name' => $c['name'] ?? 'Unknown Type',
                'type_name' => $c['name'] ?? '',
                'type_image' => $c['type_image'] ?? '',
            ];
        }, $cars);

        echo json_encode(["status" => "success", "cars" => $formatted]);
        exit;
    } catch (PDOException $e) {
        echo json_encode([
            "status" => "success",
            "cars" => [],
            "message" => "Error fetching car types: " . $e->getMessage()
        ]);
        exit;
    }
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: create_booking
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'create_booking') {
    $raw = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data)) {
        $data = $_POST;
    }

    $partner_id = $data['partner_id'] ?? 1;

    $booking_type = $data['booking_type'] ?? '';
    if ($booking_type === 'One Way Trip') {
        $booking_type = 'One Way';
    }
    $pickup = $data['pickup_location'] ?? '';
    $drop = $data['drop_location'] ?? '';
    $stops = isset($data['stops']) && is_string($data['stops']) ? $data['stops'] : json_encode($data['stops'] ?? []);
    $car_type = $data['car_type'] ?? '';
    $start_date = !empty($data['start_date']) ? $data['start_date'] : null;
    $start_time = !empty($data['start_time']) ? $data['start_time'] : null;
    $end_date = !empty($data['end_date']) ? $data['end_date'] : null;
    $end_time = !empty($data['end_time']) ? $data['end_time'] : null;
    $pricing_option = $data['pricing_option'] ?? 'quote';
    $total_amount = !empty($data['total_amount']) ? $data['total_amount'] : null;
    $commission = !empty($data['commission']) ? $data['commission'] : null;
    $toll = $data['toll_tax'] ?? 'Included';
    $parking = $data['parking'] ?? 'Included';
    $note = $data['note'] ?? '';
    $preferences = isset($data['preferences']) && is_string($data['preferences']) ? $data['preferences'] : json_encode($data['preferences'] ?? []);

    try {
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
            $partner_id,
            $booking_type,
            $pickup,
            $drop,
            $stops,
            $car_type,
            $start_date,
            $start_time,
            $end_date,
            $end_time,
            $pricing_option,
            $total_amount,
            $commission,
            $toll,
            $parking,
            $note,
            $preferences
        ]);
        $bookingId = $pdo->lastInsertId();

        // Broadcast real-time update via Pusher
        try {
            $pusher->trigger('market-channel', 'list-updated', ['id' => $bookingId]);
        } catch (Exception $e) {
        }

        // Send Push Notification to All
        try {
            require_once __DIR__ . '/../../vendor/autoload.php';
            require_once __DIR__ . '/../includes/notification_helper.php';
            $title = "New Booking Available!";
            $body = "From $pickup to $drop for $car_type. Tap to view!";
            NotificationHelper::broadcastToAll($pdo, $title, $body, [
                'type' => 'new_booking',
                'booking_id' => $bookingId
            ], $partner_id);
        } catch (Exception $nf) {
        }

        echo json_encode(["status" => "success", "message" => "Booking created successfully!", "booking_id" => $bookingId]);
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "SQL Error: " . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: update_booking
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'update_booking') {
    $raw = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data)) {
        $data = $_POST;
    }

    $booking_id = $data['booking_id'] ?? '';
    $partner_id = $data['partner_id'] ?? 1;

    if (empty($booking_id)) {
        echo json_encode(["status" => "error", "message" => "Booking ID is required"]);
        exit;
    }

    $booking_type = $data['booking_type'] ?? '';
    if ($booking_type === 'One Way Trip') {
        $booking_type = 'One Way';
    }
    $pickup = $data['pickup_location'] ?? '';
    $drop = $data['drop_location'] ?? '';
    $stops = isset($data['stops']) && is_string($data['stops']) ? $data['stops'] : json_encode($data['stops'] ?? []);
    $car_type = $data['car_type'] ?? '';
    $start_date = !empty($data['start_date']) ? $data['start_date'] : null;
    $start_time = !empty($data['start_time']) ? $data['start_time'] : null;
    $end_date = !empty($data['end_date']) ? $data['end_date'] : null;
    $end_time = !empty($data['end_time']) ? $data['end_time'] : null;
    $pricing_option = $data['pricing_option'] ?? 'quote';
    $total_amount = !empty($data['total_amount']) ? $data['total_amount'] : null;
    $commission = !empty($data['commission']) ? $data['commission'] : null;
    $toll = $data['toll_tax'] ?? 'Included';
    $parking = $data['parking'] ?? 'Included';
    $note = $data['note'] ?? '';
    $preferences = isset($data['preferences']) && is_string($data['preferences']) ? $data['preferences'] : json_encode($data['preferences'] ?? []);

    try {
        $sql = "UPDATE partner_bookings SET
            booking_type = ?, pickup_location = ?, drop_location = ?, stops = ?, 
            car_type = ?, start_date = ?, start_time = ?, end_date = ?, end_time = ?, 
            pricing_option = ?, total_amount = ?, commission = ?, toll_tax = ?, parking = ?, note = ?, preferences = ?
            WHERE id = ? AND partner_id = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $booking_type,
            $pickup,
            $drop,
            $stops,
            $car_type,
            $start_date,
            $start_time,
            $end_date,
            $end_time,
            $pricing_option,
            $total_amount,
            $commission,
            $toll,
            $parking,
            $note,
            $preferences,
            $booking_id,
            $partner_id
        ]);

        // Broadcast real-time update via Pusher
        try {
            $pusher->trigger('market-channel', 'list-updated', ['id' => $booking_id, 'action' => 'updated']);
        } catch (Exception $e) {}

        echo json_encode(["status" => "success", "message" => "Booking updated successfully!", "booking_id" => $booking_id]);
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "SQL Error: " . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: get_bookings  — partner's own bookings (My Bookings tab)
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'get_bookings') {
    $partner_id = $_GET['partner_id'] ?? $_POST['partner_id'] ?? '';
    if (empty($partner_id)) {
        echo json_encode(["status" => "error", "message" => "partner_id is required"]);
        exit;
    }
    try {
        $pdo->exec("UPDATE partner_bookings 
                    SET status = 'Expired' 
                    WHERE status IN ('Open', 'Posted') 
                    AND (
                        STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %h:%i %p') < NOW()
                        OR STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %h:%i %p') < NOW()
                        OR STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %H:%i') < NOW()
                        OR STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %H:%i') < NOW()
                    )");
        $sql = "SELECT pb.*,
                    c.name  AS car_name,
                    c.model AS car_model,
                    ct.name  AS car_type_name,
                    ct.image AS car_type_image,
                    p.full_name AS partner_name,
                    p.selfie_link AS partner_image,
                    p.mobile AS partner_phone,
                    acc_p.full_name AS accepted_partner_name,
                    acc_p.mobile AS accepted_partner_phone,
                    acc.partner_id AS accepted_partner_id
                FROM partner_bookings pb
                LEFT JOIN cars c  ON c.id = pb.car_type
                LEFT JOIN car_types ct ON ct.id = c.type_id
                LEFT JOIN partners p ON p.id = pb.partner_id
                LEFT JOIN accepted_bookings acc ON acc.booking_id = pb.id AND acc.status != 'Cancelled'
                LEFT JOIN partners acc_p ON acc_p.id = acc.partner_id
                WHERE pb.partner_id = ?
                ORDER BY pb.start_date ASC, pb.start_time ASC, pb.id DESC";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$partner_id]);
        $bookings = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(["status" => "success", "bookings" => $bookings]);
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "DB Error: " . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: get_market_bookings  — all open bookings for main dashboard
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'get_market_bookings') {
    try {
        // Auto-expire open bookings that are past their start time
        // Using %h:%i %p for `10:00 PM` format. If it's `22:00` format, %H:%i is used.
        $pdo->exec("UPDATE partner_bookings 
                    SET status = 'Expired' 
                    WHERE status IN ('Open', 'Posted') 
                    AND (
                        STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %h:%i %p') < NOW()
                        OR STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %h:%i %p') < NOW()
                        OR STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%d-%m-%Y %H:%i') < NOW()
                        OR STR_TO_DATE(CONCAT(start_date, ' ', start_time), '%Y-%m-%d %H:%i') < NOW()
                    )");
        $sql = "SELECT pb.*,
                    c.name   AS car_name,
                    c.model  AS car_model,
                    ct.name  AS car_type_name,
                    ct.image AS car_type_image,
                    p.full_name AS partner_name,
                    p.selfie_link AS partner_image,
                    p.mobile AS partner_phone
                FROM partner_bookings pb
                LEFT JOIN cars c       ON c.id = pb.car_type
                LEFT JOIN car_types ct ON ct.id = c.type_id
                LEFT JOIN partners p   ON p.id = pb.partner_id
                WHERE pb.status IN ('Open', 'Posted', 'Active')
                ORDER BY pb.start_date ASC, pb.start_time ASC, pb.id DESC
                LIMIT 50";
        $stmt = $pdo->query($sql);
        $bookings = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(["status" => "success", "bookings" => $bookings]);
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "DB Error: " . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: delete_booking
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'delete_booking') {
    $booking_id = $_REQUEST['booking_id'] ?? '';
    $partner_id = $_REQUEST['partner_id'] ?? '';

    if (empty($booking_id) || empty($partner_id)) {
        echo json_encode(["status" => "error", "message" => "Booking ID and Partner ID are required"]);
        exit;
    }

    try {
        $pdo->beginTransaction();

        $stmt = $pdo->prepare("SELECT partner_id FROM partner_bookings WHERE id = ?");
        $stmt->execute([$booking_id]);
        $booking = $stmt->fetch();

        if (!$booking)
            throw new Exception("Booking not found");
        if ($booking['partner_id'] != $partner_id)
            throw new Exception("You are not authorized to delete this booking");

        $stmt = $pdo->prepare("DELETE FROM accepted_bookings WHERE booking_id = ?");
        $stmt->execute([$booking_id]);

        $stmt = $pdo->prepare("DELETE FROM partner_bookings WHERE id = ?");
        $stmt->execute([$booking_id]);

        $pdo->commit();

        try {
            $pusher->trigger('market-channel', 'list-updated', ['id' => $booking_id, 'action' => 'deleted']);
        } catch (Exception $e) {}

        echo json_encode(["status" => "success", "message" => "Booking deleted successfully"]);
    } catch (Exception $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        echo json_encode(["status" => "error", "message" => "Error: " . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: cancel_booking
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'cancel_booking') {
    $booking_id = $_REQUEST['booking_id'] ?? '';
    $partner_id = $_REQUEST['partner_id'] ?? '';

    if (empty($booking_id) || empty($partner_id)) {
        echo json_encode(["status" => "error", "message" => "Booking ID and Partner ID are required"]);
        exit;
    }

    try {
        $pdo->beginTransaction();

        // 1. Verify owner
        $stmt = $pdo->prepare("SELECT partner_id, status FROM partner_bookings WHERE id = ?");
        $stmt->execute([$booking_id]);
        $booking = $stmt->fetch();

        if (!$booking)
            throw new Exception("Booking not found");
        if ($booking['partner_id'] != $partner_id)
            throw new Exception("You are not authorized to cancel this booking");
        if ($booking['status'] === 'Cancelled')
            throw new Exception("Booking is already cancelled");
        if ($booking['status'] === 'Completed')
            throw new Exception("Cannot cancel a completed booking");

        // 2. Update booking status
        $stmt = $pdo->prepare("UPDATE partner_bookings SET status = 'Cancelled' WHERE id = ?");
        $stmt->execute([$booking_id]);

        // 3. Update acceptance status if any (where not already cancelled)
        $stmt = $pdo->prepare("UPDATE accepted_bookings SET status = 'Cancelled' WHERE booking_id = ? AND status != 'Cancelled'");
        $stmt->execute([$booking_id]);

        $pdo->commit();

        // Broadcast real-time update
        try {
            $pusher->trigger('market-channel', 'list-updated', ['id' => $booking_id, 'action' => 'cancelled']);
        } catch (Exception $e) {
        }

        echo json_encode(["status" => "success", "message" => "Booking cancelled successfully"]);
    } catch (Exception $e) {
        if ($pdo->inTransaction())
            $pdo->rollBack();
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: update_booking_preferences
// ──────────────────────────────────────────────────────────────────────────────
if ($action === 'update_booking_preferences') {
    $raw = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data))
        $data = $_POST;

    $booking_id = $data['booking_id'] ?? '';
    $partner_id = $data['partner_id'] ?? '';
    $approach = $data['approach_type'] ?? 'first_driver';
    $allow_calls = isset($data['allow_calls']) ? (int) $data['allow_calls'] : 1;

    if (empty($booking_id) || empty($partner_id)) {
        echo json_encode(["status" => "error", "message" => "Booking ID and Partner ID are required"]);
        exit;
    }

    try {
        $stmt = $pdo->prepare("UPDATE partner_bookings SET approach_type = ?, allow_calls = ? WHERE id = ? AND partner_id = ?");
        $stmt->execute([$approach, $allow_calls, $booking_id, $partner_id]);
        echo json_encode(["status" => "success", "message" => "Booking preferences updated successfully"]);
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "DB Error: " . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// ACTION: default
// ──────────────────────────────────────────────────────────────────────────────
echo json_encode(["status" => "error", "message" => "Invalid action requested"]);
