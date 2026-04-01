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
            
            // Debugging
            file_put_contents(__DIR__ . '/upload_debug.log', "POST: " . print_r($_POST, true) . "\nFILES: " . print_r($_FILES, true) . "\n", FILE_APPEND);

            if (isset($_FILES['car_image']) && $_FILES['car_image']['error'] == UPLOAD_ERR_OK) {
                // Determine absolute path from the root directory
                $targetDir = realpath(__DIR__ . '/../../../') . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'cars' . DIRECTORY_SEPARATOR;
                if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);
                
                $fileExtension = strtolower(pathinfo($_FILES['car_image']['name'], PATHINFO_EXTENSION));
                $fileName = time() . '_' . uniqid() . '.' . $fileExtension;
                $targetFile = $targetDir . $fileName;
                
                if (move_uploaded_file($_FILES['car_image']['tmp_name'], $targetFile)) {
                    $image = $fileName;
                } else {
                    file_put_contents(__DIR__ . '/upload_debug.log', "Upload failed. TMP: " . $_FILES['car_image']['tmp_name'] . " Target: " . $targetFile . "\n", FILE_APPEND);
                    throw new Exception("Unable to physically move the uploaded file. Check directory permissions at: " . $targetDir);
                }
            } else if (isset($_FILES['car_image']) && $_FILES['car_image']['error'] != UPLOAD_ERR_NO_FILE) {
                 throw new Exception("File upload failed with error code: " . $_FILES['car_image']['error'] . ". Check php.ini upload_max_filesize limit.");
            }

            $stmt = $pdo->prepare("INSERT INTO cars (brand_id, type_id, trip_type_id, name, model, base_fare, min_km, extra_km_price, description, youtube_url, image, seo_title, seo_description, meta_keywords) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$brand_id, $type_id, $trip_type_id, $name, $model, $base_fare, $min_km, $extra_km_price, $description, $youtube_url, $image, $seo_title, $seo_description, $meta_keywords]);

            echo json_encode(['success' => true, 'message' => 'Car added successfully!']);
            break;

        case 'update':
            $id = $_POST['id'] ?? 0;
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
            
            // Handle image update correctly
            $imageColumn = "";
            $imageParams = [];
            
            // Debugging
            file_put_contents(__DIR__ . '/upload_debug.log', "UPDATE POST: " . print_r($_POST, true) . "\nFILES: " . print_r($_FILES, true) . "\n", FILE_APPEND);

            if (isset($_FILES['car_image']) && $_FILES['car_image']['error'] == UPLOAD_ERR_OK) {
                $targetDir = realpath(__DIR__ . '/../../../') . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'cars' . DIRECTORY_SEPARATOR;
                if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);

                // Delete old image if it exists
                $stmt_old = $pdo->prepare("SELECT image FROM cars WHERE id = ?");
                $stmt_old->execute([$id]);
                $old_car = $stmt_old->fetch();
                if ($old_car && !empty($old_car['image'])) {
                     $oldFile = $targetDir . $old_car['image'];
                     if (file_exists($oldFile)) unlink($oldFile);
                }

                $fileExtension = strtolower(pathinfo($_FILES['car_image']['name'], PATHINFO_EXTENSION));
                $fileName = time() . '_' . uniqid() . '.' . $fileExtension;
                $targetFile = $targetDir . $fileName;
                
                if (move_uploaded_file($_FILES['car_image']['tmp_name'], $targetFile)) {
                    $imageColumn = ", image = ?";
                    $imageParams[] = $fileName;
                } else {
                    throw new Exception("Unable to physically move the uploaded file. Check directory permissions at: " . $targetDir);
                }
            } else if (isset($_FILES['car_image']) && $_FILES['car_image']['error'] != UPLOAD_ERR_NO_FILE) {
                 throw new Exception("Image replacement failed with error code: " . $_FILES['car_image']['error'] . ". Check php.ini upload_max_filesize limit.");
            }

            $sql = "UPDATE cars SET brand_id = ?, type_id = ?, trip_type_id = ?, name = ?, model = ?, base_fare = ?, min_km = ?, extra_km_price = ?, description = ?, youtube_url = ?, seo_title = ?, seo_description = ?, meta_keywords = ? $imageColumn WHERE id = ?";
            $params = array_merge([$brand_id, $type_id, $trip_type_id, $name, $model, $base_fare, $min_km, $extra_km_price, $description, $youtube_url, $seo_title, $seo_description, $meta_keywords], $imageParams, [$id]);
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);

            echo json_encode(['success' => true, 'message' => 'Car updated successfully!']);
            break;

        case 'delete':
            $id = $_POST['id'] ?? 0;
            
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

        case 'get':
            $id = $_GET['id'] ?? 0;
            $stmt = $pdo->prepare("SELECT * FROM cars WHERE id = ?");
            $stmt->execute([$id]);
            $car = $stmt->fetch();
            if ($car) {
                 echo json_encode(['success' => true, 'data' => $car]);
            } else {
                 echo json_encode(['success' => false, 'message' => 'Car not found.']);
            }
            break;

        case 'toggle_status':
            $id = $_POST['id'] ?? 0;
            $stmt = $pdo->prepare("UPDATE cars SET status = IF(status = 'Active', 'Inactive', 'Active') WHERE id = ?");
            $stmt->execute([$id]);
            
            $stmt_new = $pdo->prepare("SELECT status FROM cars WHERE id = ?");
            $stmt_new->execute([$id]);
            $newStatus = $stmt_new->fetchColumn();
            
            echo json_encode(['success' => true, 'new_status' => $newStatus]);
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
            throw new Exception("Invalid action: $action");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
