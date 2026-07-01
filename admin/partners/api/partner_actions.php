<?php
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$action = $_POST['action'] ?? '';

try {
    switch ($action) {
        case 'add':
            $name = trim($_POST['full_name'] ?? '');
            $mobile = trim($_POST['mobile'] ?? '');
            $email = trim($_POST['email'] ?? '');
            $status = $_POST['status'] ?? 'Active';
            
            if (empty($name) || empty($mobile)) {
                throw new Exception("Full Name and Mobile number are required.");
            }

            // Check duplicate
            $check = $pdo->prepare("SELECT id FROM partners WHERE mobile = ?");
            $check->execute([$mobile]);
            if ($check->fetch()) {
                throw new Exception("A partner with this mobile number already exists.");
            }

            $stmt = $pdo->prepare("INSERT INTO partners (full_name, mobile, email, status, roles, manual_verification_status, mobile_verified) VALUES (?, ?, ?, ?, 'partner', 'Pending', 1)");
            $stmt->execute([$name, $mobile, $email, $status]);
            
            echo json_encode(['success' => true, 'message' => 'Partner added successfully!']);
            break;

        case 'update':
            $id = $_POST['id'] ?? 0;
            $name = trim($_POST['full_name'] ?? '');
            $mobile = trim($_POST['mobile'] ?? '');
            $email = trim($_POST['email'] ?? '');
            $status = $_POST['status'] ?? 'Active';
            $verification_status = $_POST['manual_verification_status'] ?? 'Pending';
            
            if (empty($id) || empty($name) || empty($mobile)) {
                throw new Exception("Core partner details are required.");
            }
            
            // Check duplicate
            $check = $pdo->prepare("SELECT id FROM partners WHERE mobile = ? AND id != ?");
            $check->execute([$mobile, $id]);
            if ($check->fetch()) {
                throw new Exception("Another partner already uses this mobile number.");
            }

            // Handle profile image upload
            $selfieLink = null;
            $updateSelfie = false;

            if (isset($_FILES['profile_image']) && $_FILES['profile_image']['error'] === UPLOAD_ERR_OK) {
                $file = $_FILES['profile_image'];

                // Validate file type
                $allowedTypes = ['image/jpeg', 'image/png', 'image/webp'];
                if (!in_array($file['type'], $allowedTypes, true)) {
                    throw new Exception('Invalid image format. Only JPG, PNG & WebP are allowed.');
                }

                // Validate file size (2MB max)
                if ($file['size'] > 2 * 1024 * 1024) {
                    throw new Exception('Image is too large. Maximum size is 2MB.');
                }

                // Define upload directory
                $uploadDir = __DIR__ . '/../../../uploads/partners/';
                if (!is_dir($uploadDir)) {
                    mkdir($uploadDir, 0755, true);
                }

                // Generate unique filename
                $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
                $safeExt = in_array(strtolower($ext), ['jpg', 'jpeg', 'png', 'webp'], true) ? strtolower($ext) : 'jpg';
                $newFilename = 'partner_' . $id . '_' . time() . '.' . $safeExt;
                $destPath = $uploadDir . $newFilename;

                // Move uploaded file
                if (!move_uploaded_file($file['tmp_name'], $destPath)) {
                    throw new Exception('Failed to save uploaded image. Please check directory permissions.');
                }

                // Delete old selfie file if exists
                $stmtOld = $pdo->prepare("SELECT selfie_link FROM partners WHERE id = ?");
                $stmtOld->execute([$id]);
                $oldRow = $stmtOld->fetch();
                if (!empty($oldRow['selfie_link'])) {
                    $oldFilePath = $uploadDir . $oldRow['selfie_link'];
                    if (file_exists($oldFilePath)) {
                        @unlink($oldFilePath);
                    }
                }

                $selfieLink = $newFilename;
                $updateSelfie = true;
            }

            // Build update query dynamically
            if ($updateSelfie) {
                $stmt = $pdo->prepare("UPDATE partners SET full_name = ?, mobile = ?, email = ?, status = ?, manual_verification_status = ?, selfie_link = ? WHERE id = ?");
                $stmt->execute([$name, $mobile, $email, $status, $verification_status, $selfieLink, $id]);
            } else {
                $stmt = $pdo->prepare("UPDATE partners SET full_name = ?, mobile = ?, email = ?, status = ?, manual_verification_status = ? WHERE id = ?");
                $stmt->execute([$name, $mobile, $email, $status, $verification_status, $id]);
            }

            echo json_encode(['success' => true, 'message' => 'Partner updated successfully!']);
            break;

        case 'delete':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("Partner ID missing.");
            
            $stmt = $pdo->prepare("DELETE FROM partners WHERE id = ?");
            $stmt->execute([$id]);
            
            echo json_encode(['success' => true, 'message' => 'Partner deleted successfully!']);
            break;

        case 'toggle_status':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("Partner ID missing.");
            
            $stmt = $pdo->prepare("SELECT status FROM partners WHERE id = ?");
            $stmt->execute([$id]);
            $partner = $stmt->fetch();
            
            if (!$partner) throw new Exception("Partner not found.");
            
            $newStatus = ($partner['status'] === 'Active') ? 'Inactive' : 'Active';
            $update = $pdo->prepare("UPDATE partners SET status = ? WHERE id = ?");
            $update->execute([$newStatus, $id]);
            
            echo json_encode(['success' => true, 'new_status' => $newStatus, 'message' => "Status updated to $newStatus"]);
            break;
            
        case 'toggle_verification':
            $id = $_POST['id'] ?? 0;
            $verify_status = trim($_POST['status'] ?? '');
            if (empty($id) || empty($verify_status)) throw new Exception("Required data missing.");
            
            // Validate Enum string
            $allowed = ['Pending', 'Approved', 'Rejected'];
            if (!in_array($verify_status, $allowed)) {
               throw new Exception("Invalid verification status selected.");
            }

            $update = $pdo->prepare("UPDATE partners SET manual_verification_status = ? WHERE id = ?");
            $update->execute([$verify_status, $id]);
            
            echo json_encode(['success' => true, 'message' => "Verification updated to $verify_status!"]);
            break;

        case 'approve':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("Partner ID missing.");
            $stmt = $pdo->prepare("UPDATE partners SET manual_verification_status = 'Approved', status = 'Active' WHERE id = ?");
            $stmt->execute([$id]);
            echo json_encode(['success' => true, 'message' => 'Partner approved and activated!']);
            break;

        case 'reject':
            $id = $_POST['id'] ?? 0;
            if (empty($id)) throw new Exception("Partner ID missing.");
            $stmt = $pdo->prepare("UPDATE partners SET manual_verification_status = 'Rejected' WHERE id = ?");
            $stmt->execute([$id]);
            echo json_encode(['success' => true, 'message' => 'Partner verification rejected.']);
            break;

        default:
            throw new Exception("Invalid action.");
    }

} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
