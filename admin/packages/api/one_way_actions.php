<?php
require_once __DIR__ . '/../../../includes/db.php';
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

$action = $_POST['action'] ?? '';

// Helper to get One Way Trip ID
function getOneWayId($pdo) {
    $stmt = $pdo->prepare("SELECT id FROM trip_types WHERE name LIKE '%One Way%' LIMIT 1");
    $stmt->execute();
    $res = $stmt->fetch();
    return $res ? $res['id'] : null;
}

try {
    $oneWayId = getOneWayId($pdo);
    if (!$oneWayId) throw new Exception("One Way trip type not found in database.");

    switch ($action) {
        case 'save':
            $id = $_POST['id'] ?? null;
            $type_id = $_POST['type_id'];
            $brand_id = $_POST['brand_id'] ?? 1; // Default to 1 if not provided
            $name = $_POST['name'];
            $base_fare = $_POST['base_fare'];
            $min_km = $_POST['min_km'];
            $extra_km_price = $_POST['extra_km_price'];
            $include_toll = $_POST['include_toll'];
            $include_tax = $_POST['include_tax'];
            $include_driver_allowance = $_POST['include_driver_allowance'];
            $include_night_charges = $_POST['include_night_charges'];
            $include_parking = $_POST['include_parking'];
            $description = $_POST['description'] ?? '';
            $status = $_POST['status'] ?? 'Active';

            // Handle Image Upload
            $imageName = $_POST['existing_image'] ?? '';
            if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
                $uploadDir = __DIR__ . '/../../../uploads/cars/';
                if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);
                
                $fileExt = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
                $imageName = 'car_' . time() . '.' . $fileExt;
                move_uploaded_file($_FILES['image']['tmp_name'], $uploadDir . $imageName);
            }

            if ($id) {
                // Update
                $stmt = $pdo->prepare("UPDATE cars SET 
                    type_id = ?, brand_id = ?, name = ?, base_fare = ?, min_km = ?, 
                    extra_km_price = ?, include_toll = ?, include_tax = ?, 
                    include_driver_allowance = ?, include_night_charges = ?, 
                    include_parking = ?, description = ?, image = ?, status = ?
                    WHERE id = ? AND trip_type_id = ?");
                $stmt->execute([
                    $type_id, $brand_id, $name, $base_fare, $min_km, 
                    $extra_km_price, $include_toll, $include_tax, 
                    $include_driver_allowance, $include_night_charges, 
                    $include_parking, $description, $imageName, $status, 
                    $id, $oneWayId
                ]);
                $message = "Package updated successfully!";
            } else {
                // Insert
                $stmt = $pdo->prepare("INSERT INTO cars 
                    (type_id, brand_id, trip_type_id, name, base_fare, min_km, 
                    extra_km_price, include_toll, include_tax, 
                    include_driver_allowance, include_night_charges, 
                    include_parking, description, image, status) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->execute([
                    $type_id, $brand_id, $oneWayId, $name, $base_fare, $min_km, 
                    $extra_km_price, $include_toll, $include_tax, 
                    $include_driver_allowance, $include_night_charges, 
                    $include_parking, $description, $imageName, $status
                ]);
                $message = "Package added successfully!";
            }
            echo json_encode(['success' => true, 'message' => $message]);
            break;

        case 'delete':
            $id = $_POST['id'];
            $stmt = $pdo->prepare("DELETE FROM cars WHERE id = ? AND trip_type_id = ?");
            $stmt->execute([$id, $oneWayId]);
            echo json_encode(['success' => true, 'message' => 'Package deleted successfully!']);
            break;

        case 'toggle_status':
            $id = $_POST['id'];
            $stmt = $pdo->prepare("UPDATE cars SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ? AND trip_type_id = ?");
            $stmt->execute([$id, $oneWayId]);
            echo json_encode(['success' => true, 'message' => 'Status updated successfully!']);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
