<?php
header('Content-Type: application/json');
include '../../includes/db.php';

// --- MIGRATION BLOCK (AUTO-CREATE TABLES) ---
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS app_notices (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        status ENUM('active', 'inactive') DEFAULT 'active',
        created_at DATETIME
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_notices_seen (
        partner_id INT,
        notice_id INT,
        seen_at DATETIME,
        PRIMARY KEY (partner_id, notice_id)
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_booking_popups_seen (
        partner_id INT,
        booking_id INT,
        seen_at DATETIME,
        PRIMARY KEY (partner_id, booking_id)
    )");
} catch (Exception $e) {}
// --- END MIGRATION ---

$action = $_GET['action'] ?? $_POST['action'] ?? '';
$partner_id = $_GET['partner_id'] ?? $_POST['partner_id'] ?? '';

try {
    switch ($action) {
        case 'get_popups':
            if (empty($partner_id)) throw new Exception("Partner ID required");

            $response = [
                'status' => 'success',
                'notice' => null,
                'completed_bookings' => []
            ];

            // 1. Check for active notice not seen by this partner
            $stmt = $pdo->prepare("SELECT n.* FROM app_notices n 
                                  LEFT JOIN partner_notices_seen s ON n.id = s.notice_id AND s.partner_id = ?
                                  WHERE n.status = 'active' AND s.notice_id IS NULL 
                                  ORDER BY n.id DESC LIMIT 1");
            $stmt->execute([$partner_id]);
            $notice = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($notice) {
                $response['notice'] = $notice;
            }

            // 2. Check for completed bookings not seen by this partner
            // We check both poster and accepter
            $stmt = $pdo->prepare("SELECT b.id, b.pickup_location, b.drop_location, b.start_date, b.start_time, b.total_amount, 
                                  b.booking_type, b.car_type, ct.name as car_type_name
                                  FROM partner_bookings b
                                  LEFT JOIN car_types ct ON (ct.id = b.car_type OR ct.name = b.car_type)
                                  LEFT JOIN partner_booking_popups_seen s ON b.id = s.booking_id AND s.partner_id = ?
                                  WHERE b.status = 'Completed' 
                                  AND (b.partner_id = ? OR b.id IN (SELECT booking_id FROM accepted_bookings WHERE partner_id = ? AND status='Accepted'))
                                  AND s.booking_id IS NULL");
            $stmt->execute([$partner_id, $partner_id, $partner_id]);
            $response['completed_bookings'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

            echo json_encode($response);
            break;

        case 'mark_notice_seen':
            $notice_id = $_POST['notice_id'] ?? '';
            if (empty($partner_id) || empty($notice_id)) throw new Exception("Missing params");
            
            $stmt = $pdo->prepare("INSERT IGNORE INTO partner_notices_seen (partner_id, notice_id, seen_at) VALUES (?, ?, NOW())");
            $stmt->execute([$partner_id, $notice_id]);
            echo json_encode(['status' => 'success']);
            break;

        case 'mark_booking_seen':
            $booking_id = $_POST['booking_id'] ?? '';
            if (empty($partner_id) || empty($booking_id)) throw new Exception("Missing params");
            
            $stmt = $pdo->prepare("INSERT IGNORE INTO partner_booking_popups_seen (partner_id, booking_id, seen_at) VALUES (?, ?, NOW())");
            $stmt->execute([$partner_id, $booking_id]);
            echo json_encode(['status' => 'success']);
            break;

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
