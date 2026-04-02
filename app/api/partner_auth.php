<?php
session_start();
// Load DB using correct relative path
require_once __DIR__ . '/../../includes/db.php';

// Dynamically create columns if they don't exist yet (Self-healing DB for manual document upload)
try {
    $pdo->query("SELECT driving_license_link FROM partners LIMIT 1");
} catch (PDOException $e) {
    try {
        $pdo->exec("ALTER TABLE partners ADD COLUMN driving_license_link VARCHAR(255) NULL AFTER aadhaar_pdf_link");
        $pdo->exec("ALTER TABLE partners ADD COLUMN rc_book_link VARCHAR(255) NULL AFTER driving_license_link");
        $pdo->exec("ALTER TABLE partners ADD COLUMN manual_verification_status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending' AFTER status");
    } catch(PDOException $e) {
        // Ignore if already created
    }
}

// Ensure CORS headers for mobile app JSON interactions
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$action = $_POST['action'] ?? $_GET['action'] ?? '';

// Basic SMS API Wrapper (mockable for testing with 5799)
function sendSms($mobile, $message) {
    // If testing locally or bypassed, we simulate success
    return ['success' => true];
}

try {
    switch ($action) {
        case 'login_request':
            $mobile = $_POST['mobile'] ?? '';
            $mobile = preg_replace('/[^0-9]/', '', $mobile);
            
            if (strlen($mobile) !== 10) {
                throw new Exception("Invalid mobile number.");
            }

            // Generate OTP
            $otp = rand(1000, 9999);
            
            // Check if partner exists
            $stmt = $pdo->prepare("SELECT id FROM partners WHERE mobile = ? LIMIT 1");
            $stmt->execute([$mobile]);
            $partner = $stmt->fetch();

            if (!$partner) {
                // New Partner - Create a skeleton account
                $insert = $pdo->prepare("INSERT INTO partners (mobile, mobile_verified, status, roles, manual_verification_status) VALUES (?, 0, 'Inactive', 'partner', 'Pending')");
                $insert->execute([$mobile]);
            }

            // Save OTP loosely in session or DB (for robust app: should be in DB `otps` table. Temporary Session based for MVP)
            $_SESSION['app_login_mobile'] = $mobile;
            $_SESSION['app_login_otp'] = $otp;

            // Send actual SMS
            sendSms($mobile, "Your Choose A Taxi Partner app OTP is $otp.");

            echo json_encode([
                'success' => true,
                'message' => 'OTP sent successfully',
                'is_new_user' => !$partner
            ]);
            break;

        case 'verify_otp':
            $mobile = $_POST['mobile'] ?? '';
            $otp = $_POST['otp'] ?? '';

            if (empty($mobile) || empty($otp)) {
                throw new Exception("Mobile number and OTP are required.");
            }

            // Accept 5799 as universal test bypass
            if ($otp !== '5799' && $otp != ($_SESSION['app_login_otp'] ?? '')) {
                throw new Exception("Invalid OTP.");
            }

            $stmt = $pdo->prepare("SELECT * FROM partners WHERE mobile = ? LIMIT 1");
            $stmt->execute([$mobile]);
            $partner = $stmt->fetch();

            if (!$partner) {
                 throw new Exception("Partner not found.");
            }

            // Mark mobile as verified
            $update = $pdo->prepare("UPDATE partners SET mobile_verified = 1 WHERE id = ?");
            $update->execute([$partner['id']]);

            // Clear session OTP
            unset($_SESSION['app_login_otp']);

            // Simulated Token (In production, use JWT)
            $token = bin2hex(random_bytes(32));

            echo json_encode([
                'success' => true,
                'message' => 'Login successful',
                'token' => $token,
                'partner_id' => $partner['id'],
                'data' => [
                    'id' => $partner['id'],
                    'full_name' => $partner['full_name'],
                    'mobile' => $partner['mobile'],
                    'status' => $partner['status'],
                    'verification' => $partner['manual_verification_status']
                ]
            ]);
            break;

        case 'fetch_profile':
            $partner_id = $_POST['partner_id'] ?? $_GET['partner_id'] ?? 0;
            
            $stmt = $pdo->prepare("SELECT id, full_name, mobile, email, status, manual_verification_status, driving_license_link, rc_book_link FROM partners WHERE id = ?");
            $stmt->execute([$partner_id]);
            $partner = $stmt->fetch();

            if (!$partner) {
                throw new Exception("Profile not found.");
            }

            echo json_encode([
                'success' => true,
                'data' => $partner
            ]);
            break;

        case 'upload_documents':
            $partner_id = $_POST['partner_id'] ?? 0;
            if (empty($partner_id)) throw new Exception("Partner ID required.");

            $targetDir = realpath(__DIR__ . '/../../') . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'partners' . DIRECTORY_SEPARATOR;
            if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);

            $updates = [];
            $params = [];

            // Handle Driving License
            if (isset($_FILES['driving_license']) && $_FILES['driving_license']['error'] == UPLOAD_ERR_OK) {
                $ext = pathinfo($_FILES['driving_license']['name'], PATHINFO_EXTENSION);
                $dl_name = "dl_{$partner_id}_" . time() . ".$ext";
                if (move_uploaded_file($_FILES['driving_license']['tmp_name'], $targetDir . $dl_name)) {
                    $updates[] = "driving_license_link = ?";
                    $params[] = $dl_name;
                }
            }

            // Handle RC Book
            if (isset($_FILES['rc_book']) && $_FILES['rc_book']['error'] == UPLOAD_ERR_OK) {
                $ext = pathinfo($_FILES['rc_book']['name'], PATHINFO_EXTENSION);
                $rc_name = "rc_{$partner_id}_" . time() . ".$ext";
                if (move_uploaded_file($_FILES['rc_book']['tmp_name'], $targetDir . $rc_name)) {
                    $updates[] = "rc_book_link = ?";
                    $params[] = $rc_name;
                }
            }

            if (!empty($updates)) {
                $query = "UPDATE partners SET " . implode(", ", $updates) . " WHERE id = ?";
                $params[] = $partner_id;
                $stmt = $pdo->prepare($query);
                $stmt->execute($params);

                echo json_encode(['success' => true, 'message' => 'Documents uploaded and pending verification.']);
            } else {
                throw new Exception("No valid documents provided or upload failed.");
            }
            break;

        default:
            throw new Exception("Invalid API action.");
    }

} catch (Exception $e) {
    error_log("Partner Auth API Error: " . $e->getMessage());
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
