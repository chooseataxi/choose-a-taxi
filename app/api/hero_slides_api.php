<?php
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$action = $_REQUEST['action'] ?? 'get_slides';

try {
    switch ($action) {
        case 'get_slides':
            $stmt = $pdo->query("SELECT id, image_path, title, link_url FROM hero_slides WHERE status = 'Active' ORDER BY id DESC");
            $slides = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            // Format image paths to absolute URLs if needed
            foreach ($slides as &$slide) {
                if (!empty($slide['image_path'])) {
                    $slide['image_url'] = "https://chooseataxi.com/" . $slide['image_path'];
                }
            }
            
            echo json_encode(["status" => "success", "slides" => $slides]);
            break;

        default:
            echo json_encode(["status" => "error", "message" => "Invalid action"]);
            break;
    }
} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
