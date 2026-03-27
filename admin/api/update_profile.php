<?php
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../auth_check.php';

header('Content-Type: application/json');

$adminData = checkAdminAuth();
$adminId = $adminData['sub'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Handle Profile Picture Upload
        if (isset($_FILES['profile_picture'])) {
            $file = $_FILES['profile_picture'];
            $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
            $fileName = 'admin_' . $adminId . '_' . time() . '.' . $ext;
            $uploadDir = __DIR__ . '/../assets/profile_pics/';
            
            if (!is_dir($uploadDir)) {
                mkdir($uploadDir, 0777, true);
            }

            $targetFile = $uploadDir . $fileName;
            $dbPath = './assets/profile_pics/' . $fileName;

            if (move_uploaded_file($file['tmp_name'], $targetFile)) {
                $stmt = $pdo->prepare("UPDATE admins SET profile_picture = ? WHERE id = ?");
                $stmt->execute([$dbPath, $adminId]);
                echo json_encode(['success' => true, 'message' => 'Profile picture updated!', 'path' => $dbPath]);
                exit;
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to upload photo.']);
                exit;
            }
        }

        // Handle Basic Info Update
        $name = $_POST['name'] ?? null;
        $email = $_POST['email'] ?? null;
        $mobile = $_POST['mobile'] ?? null;

        if ($name && $email && $mobile) {
            $stmt = $pdo->prepare("UPDATE admins SET name = ?, email = ?, mobile = ? WHERE id = ?");
            if ($stmt->execute([$name, $email, $mobile, $adminId])) {
                echo json_encode(['success' => true, 'message' => 'Profile updated successfully!']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Database error.']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'All fields are required.']);
        }

    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
