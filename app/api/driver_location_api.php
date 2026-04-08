<?php
require_once __DIR__ . '/../../includes/db.php';

// Lazy Migration: Add driver_locations table
try {
    $pdo->query("SELECT id FROM driver_locations LIMIT 1");
} catch(PDOException $e) {
    try {
        $pdo->exec("CREATE TABLE driver_locations (
            id INT AUTO_INCREMENT PRIMARY KEY,
            driver_id INT NOT NULL,
            booking_id INT NOT NULL,
            latitude DECIMAL(10, 8) NOT NULL,
            longitude DECIMAL(11, 8) NOT NULL,
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            INDEX (driver_id),
            INDEX (booking_id)
        )");
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

try {
    switch ($action) {
        case 'update_location':
            $driver_id = $_POST['driver_id'] ?? '';
            $booking_id = $_POST['booking_id'] ?? '';
            $lat = $_POST['latitude'] ?? '';
            $lng = $_POST['longitude'] ?? '';

            if (empty($driver_id) || empty($booking_id) || empty($lat) || empty($lng)) {
                throw new Exception("Missing parameters");
            }

            // Check if record exists
            $stmt = $pdo->prepare("SELECT id FROM driver_locations WHERE booking_id = ? AND driver_id = ?");
            $stmt->execute([$booking_id, $driver_id]);
            $exists = $stmt->fetch();

            if ($exists) {
                $stmt = $pdo->prepare("UPDATE driver_locations SET latitude = ?, longitude = ?, last_updated = CURRENT_TIMESTAMP WHERE id = ?");
                $stmt->execute([$lat, $lng, $exists['id']]);
            } else {
                $stmt = $pdo->prepare("INSERT INTO driver_locations (driver_id, booking_id, latitude, longitude) VALUES (?, ?, ?, ?)");
                $stmt->execute([$driver_id, $booking_id, $lat, $lng]);
            }

            echo json_encode(['success' => true]);
            break;

        case 'get_location':
            $booking_id = $_GET['booking_id'] ?? '';
            if (empty($booking_id)) throw new Exception("Booking ID required");

            $stmt = $pdo->prepare("SELECT dl.*, d.full_name as driver_name 
                                  FROM driver_locations dl 
                                  JOIN drivers d ON dl.driver_id = d.id 
                                  WHERE dl.booking_id = ? ORDER BY dl.last_updated DESC LIMIT 1");
            $stmt->execute([$booking_id]);
            $loc = $stmt->fetch();

            if (!$loc) throw new Exception("No location found");

            echo json_encode(['success' => true, 'data' => $loc]);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
