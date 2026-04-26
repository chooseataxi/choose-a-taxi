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
