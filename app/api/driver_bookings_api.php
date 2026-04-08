<?php
require_once __DIR__ . '/../../includes/db.php';

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

if (empty($driver_id) && $action !== 'options') {
    echo json_encode(['success' => false, 'message' => 'Driver ID is required']);
    exit;
}

try {
    switch ($action) {
        case 'get_my_bookings':
            $stmt = $pdo->prepare("
                SELECT ab.id as acceptance_id, ab.booking_id, ab.status as acceptance_status,
                       pb.pickup_location, pb.drop_location, pb.start_date, pb.start_time,
                       pb.total_amount, pb.booking_type,
                       p.full_name as partner_name, p.mobile as partner_mobile
                FROM accepted_bookings ab 
                JOIN partner_bookings pb ON ab.booking_id = pb.id 
                JOIN partners p ON pb.partner_id = p.id
                WHERE ab.driver_id = ? 
                ORDER BY pb.start_date DESC, pb.start_time DESC
            ");
            $stmt->execute([$driver_id]);
            echo json_encode(['success' => true, 'bookings' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
