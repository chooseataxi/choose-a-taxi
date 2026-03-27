<?php
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../auth_check.php';

header('Content-Type: application/json');

$adminData = checkAdminAuth();
$adminId = $adminData['sub'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current_password = $_POST['current_password'] ?? '';
    $new_password = $_POST['new_password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';

    if (empty($current_password) || empty($new_password) || empty($confirm_password)) {
        echo json_encode(['success' => false, 'message' => 'All fields are required.']);
        exit;
    }

    if ($new_password !== $confirm_password) {
        echo json_encode(['success' => false, 'message' => 'New passwords do not match.']);
        exit;
    }

    if (strlen($new_password) < 6) {
        echo json_encode(['success' => false, 'message' => 'New password must be at least 6 characters.']);
        exit;
    }

    try {
        // Fetch current password hash
        $stmt = $pdo->prepare("SELECT password FROM admins WHERE id = ?");
        $stmt->execute([$adminId]);
        $user = $stmt->fetch();

        if ($user && password_verify($current_password, $user['password'])) {
            // Hash and update new password
            $hashedPassword = password_hash($new_password, PASSWORD_BCRYPT);
            $updateStmt = $pdo->prepare("UPDATE admins SET password = ? WHERE id = ?");
            if ($updateStmt->execute([$hashedPassword, $adminId])) {
                echo json_encode(['success' => true, 'message' => 'Password updated successfully!']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Failed to update password in database.']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Incorrect current password.']);
        }
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
