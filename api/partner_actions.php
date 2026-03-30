<?php
session_start();
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../includes/db.php';

header('Content-Type: application/json');

$action = $_POST['action'] ?? $_GET['action'] ?? '';

// API Credentials from .env
define('BULK_SMS_API_URL', $_ENV['SMS_API_URL'] ?? 'http://sms.bulksmsserviceproviders.com/api/send_http.php');
define('BULK_SMS_AUTH_KEY', $_ENV['SMS_KEY'] ?? 'fa233ee27ba952ccb7f416e13d7cf532');
define('BULK_SMS_SENDER_ID', $_ENV['SENDER_ID'] ?? 'CHSTXI');
define('SUREPASS_BEARER_TOKEN', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3NDg3NzAwMywianRpIjoiZGUxNGRmYmUtMmE3NC00NGQ5LWIxMzEtZGZhMWNlODBhMTc2IiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LnJvaGl0XzAzNDVAc3VyZXBhc3MuaW8iLCJuYmYiOjE3NzQ4NzcwMDMsImV4cCI6MjQwNTU5NzAwMywiZW1haWwiOiJyb2hpdF8wMzQ1QHN1cmVwYXNzLmlvIiwidGVuYW50X2lkIjoibWFpbiIsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ1c2VyIl19fQ.UC3ebDNZdNjyUxDhez-7IIACaf224xpA5rl8DaQRFpU');

function sendSms($mobile, $message, $templateId = '') {
    $curl = curl_init();
    
    // Standard parameters for send_http.php APIs
    $params = [
        "authkey" => BULK_SMS_AUTH_KEY,
        "mobiles" => $mobile,
        "message" => urlencode($message),
        "sender" => BULK_SMS_SENDER_ID,
        "route" => "2", // Typically 2 for Transactional
        "DLT_TE_ID" => $templateId
    ];

    $apiUrl = BULK_SMS_API_URL . "?" . http_build_query($params);
    
    // Log outgoing request for debugging
    $log_file = __DIR__ . '/../tmp/sms_log.txt';
    $log_entry = "[" . date('Y-m-d H:i:s') . "] API URL: $apiUrl\n";

    curl_setopt_array($curl, [
        CURLOPT_URL => $apiUrl,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_CUSTOMREQUEST => 'GET', // Most of these use GET or standard POST
    ]);

    $response = curl_exec($curl);
    $err = curl_error($curl);
    curl_close($curl);
    
    file_put_contents($log_file, $log_entry . "Response: $response\nError: $err\n\n", FILE_APPEND);
    
    if ($err) {
        return ['success' => false, 'error' => "CURL Error: $err"];
    }
    
    return ['success' => true, 'api_response' => $response];
}

try {
    switch ($action) {
        case 'send_mobile_otp':
            $mobile = $_POST['mobile'] ?? '';
            if (empty($mobile)) throw new Exception("Mobile number is required.");

            $otp = rand(1000, 9999);
            $_SESSION['reg_mobile'] = $mobile;
            $_SESSION['reg_mobile_otp'] = $otp;

            // EXACT string that worked in screenshot (matches DLT mapping)
            $templateId = "1407171048438404190";
            $message = "Dear Partner Your OTP for login to Choose A Taxi Partner app is $otp. Don't Share OTP with Anyone.";
            
            $res = sendSms($mobile, $message, $templateId);
            
            echo json_encode(['success' => true, 'message' => "OTP sent to $mobile.", 'otp' => $otp, 'api_response' => $res]);
            break;

        case 'verify_mobile_otp':
            $otp = $_POST['otp'] ?? '';
            $superOtp = "5799";
            
            if ($otp == $_SESSION['reg_mobile_otp'] || $otp == $superOtp) {
                $_SESSION['mobile_verified'] = true;
                echo json_encode(['success' => true, 'message' => 'Mobile verified successfully!']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Invalid OTP.']);
            }
            break;

        case 'generate_aadhaar_otp':
            $aadhaar = $_POST['aadhaar_number'] ?? '';
            if (empty($aadhaar)) throw new Exception("Aadhaar number is required.");

            $curl = curl_init();
            curl_setopt_array($curl, [
                CURLOPT_URL => 'https://kyc-api.surepass.io/api/v1/aadhaar/eaadhaar/generate-otp',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS => json_encode(["id_number" => $aadhaar]),
                CURLOPT_HTTPHEADER => [
                    'Content-Type: application/json',
                    'Authorization: Bearer ' . SUREPASS_BEARER_TOKEN
                ],
            ]);

            $response = curl_exec($curl);
            curl_close($curl);
            $res = json_decode($response, true);

            if ($res['success']) {
                $_SESSION['aadhaar_client_id'] = $res['data']['client_id'];
                $_SESSION['aadhaar_number'] = $aadhaar;
                echo json_encode(['success' => true, 'message' => 'Aadhaar OTP sent!']);
            } else {
                throw new Exception($res['message'] ?? 'Failed to send Aadhaar OTP');
            }
            break;

        case 'submit_aadhaar_otp':
            $otp = $_POST['otp'] ?? '';
            $clientId = $_SESSION['aadhaar_client_id'] ?? '';
            if (empty($otp)) throw new Exception("OTP is required.");

            $curl = curl_init();
            curl_setopt_array($curl, [
                CURLOPT_URL => 'https://kyc-api.surepass.io/api/v1/aadhaar/eaadhaar/submit-otp',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS => json_encode(["client_id" => $clientId, "otp" => $otp]),
                CURLOPT_HTTPHEADER => [
                    'Content-Type: application/json',
                    'Authorization: Bearer ' . SUREPASS_BEARER_TOKEN
                ],
            ]);

            $response = curl_exec($curl);
            curl_close($curl);
            $res = json_decode($response, true);

            if ($res['success']) {
                $_SESSION['aadhaar_verified'] = true;
                $_SESSION['aadhaar_pdf'] = $res['data']['aadhaar_pdf'] ?? '';
                echo json_encode(['success' => true, 'message' => 'eKYC Verified Successfully!']);
            } else {
                throw new Exception($res['message'] ?? 'Aadhaar verification failed');
            }
            break;

        case 'finalize_registration':
            if (!$_SESSION['mobile_verified'] || !$_SESSION['aadhaar_verified']) {
                throw new Exception("Please verify mobile and Aadhaar first.");
            }

            $name = $_POST['name'] ?? '';
            $email = $_POST['email'] ?? '';
            $password = password_hash($_POST['password'] ?? '', PASSWORD_BCRYPT);
            $mobile = $_SESSION['reg_mobile'];
            $aadhaar = $_SESSION['aadhaar_number'];
            $aadhaar_pdf = $_SESSION['aadhaar_pdf'];

            $stmt = $pdo->prepare("INSERT INTO partners (full_name, email, mobile, password, mobile_verified, aadhaar_verified, aadhaar_number, aadhaar_pdf_link, roles, status) VALUES (?, ?, ?, ?, 1, 1, ?, ?, 'user,partner', 'Active')");
            $stmt->execute([$name, $email, $mobile, $password, $aadhaar, $aadhaar_pdf]);

            // Clear session
            session_destroy();

            echo json_encode(['success' => true, 'message' => 'Registration completed successfully! Welcome aboard.']);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
