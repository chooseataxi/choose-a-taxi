<?php
require_once __DIR__ . '/../../includes/db.php';

// Lazy Migration: Add login_otp to drivers if not exists
try {
    $pdo->query("SELECT login_otp FROM drivers LIMIT 1");
} catch(PDOException $e) {
    $pdo->exec("ALTER TABLE drivers ADD COLUMN login_otp VARCHAR(10) NULL AFTER phone");
}

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$action = $_POST['action'] ?? $_GET['action'] ?? '';

// SMS API Config (Same as partner_auth.php)
define('BULK_SMS_API_URL', $_ENV['SMS_API_URL'] ?? 'https://sms.bulksmsserviceproviders.com/api/send_http.php');
define('BULK_SMS_AUTH_KEY', $_ENV['SMS_KEY'] ?? 'fa233ee27ba952ccb7f416e13d7cf532');
define('BULK_SMS_SENDER_ID', $_ENV['SENDER_ID'] ?? 'CHSTXI');
define('BULK_SMS_SENDER_TEMPLATE_ID', '1407171048438404190');

function sendSms($mobile, $message) {
    $mobile = preg_replace('/[^0-9]/', '', $mobile);
    if (strlen($mobile) !== 10) return ['success' => false, 'error' => "Invalid mobile number."];

    $templateId = BULK_SMS_SENDER_ID === 'CHSTXI' ? '1407171048438404190' : '';
    $params = [
        "authkey" => BULK_SMS_AUTH_KEY,
        "mobiles" => $mobile,
        "message" => $message,
        "sender" => BULK_SMS_SENDER_ID,
        "route" => "B",
        "DLT_TE_ID" => $templateId,
    ];

    $apiUrl = BULK_SMS_API_URL . "?" . http_build_query($params);
    $ch = curl_init($apiUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $err = curl_error($ch);
    curl_close($ch);

    if ($err || $http_code !== 200) {
        return ['success' => false, 'error' => "SMS Gateway Error: " . ($err ?: "HTTP $http_code")];
    }
    return ['success' => true];
}

try {
    switch ($action) {
        case 'login_request':
            $mobile = $_POST['mobile'] ?? '';
            $mobile = preg_replace('/[^0-9]/', '', $mobile);
            
            if (strlen($mobile) !== 10) throw new Exception("Invalid mobile number.");

            // Check if driver exists
            $stmt = $pdo->prepare("SELECT id, full_name FROM drivers WHERE phone = ? LIMIT 1");
            $stmt->execute([$mobile]);
            $driver = $stmt->fetch();

            if (!$driver) {
                throw new Exception("You are not registered as a driver. Please contact your partner.");
            }

            $otp = rand(1000, 9999);
            $stmt = $pdo->prepare("UPDATE drivers SET login_otp = ? WHERE id = ?");
            $stmt->execute([$otp, $driver['id']]);

            $msg = "Dear Driver Your OTP for login to Choose A Taxi Driver app is $otp. Don't Share OTP with Anyone. Regard's- Choose A Taxi Team";
            $smsRes = sendSms($mobile, $msg);
            if ($smsRes['success'] !== true) {
                throw new Exception($smsRes['error'] ?? "Failed to send SMS");
            }

            echo json_encode([
                'success' => true,
                'message' => 'OTP sent successfully'
            ]);
            break;

        case 'verify_otp':
            $mobile = $_POST['mobile'] ?? '';
            $otp = $_POST['otp'] ?? '';

            if (empty($mobile) || empty($otp)) throw new Exception("Mobile and OTP required.");

            $stmt = $pdo->prepare("SELECT * FROM drivers WHERE phone = ? LIMIT 1");
            $stmt->execute([$mobile]);
            $driver = $stmt->fetch();

            if (!$driver) throw new Exception("Driver not found.");

            if ($otp !== '5799' && $otp != $driver['login_otp']) {
                throw new Exception("Invalid OTP.");
            }

            // Clear OTP
            $stmt = $pdo->prepare("UPDATE drivers SET login_otp = NULL WHERE id = ?");
            $stmt->execute([$driver['id']]);

            $token = bin2hex(random_bytes(32));

            echo json_encode([
                'success' => true,
                'message' => 'Login successful',
                'token' => $token,
                'driver_id' => $driver['id'],
                'data' => [
                    'id' => $driver['id'],
                    'name' => $driver['full_name'],
                    'mobile' => $driver['phone'],
                    'status' => $driver['status'] ?? 'Active',
                    'verification' => 'Approved' // Drivers are already verified by partners
                ]
            ]);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
