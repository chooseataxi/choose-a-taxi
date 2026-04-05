<?php
require_once __DIR__ . '/../../auth_check.php';
header('Content-Type: application/json');

$action = $_GET['action'] ?? '';

try {
    switch ($action) {
        case 'add':
            $name = $_POST['name'] ?? '';
            $price = $_POST['price'] ?? 0;
            $duration_value = $_POST['duration_value'] ?? 0;
            $duration_unit = $_POST['duration_unit'] ?? 'months';
            $terms = $_POST['terms'] ?? '';
            $status = $_POST['status'] ?? 'active';

            if (empty($name)) throw new Exception("Plan name is required");

            $stmt = $pdo->prepare("INSERT INTO partner_subscription_plans (name, price, duration_value, duration_unit, terms, status) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$name, $price, $duration_value, $duration_unit, $terms, $status]);

            echo json_encode(['success' => true, 'message' => 'Plan added successfully!']);
            break;

        case 'edit':
            $id = $_POST['id'] ?? 0;
            $name = $_POST['name'] ?? '';
            $price = $_POST['price'] ?? 0;
            $duration_value = $_POST['duration_value'] ?? 0;
            $duration_unit = $_POST['duration_unit'] ?? 'months';
            $terms = $_POST['terms'] ?? '';
            $status = $_POST['status'] ?? 'active';

            if (empty($id) || empty($name)) throw new Exception("ID and Plan name are required");

            $stmt = $pdo->prepare("UPDATE partner_subscription_plans SET name = ?, price = ?, duration_value = ?, duration_unit = ?, terms = ?, status = ? WHERE id = ?");
            $stmt->execute([$name, $price, $duration_value, $duration_unit, $terms, $status, $id]);

            echo json_encode(['success' => true, 'message' => 'Plan updated successfully!']);
            break;

        case 'delete':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("ID is required");

            $stmt = $pdo->prepare("DELETE FROM partner_subscription_plans WHERE id = ?");
            $stmt->execute([$id]);

            echo json_encode(['success' => true, 'message' => 'Plan deleted successfully!']);
            break;

        case 'toggle_status':
            $id = $_POST['id'] ?? 0;
            $status = $_POST['status'] ?? 'active';
            if (empty($id)) throw new Exception("ID is required");

            $stmt = $pdo->prepare("UPDATE partner_subscription_plans SET status = ? WHERE id = ?");
            $stmt->execute([$status, $id]);

            echo json_encode(['success' => true, 'message' => 'Status updated successfully!']);
            break;

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
