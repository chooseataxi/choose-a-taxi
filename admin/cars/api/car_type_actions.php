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
                $passengers = $_POST['passengers'] ?? 4;
                $luggage = $_POST['luggage'] ?? 2;
                $base_price = $_POST['base_price'] ?? 0.00;
                
                if (empty($name)) throw new Exception("Car type name is required.");

                // Image Upload
                $imagePath = null;
                if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
                    $ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
                    $fileName = 'car_type_' . time() . '.' . $ext;
                    $uploadDir = __DIR__ . '/../../assets/car_types/';
                    if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);
                    if (move_uploaded_file($_FILES['image']['tmp_name'], $uploadDir . $fileName)) {
                        $imagePath = './assets/car_types/' . $fileName;
                    }
                }

                $stmt = $pdo->prepare("INSERT INTO car_types (name, passengers, luggage, base_price, image) VALUES (?, ?, ?, ?, ?)");
                $stmt->execute([$name, $passengers, $luggage, $base_price, $imagePath]);
                
                echo json_encode(['success' => true, 'message' => 'Car type added successfully!']);
                break;

            case 'update':
                $id = $_POST['id'] ?? '';
                $name = $_POST['name'] ?? '';
                $passengers = $_POST['passengers'] ?? 4;
                $luggage = $_POST['luggage'] ?? 2;
                $base_price = $_POST['base_price'] ?? 0.00;
                
                if (empty($id) || empty($name)) throw new Exception("ID and name are required.");

                // Image Update
                $imageUpdateSql = "";
                $params = [$name, $passengers, $luggage, $base_price];
                
                if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
                    $ext = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
                    $fileName = 'car_type_' . time() . '.' . $ext;
                    $uploadDir = __DIR__ . '/../../assets/car_types/';
                    if (move_uploaded_file($_FILES['image']['tmp_name'], $uploadDir . $fileName)) {
                        $imagePath = './assets/car_types/' . $fileName;
                        $imageUpdateSql = ", image = ?";
                        $params[] = $imagePath;
                    }
                }
                
                $params[] = $id;
                $stmt = $pdo->prepare("UPDATE car_types SET name = ?, passengers = ?, luggage = ?, base_price = ? $imageUpdateSql WHERE id = ?");
                $stmt->execute($params);
                
                echo json_encode(['success' => true, 'message' => 'Car type updated successfully!']);
                break;

            case 'delete':
                $id = $_POST['id'] ?? $_GET['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("DELETE FROM car_types WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Car type deleted successfully!']);
                break;

            case 'toggle_status':
                $id = $_POST['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("UPDATE car_types SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Status updated!']);
                break;

            default:
                throw new Exception("Invalid action.");
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
}
