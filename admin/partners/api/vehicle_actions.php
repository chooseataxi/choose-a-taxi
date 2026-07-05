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
        case 'add':
            $partner_id = intval($_POST['partner_id'] ?? 0);
            $rc_number = trim($_POST['rc_number'] ?? '');
            $maker_model = trim($_POST['maker_model'] ?? '');
            $color = trim($_POST['color'] ?? '');
            $status = trim($_POST['status'] ?? 'Active');

            if (empty($partner_id) || empty($rc_number) || empty($maker_model)) {
                throw new Exception("Partner ID, RC Number and Model are required.");
            }

            // Check duplicate RC number for this partner
            $check = $pdo->prepare("SELECT id FROM partner_vehicles WHERE rc_number = ? AND partner_id = ?");
            $check->execute([$rc_number, $partner_id]);
            if ($check->fetch()) {
                throw new Exception("A vehicle with this RC number already exists for this partner.");
            }

            $stmt = $pdo->prepare("INSERT INTO partner_vehicles (partner_id, rc_number, maker_model, color, status) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$partner_id, $rc_number, $maker_model, $color, $status]);

            echo json_encode(['success' => true, 'message' => 'Vehicle added successfully!']);
            break;

        case 'delete':
            $id = intval($_POST['id'] ?? 0);
            if (empty($id)) throw new Exception("Vehicle ID missing.");

            // Fetch vehicle images before deleting
            $stmt = $pdo->prepare("SELECT front_image, back_image FROM partner_vehicles WHERE id = ?");
            $stmt->execute([$id]);
            $vehicle = $stmt->fetch();

            if ($vehicle) {
                // Delete front image
                if (!empty($vehicle['front_image'])) {
                    $frontPath = __DIR__ . '/../../../uploads/vehicles/' . basename($vehicle['front_image']);
                    if (file_exists($frontPath)) {
                        @unlink($frontPath);
                    }
                }
                // Delete back image
                if (!empty($vehicle['back_image'])) {
                    $backPath = __DIR__ . '/../../../uploads/vehicles/' . basename($vehicle['back_image']);
                    if (file_exists($backPath)) {
                        @unlink($backPath);
                    }
                }
            }

            $stmt = $pdo->prepare("DELETE FROM partner_vehicles WHERE id = ?");
            $stmt->execute([$id]);

            echo json_encode(['success' => true, 'message' => 'Vehicle removed successfully!']);
            break;

        default:
            throw new Exception("Invalid action.");
    }

} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
