<?php
require_once __DIR__ . '/../../../vendor/autoload.php';
require_once __DIR__ . '/../../../includes/db.php';
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

$adminData = checkAdminAuth();
$action = $_POST['action'] ?? $_GET['action'] ?? '';

function generateSEO($name, $tagline) {
    return [
        'title' => "$name - Premium Taxi Services | Choose A Taxi",
        'description' => "Experience the best travel with $name. $tagline. Book your ride now for a comfort and safe journey with Choose A Taxi.",
        'keywords' => "$name, taxi service, car rental, $name cab, book taxi online",
        'schema' => json_encode([
            "@context" => "https://schema.org",
            "@type" => "Brand",
            "name" => $name,
            "description" => $tagline,
            "url" => "https://chooseataxi.com/brands/" . strtolower(str_replace(' ', '-', $name))
        ], JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)
    ];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' || $_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        switch ($action) {
            case 'add':
                $name = $_POST['name'] ?? '';
                $tagline = $_POST['tagline'] ?? '';
                $description = $_POST['description'] ?? '';
                
                if (empty($name)) throw new Exception("Brand name is required.");

                // SEO Generation
                $seo = generateSEO($name, $tagline);
                $seo_title = $_POST['seo_title'] ?: $seo['title'];
                $meta_description = $_POST['meta_description'] ?: $seo['description'];
                $meta_keywords = $_POST['meta_keywords'] ?: $seo['keywords'];
                $seo_schema = $_POST['seo_schema'] ?: $seo['schema'];

                // Logo Upload
                $logoPath = null;
                if (isset($_FILES['logo']) && $_FILES['logo']['error'] === UPLOAD_ERR_OK) {
                    $ext = pathinfo($_FILES['logo']['name'], PATHINFO_EXTENSION);
                    $fileName = 'brand_' . time() . '.' . $ext;
                    $uploadDir = __DIR__ . '/../../assets/car_brands/';
                    if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);
                    if (move_uploaded_file($_FILES['logo']['tmp_name'], $uploadDir . $fileName)) {
                        $logoPath = './assets/car_brands/' . $fileName;
                    }
                }

                $stmt = $pdo->prepare("INSERT INTO car_brands (name, tagline, description, logo, seo_title, meta_description, meta_keywords, seo_schema) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->execute([$name, $tagline, $description, $logoPath, $seo_title, $meta_description, $meta_keywords, $seo_schema]);
                
                echo json_encode(['success' => true, 'message' => 'Car brand added successfully!']);
                break;

            case 'update':
                $id = $_POST['id'] ?? '';
                $name = $_POST['name'] ?? '';
                $tagline = $_POST['tagline'] ?? '';
                $description = $_POST['description'] ?? '';
                
                if (empty($id) || empty($name)) throw new Exception("ID and name are required.");

                $seo_title = $_POST['seo_title'] ?? '';
                $meta_description = $_POST['meta_description'] ?? '';
                $meta_keywords = $_POST['meta_keywords'] ?? '';
                $seo_schema = $_POST['seo_schema'] ?? '';

                // Logo Update
                $logoUpdateSql = "";
                $params = [$name, $tagline, $description, $seo_title, $meta_description, $meta_keywords, $seo_schema];
                
                if (isset($_FILES['logo']) && $_FILES['logo']['error'] === UPLOAD_ERR_OK) {
                    $ext = pathinfo($_FILES['logo']['name'], PATHINFO_EXTENSION);
                    $fileName = 'brand_' . time() . '.' . $ext;
                    $uploadDir = __DIR__ . '/../../assets/car_brands/';
                    if (move_uploaded_file($_FILES['logo']['tmp_name'], $uploadDir . $fileName)) {
                        $logoPath = './assets/car_brands/' . $fileName;
                        $logoUpdateSql = ", logo = ?";
                        $params[] = $logoPath;
                    }
                }
                
                $params[] = $id;
                $stmt = $pdo->prepare("UPDATE car_brands SET name = ?, tagline = ?, description = ?, seo_title = ?, meta_description = ?, meta_keywords = ?, seo_schema = ? $logoUpdateSql WHERE id = ?");
                $stmt->execute($params);
                
                echo json_encode(['success' => true, 'message' => 'Car brand updated successfully!']);
                break;

            case 'delete':
                $id = $_POST['id'] ?? $_GET['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("DELETE FROM car_brands WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Car brand deleted successfully!']);
                break;

            case 'toggle_status':
                $id = $_POST['id'] ?? '';
                if (empty($id)) throw new Exception("ID is required.");

                $stmt = $pdo->prepare("UPDATE car_brands SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Status updated!']);
                break;

            case 'generate_seo':
                $name = $_GET['name'] ?? '';
                $tagline = $_GET['tagline'] ?? '';
                echo json_encode(['success' => true, 'data' => generateSEO($name, $tagline)]);
                break;

            default:
                throw new Exception("Invalid action.");
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
}
