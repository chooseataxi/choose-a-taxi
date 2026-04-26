<?php
require_once __DIR__ . '/../../../auth_check.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$action = $_POST['action'] ?? '';

try {
    switch ($action) {
        case 'add':
            $title = $_POST['title'] ?? '';
            $link = $_POST['link_url'] ?? '';
            
            if (!isset($_FILES['image']) || $_FILES['image']['error'] !== UPLOAD_ERR_OK) {
                throw new Exception("Please upload a valid image.");
            }

            $uploadDir = __DIR__ . '/../../../uploads/hero/';
            if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);

            $fileExt = pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION);
            $fileName = 'hero_' . time() . '_' . rand(1000, 9999) . '.' . $fileExt;
            $targetPath = $uploadDir . $fileName;

            if (move_uploaded_file($_FILES['image']['tmp_name'], $targetPath)) {
                $dbPath = 'uploads/hero/' . $fileName;
                $stmt = $pdo->prepare("INSERT INTO hero_slides (image_path, title, link_url) VALUES (?, ?, ?)");
                $stmt->execute([$dbPath, $title, $link]);
                echo json_encode(['success' => true, 'message' => 'Hero slide added successfully!']);
            } else {
                throw new Exception("Failed to move uploaded file.");
            }
            break;

        case 'delete':
            $id = $_POST['id'] ?? 0;
            if (!$id) throw new Exception("ID is required.");

            // Get path to delete file
            $stmt = $pdo->prepare("SELECT image_path FROM hero_slides WHERE id = ?");
            $stmt->execute([$id]);
            $slide = $stmt->fetch();

            if ($slide) {
                $fullPath = __DIR__ . '/../../../' . $slide['image_path'];
                if (file_exists($fullPath)) unlink($fullPath);

                $stmt = $pdo->prepare("DELETE FROM hero_slides WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(['success' => true, 'message' => 'Hero slide deleted successfully!']);
            } else {
                throw new Exception("Slide not found.");
            }
            break;

        case 'toggle_status':
            $id = $_POST['id'] ?? 0;
            if (!$id) throw new Exception("ID is required.");

            $stmt = $pdo->prepare("SELECT status FROM hero_slides WHERE id = ?");
            $stmt->execute([$id]);
            $slide = $stmt->fetch();

            if ($slide) {
                $newStatus = ($slide['status'] === 'Active') ? 'Inactive' : 'Active';
                $stmt = $pdo->prepare("UPDATE hero_slides SET status = ? WHERE id = ?");
                $stmt->execute([$newStatus, $id]);
                echo json_encode(['success' => true, 'message' => "Status updated to $newStatus"]);
            } else {
                throw new Exception("Slide not found.");
            }
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
