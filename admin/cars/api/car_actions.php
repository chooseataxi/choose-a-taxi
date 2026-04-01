<?php
require_once __DIR__ . '/../../../includes/db.php';
session_start();

header('Content-Type: application/json');

$action = $_POST['action'] ?? $_GET['action'] ?? '';

try {
    switch ($action) {
        case 'add':
            $brand_id = $_POST['brand_id'] ?? 0;
            $type_id = $_POST['type_id'] ?? 0;
            $trip_type_id = $_POST['trip_type_id'] ?? 0;
            $name = $_POST['name'] ?? '';
            $model = $_POST['model'] ?? '';
            $base_fare = $_POST['base_fare'] ?? 0;
            $min_km = $_POST['min_km'] ?? 0;
            $extra_km_price = $_POST['extra_km_price'] ?? 0;
            $description = $_POST['description'] ?? '';
            $youtube_url = $_POST['youtube_url'] ?? '';
            $seo_title = $_POST['seo_title'] ?? '';
            $seo_description = $_POST['seo_description'] ?? '';
            $meta_keywords = $_POST['meta_keywords'] ?? '';
            
            // Image Upload
            $image = '';
            if (isset($_FILES['car_image']) && $_FILES['car_image']['error'] == 0) {
                $targetDir = "../../../uploads/cars/";
                if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);
                
                $fileExtension = pathinfo($_FILES['car_image']['name'], PATHINFO_EXTENSION);
                $fileName = time() . '_' . uniqid() . '.' . $fileExtension;
                $targetFile = $targetDir . $fileName;
                
                if (move_uploaded_file($_FILES['car_image']['tmp_name'], $targetFile)) {
                    $image = $fileName;
                }
            }

            $stmt = $pdo->prepare("INSERT INTO cars (brand_id, type_id, trip_type_id, name, model, base_fare, min_km, extra_km_price, description, youtube_url, image, seo_title, seo_description, meta_keywords) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$brand_id, $type_id, $trip_type_id, $name, $model, $base_fare, $min_km, $extra_km_price, $description, $youtube_url, $image, $seo_title, $seo_description, $meta_keywords]);

            echo json_encode(['success' => true, 'message' => 'Car added successfully!']);
            break;

        case 'delete':
            $id = $_POST['id'] ?? 0;
            
            // Delete image if exists
            $stmt = $pdo->prepare("SELECT image FROM cars WHERE id = ?");
            $stmt->execute([$id]);
            $car = $stmt->fetch();
            if ($car && !empty($car['image'])) {
                $filePath = "../../../uploads/cars/" . $car['image'];
                if (file_exists($filePath)) unlink($filePath);
            }

            $stmt = $pdo->prepare("DELETE FROM cars WHERE id = ?");
            $stmt->execute([$id]);
            echo json_encode(['success' => true, 'message' => 'Car deleted successfully!']);
            break;

        case 'get_dropdown_data':
            $brands = $pdo->query("SELECT id, name FROM car_brands WHERE status = 'Active' ORDER BY name")->fetchAll();
            $types = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active' ORDER BY name")->fetchAll();
            $trip_types = $pdo->query("SELECT id, name FROM trip_types WHERE status = 'Active' ORDER BY name")->fetchAll();
            
            echo json_encode([
                'success' => true, 
                'brands' => $brands, 
                'types' => $types, 
                'trip_types' => $trip_types
            ]);
            break;

        case 'generate_seo':
            $name = $_GET['name'] ?? '';
            $model = $_GET['model'] ?? '';
            $brand_name = $_GET['brand_name'] ?? '';
            
            $title = "$brand_name $name $model - Book Now | Choose A Taxi";
            $description = "Looking for a reliable $brand_name $name $model? Choose A Taxi offers professional car rental services with base fares starting at competitive prices. Book your $name $model today!";
            $keywords = "book $name, $brand_name $name rental, taxi service, $name model taxi, professional car hire";
            
            echo json_encode([
                'success' => true,
                'data' => [
                    'title' => $title,
                    'description' => $description,
                    'keywords' => $keywords
                ]
            ]);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
