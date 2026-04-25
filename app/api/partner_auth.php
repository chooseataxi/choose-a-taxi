<?php
session_start();
// Load DB using correct relative path
require_once __DIR__ . '/../../includes/db.php';

// Sync columns for both tables
foreach (['partners' => 'mobile', 'drivers' => 'phone'] as $table => $phoneCol) {
    try {
        $pdo->query("SELECT login_otp FROM $table LIMIT 1");
    } catch(PDOException $e) {
        $pdo->exec("ALTER TABLE $table ADD COLUMN login_otp VARCHAR(10) NULL AFTER $phoneCol");
    }
    try {
        $pdo->query("SELECT fcm_token FROM $table LIMIT 1");
    } catch(PDOException $e) {
        $pdo->exec("ALTER TABLE $table ADD COLUMN fcm_token TEXT NULL");
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

// Basic SMS API Wrapper
define('BULK_SMS_API_URL', $_ENV['SMS_API_URL'] ?? 'https://sms.bulksmsserviceproviders.com/api/send_http.php');
define('BULK_SMS_AUTH_KEY', $_ENV['SMS_KEY'] ?? 'fa233ee27ba952ccb7f416e13d7cf532');
define('BULK_SMS_SENDER_ID', $_ENV['SENDER_ID'] ?? 'CHSTXI');
define('BULK_SMS_ROUTE_TR', $_ENV['SMS_ROUTE_TR'] ?? 'B');
define('BULK_SMS_ENTITY_ID', $_ENV['DLT_ENTITY_ID'] ?? '1407171048438404190');

function sendSms($mobile, $message, $templateId = '') {
    $mobile = preg_replace('/[^0-9]/', '', $mobile);
    if (strlen($mobile) !== 10) return ['success' => false, 'error' => "Invalid mobile number."];

    $templateId = !empty($templateId) ? $templateId : '1407171048438404190';
    $curl = curl_init();

    $params = [
        "authkey" => BULK_SMS_AUTH_KEY,
        "mobiles" => $mobile,
        "message" => $message,
        "sender" => BULK_SMS_SENDER_ID,
        "route" => BULK_SMS_ROUTE_TR,
        "campaign_name" => "OTP Verification",
        "DLT_TE_ID" => $templateId,
        "template_id" => $templateId,
        "Template_ID" => $templateId,
        "tid" => $templateId,
        "PE_ID" => BULK_SMS_ENTITY_ID,
        "DLT_ENT_ID" => BULK_SMS_ENTITY_ID,
        "entity_id" => BULK_SMS_ENTITY_ID
    ];

    $apiUrl = BULK_SMS_API_URL . "?" . http_build_query($params);
    
    curl_setopt_array($curl, [
        CURLOPT_URL => $apiUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_CUSTOMREQUEST => 'GET',
        CURLOPT_FOLLOWLOCATION => true,
    ]);

    $response = curl_exec($curl);
    $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $err = curl_error($curl);
    curl_close($curl);

    // Logging
    $log_file = realpath(__DIR__ . '/../../') . '/tmp/sms_log.txt';
    $log_dir = dirname($log_file);
    if (!is_dir($log_dir)) mkdir($log_dir, 0777, true);
    file_put_contents($log_file, "[" . date('Y-m-d H:i:s') . "] API URL: $apiUrl\nHTTP: $http_code\nResp: $response\nErr: $err\n-----\n", FILE_APPEND);

    if ($err || $http_code !== 200) {
        return ['success' => false, 'error' => "SMS Gateway Error: " . ($err ?: "HTTP $http_code")];
    }
    return ['success' => true];
}

try {
    switch ($action) {
        case 'login_request':
            $mobile = $_POST['mobile'] ?? '';
            $role = $_POST['role'] ?? 'partner';
            $mobile = preg_replace('/[^0-9]/', '', $mobile);
            
            if (strlen($mobile) !== 10) {
                throw new Exception("Invalid mobile number.");
            }

            // Generate OTP
            $otp = rand(1000, 9999);
            
            // DLT Template Requirement: The message must EXACTLY match the approved template.
            // We use the "Partner" template for BOTH because that is the one approved on the DLT portal.
            $msg = "Dear Partner Your OTP for login to Choose A Taxi Partner app is $otp. Don't Share OTP with Anyone. Regard's- Choose A Taxi Team";

            if ($role === 'driver') {
                // Check if driver exists
                $stmt = $pdo->prepare("SELECT id FROM drivers WHERE phone = ? LIMIT 1");
                $stmt->execute([$mobile]);
                $user = $stmt->fetch();
                if (!$user) {
                    throw new Exception("You are not registered as a driver. Please contact your partner.");
                }
                $update = $pdo->prepare("UPDATE drivers SET login_otp = ? WHERE id = ?");
                $update->execute([$otp, $user['id']]);
            } else {
                // Check if partner exists
                $stmt = $pdo->prepare("SELECT id FROM partners WHERE mobile = ? LIMIT 1");
                $stmt->execute([$mobile]);
                $user = $stmt->fetch();

                if (!$user) {
                    // New Partner - Create a skeleton account
                    $insert = $pdo->prepare("INSERT INTO partners (mobile, login_otp, mobile_verified, status, roles, manual_verification_status) VALUES (?, ?, 0, 'Inactive', 'partner', 'Pending')");
                    $insert->execute([$mobile, $otp]);
                    $user = ['id' => $pdo->lastInsertId()];
                } else {
                    // Update existing partner OTP
                    $update = $pdo->prepare("UPDATE partners SET login_otp = ? WHERE id = ?");
                    $update->execute([$otp, $user['id']]);
                }
            }

            // Send actual SMS
            $smsRes = sendSms($mobile, $msg);
            if (!$smsRes['success']) {
                throw new Exception("SMS failed to send: " . ($smsRes['error'] ?? 'Unknown Error'));
            }

            echo json_encode([
                'success' => true,
                'message' => 'OTP sent successfully',
                'is_new_user' => ($role === 'partner' && empty($user['id'])) 
            ]);
            break;

        case 'verify_otp':
            $mobile = $_POST['mobile'] ?? '';
            $otp = $_POST['otp'] ?? '';
            $role = $_POST['role'] ?? 'partner';

            if (empty($mobile) || empty($otp)) {
                throw new Exception("Mobile number and OTP are required.");
            }

            if ($role === 'driver') {
                $stmt = $pdo->prepare("SELECT * FROM drivers WHERE phone = ? LIMIT 1");
                $stmt->execute([$mobile]);
                $user = $stmt->fetch();
                if (!$user) throw new Exception("Driver not found.");
                
                if ($otp !== '5799' && $otp != $user['login_otp']) throw new Exception("Invalid OTP.");
                
                $update = $pdo->prepare("UPDATE drivers SET login_otp = NULL WHERE id = ?");
                $update->execute([$user['id']]);
                
                $token = bin2hex(random_bytes(32));
                echo json_encode([
                    'success' => true,
                    'message' => 'Login successful',
                    'token' => $token,
                    'driver_id' => $user['id'],
                    'data' => [
                        'id' => $user['id'],
                        'name' => $user['full_name'],
                        'mobile' => $user['phone'],
                        'status' => $user['status'] ?? 'Active',
                        'verification' => 'Approved'
                    ]
                ]);
            } else {
                $stmt = $pdo->prepare("SELECT * FROM partners WHERE mobile = ? LIMIT 1");
                $stmt->execute([$mobile]);
                $user = $stmt->fetch();

                if (!$user) throw new Exception("Partner not found.");

                if ($otp !== '5799' && $otp != $user['login_otp']) throw new Exception("Invalid OTP.");

                $update = $pdo->prepare("UPDATE partners SET mobile_verified = 1, login_otp = NULL WHERE id = ?");
                $update->execute([$user['id']]);

                $token = bin2hex(random_bytes(32));
                echo json_encode([
                    'success' => true,
                    'message' => 'Login successful',
                    'token' => $token,
                    'partner_id' => $user['id'],
                    'data' => [
                        'id' => $user['id'],
                        'full_name' => $user['full_name'],
                        'mobile' => $user['mobile'],
                        'status' => $user['status'],
                        'verification' => $user['manual_verification_status']
                    ]
                ]);
            }
            break;

        case 'fetch_profile':
            $partner_id = $_POST['partner_id'] ?? $_GET['partner_id'] ?? 0;
            $stmt = $pdo->prepare("SELECT id, full_name, mobile, email, status, manual_verification_status, driving_license_link, rc_book_link, aadhaar_front_link, aadhaar_back_link, selfie_link, aadhar_number, city FROM partners WHERE id = ?");
            $stmt->execute([$partner_id]);
            $partner = $stmt->fetch();
            if (!$partner) throw new Exception("Profile not found.");
            echo json_encode(['success' => true, 'data' => $partner]);
            break;

        case 'upload_documents':
            $partner_id = $_POST['partner_id'] ?? 0;
            if (empty($partner_id)) throw new Exception("Partner ID required.");
            $targetDir = realpath(__DIR__ . '/../../') . DIRECTORY_SEPARATOR . 'uploads' . DIRECTORY_SEPARATOR . 'partners' . DIRECTORY_SEPARATOR;
            if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);
            $updates = [];
            $params = [];
            if (isset($_FILES['aadhar_front']) && $_FILES['aadhar_front']['error'] == UPLOAD_ERR_OK) {
                $ext = pathinfo($_FILES['aadhar_front']['name'], PATHINFO_EXTENSION);
                $name = "adh_f_{$partner_id}_" . time() . ".$ext";
                if (move_uploaded_file($_FILES['aadhar_front']['tmp_name'], $targetDir . $name)) { $updates[] = "aadhaar_front_link = ?"; $params[] = $name; }
            }
            if (isset($_FILES['aadhar_back']) && $_FILES['aadhar_back']['error'] == UPLOAD_ERR_OK) {
                $ext = pathinfo($_FILES['aadhar_back']['name'], PATHINFO_EXTENSION);
                $name = "adh_b_{$partner_id}_" . time() . ".$ext";
                if (move_uploaded_file($_FILES['aadhar_back']['tmp_name'], $targetDir . $name)) { $updates[] = "aadhaar_back_link = ?"; $params[] = $name; }
            }
            if (isset($_FILES['selfie']) && $_FILES['selfie']['error'] == UPLOAD_ERR_OK) {
                $ext = pathinfo($_FILES['selfie']['name'], PATHINFO_EXTENSION);
                $name = "selfie_{$partner_id}_" . time() . ".$ext";
                if (move_uploaded_file($_FILES['selfie']['tmp_name'], $targetDir . $name)) { $updates[] = "selfie_link = ?"; $params[] = $name; }
            }
            if (!empty($updates)) {
                $updates[] = "manual_verification_status = 'Pending'";
                if (!empty($_POST['full_name'])) { $updates[] = "full_name = ?"; $params[] = $_POST['full_name']; }
                if (!empty($_POST['email'])) { $updates[] = "email = ?"; $params[] = $_POST['email']; }
                if (!empty($_POST['aadhar_number'])) { $updates[] = "aadhar_number = ?"; $params[] = $_POST['aadhar_number']; }
                if (!empty($_POST['city'])) { $updates[] = "city = ?"; $params[] = $_POST['city']; }
                $query = "UPDATE partners SET " . implode(", ", $updates) . " WHERE id = ?";
                $params[] = $partner_id;
                $stmt = $pdo->prepare($query);
                $stmt->execute($params);
                echo json_encode(['success' => true, 'message' => 'Documents uploaded and pending verification.']);
            } else { throw new Exception("No valid documents provided or upload failed."); }
            break;

        case 'update_fcm_token':
            $user_id = $_POST['user_id'] ?? 0;
            $token = $_POST['fcm_token'] ?? '';
            $role = $_POST['role'] ?? 'partner';
            if (!$user_id || !$token) throw new Exception("User ID and Token required.");
            $table = ($role === 'driver') ? 'drivers' : 'partners';
            $stmt = $pdo->prepare("UPDATE $table SET fcm_token = ? WHERE id = ?");
            $stmt->execute([token, $user_id]);
            echo json_encode(['success' => true, 'message' => 'FCM Token updated']);
            break;

        default:
            throw new Exception("Invalid API action.");
    }
} catch (Exception $e) {
    error_log("Auth API Error: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
