<?php
require_once __DIR__ . '/../../../vendor/autoload.php';
require_once __DIR__ . '/../../../includes/db.php';
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

$adminData = checkAdminAuth();
$action = $_POST['action'] ?? $_GET['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' || $_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        switch ($action) {
            case 'add':
                $name = $_POST['name'] ?? '';
                $description = $_POST['description'] ?? '';
                if (empty($name)) throw new Exception("Name is required.");

                $stmt = $pdo->prepare("INSERT INTO trip_types (name, description) VALUES (?, ?)");
                $stmt->execute([$name, $description]);
                echo json_encode(['success' => true, 'message' => 'Trip type added successfully!']);
                break;

            case 'update':
                $id = $_POST['id'] ?? '';
                $name = $_POST['name'] ?? '';
                $description = $_POST['description'] ?? '';
                if (empty($id) || empty($name)) throw new Exception("ID and Name are required.");

                $stmt = $pdo->prepare("UPDATE trip_types SET name = ?, description = ? WHERE id = ?");
                $stmt->execute([$name, $description, $id]);
                echo json_encode(['success' => true, 'message' => 'Trip type updated successfully!']);
                break;

            case 'delete':
                $id = $_POST['id'] ?? $_GET['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("DELETE FROM trip_types WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Trip type deleted successfully!']);
                break;

            case 'toggle_status':
                $id = $_POST['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("UPDATE trip_types SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Status updated!']);
                break;

            case 'fetch_single':
                $id = $_GET['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("SELECT * FROM trip_types WHERE id = ?");
                $stmt->execute([$id]);
                $type = $stmt->fetch();
                echo json_encode(['success' => true, 'data' => $type]);
                break;

            default:
                throw new Exception("Invalid action.");
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
}
