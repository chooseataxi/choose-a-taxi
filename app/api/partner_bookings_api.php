<?php
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");

// Define CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$action = $_REQUEST['action'] ?? '';

if ($action === 'get_cars') {
    $trip_type = $_GET['trip_type'] ?? '';
    try {
        // Enforce the integer starting parameter block safely on runtime
        $pdo->exec("ALTER TABLE partner_bookings AUTO_INCREMENT = 2627600");

        $sql = "SELECT c.id, c.name, c.model FROM cars c 
                JOIN trip_types t ON c.trip_type_id = t.id 
                WHERE c.status = 'Active' AND t.name LIKE ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(["%$trip_type%"]);
        $cars = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if (empty($cars)) {
            echo json_encode([
                "status" => "success", 
                "cars" => [],
                "message" => "No cars are currently added for the trip type"
            ]);
            exit;
        }

        $formatted = array_map(function($c) { 
            return ['id' => $c['id'], 'name' => $c['name'] . ' ' . ($c['model'] ?? '')]; 
        }, $cars);
        
        echo json_encode(["status" => "success", "cars" => $formatted]);
        exit;
    } catch (PDOException $e) {
        echo json_encode([
            "status" => "success", 
            "cars" => [], 
            "message" => "No cars are currently added for the trip type"
        ]);
        exit;
    }
}

if ($action === 'create_booking') {
    $raw = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data)) { 
        $data = $_POST; 
    }
    
    $partner_id = $data['partner_id'] ?? 1; // Simulated Auth token link
    
    $booking_type = $data['booking_type'] ?? '';
    if ($booking_type === 'One Way Trip') {
        $booking_type = 'One Way';
    }
    $pickup = $data['pickup_location'] ?? '';
    $drop = $data['drop_location'] ?? '';
    $stops = json_encode($data['stops'] ?? []);
    $car_type = $data['car_type'] ?? '';
    $start_date = $data['start_date'] ?? null;
    $start_time = $data['start_time'] ?? null;
    $end_date = !empty($data['end_date']) ? $data['end_date'] : null;
    $end_time = !empty($data['end_time']) ? $data['end_time'] : null;
    $pricing_option = $data['pricing_option'] ?? 'quote';
    $total_amount = !empty($data['total_amount']) ? $data['total_amount'] : null;
    $commission = !empty($data['commission']) ? $data['commission'] : null;
    $toll = $data['toll_tax'] ?? 'Included';
    $parking = $data['parking'] ?? 'Included';
    $note = $data['note'] ?? '';
    $preferences = json_encode($data['preferences'] ?? []);

    try {
        $sql = "INSERT INTO partner_bookings (
            partner_id, booking_type, pickup_location, drop_location, stops, 
            car_type, start_date, start_time, end_date, end_time, 
            pricing_option, total_amount, commission, toll_tax, parking, note, preferences
        ) VALUES (
            ?, ?, ?, ?, ?, 
            ?, ?, ?, ?, ?, 
            ?, ?, ?, ?, ?, ?, ?
        )";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $partner_id, $booking_type, $pickup, $drop, $stops,
            $car_type, $start_date, $start_time, $end_date, $end_time,
            $pricing_option, $total_amount, $commission, $toll, $parking, $note, $preferences
        ]);
        echo json_encode(["status" => "success", "message" => "Booking created successfully!"]);
    } catch (PDOException $e) {
        // Expose underlying database constraints to Flutter resolving fake success bugs securely
        echo json_encode(["status" => "error", "message" => "SQL Error: " . $e->getMessage()]);
    }
    exit;
}

echo json_encode(["status" => "error", "message" => "Invalid action requested"]);
