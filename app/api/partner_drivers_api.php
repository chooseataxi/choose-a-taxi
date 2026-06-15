<?php

require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../includes/wallet_helper.php';


header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// ──────────────────────────────────────────────────────────────────────────────
// Create drivers table if not exists
// ──────────────────────────────────────────────────────────────────────────────
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS drivers (
        id INT AUTO_INCREMENT PRIMARY KEY,
        partner_id INT NOT NULL,
        full_name VARCHAR(100) NOT NULL,
        license_number VARCHAR(50) UNIQUE NOT NULL,
        dob DATE NOT NULL,
        doe DATE, 
        doi DATE, 
        gender ENUM('M', 'F', 'X'),
        father_or_husband_name VARCHAR(100),
        state VARCHAR(100),
        permanent_address TEXT,
        profile_image_path TEXT,
        blood_group VARCHAR(10),
        vehicle_classes JSON, 
        status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active',
        is_partner_self TINYINT(1) DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
} catch (PDOException $e) {
}

$action = $_REQUEST['action'] ?? '';
$partner_id = $_REQUEST['partner_id'] ?? '';

// Support JSON body for partner_id & action
$rawInput = file_get_contents("php://input");
$jsonData = json_decode($rawInput, true);
if (is_array($jsonData)) {
    if (empty($action) && isset($jsonData['action'])) {
        $action = $jsonData['action'];
    }
    if (empty($partner_id) && isset($jsonData['partner_id'])) {
        $partner_id = $jsonData['partner_id'];
    }
}

if ($action !== 'options') {
    if (empty($partner_id) || !is_numeric($partner_id) || intval($partner_id) <= 0) {
        $valStr = is_null($partner_id) ? 'null' : (is_string($partner_id) ? "'$partner_id'" : var_export($partner_id, true));
        echo json_encode(["status" => "error", "message" => "A valid partner_id is required. Received: " . $valStr]);
        exit;
    }
    
    // Check if partner exists in the database
    $checkPartner = $pdo->prepare("SELECT id FROM partners WHERE id = ?");
    $checkPartner->execute([$partner_id]);
    if (!$checkPartner->fetch()) {
        echo json_encode(["status" => "error", "message" => "Partner account not found for ID: " . $partner_id . ". Please log out and log in again."]);
        exit;
    }
}

// Removed redundant local updateWallet definition as it is now provided by wallet_helper.php

// ──────────────────────────────────────────────────────────────────────────────
// Helper: Surepass DL API call
// ──────────────────────────────────────────────────────────────────────────────
function verifyDrivingLicense($license_number, $dob)
{
    // ── Token retrieval with trim to prevent whitespace issues ──
    $token = trim($_ENV['SUREPASS_TOKEN'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3OTcxODcxNCwianRpIjoiYjI2OTU0YjEtODE3OS00MWRkLTg2ZGMtNmYxZTgzNzdmNDE4IiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LnJvaGl0XzAzNDVAc3VyZXBhc3MuaW8iLCJuYmYiOjE3Nzk3MTg3MTQsImV4cCI6MjA5NTA3ODcxNCwiZW1haWwiOiJyb2hpdF8wMzQ1QHN1cmVwYXNzLmlvIiwidGVuYW50X2lkIjoibWFpbiIsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ1c2VyIl19fQ.8ZYs7N7vRhAD50h5x7WDMYcMWu2ctZTjUst833FclMA');
    
    // ── Try the primary endpoint ──
    $baseUrl = rtrim($_ENV['SUREPASS_BASE_URL'] ?? 'https://kyc-api.surepass.app/api/v1', '/');
    $url = $baseUrl . "/driving-license/driving-license";

    if (!$token)
        return ["status" => "error", "message" => "SUREPASS_TOKEN missing"];

    $body = json_encode([
        "id_number" => $license_number,
        "dob" => $dob
    ]);

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "Content-Type: application/json",
        "Authorization: Bearer " . $token
    ]);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $body);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // If 401 or 404, try the alternate dl-details endpoint
    if ($httpCode === 401 || $httpCode === 404) {
        $urlAlt = $baseUrl . "/driving-license/dl-details";
        $ch = curl_init($urlAlt);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ["Content-Type: application/json", "Authorization: Bearer " . $token]);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
        $responseAlt = curl_exec($ch);
        $httpCodeAlt = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        
        if ($httpCodeAlt === 200) {
            $httpCode = $httpCodeAlt;
            $response = $responseAlt;
        }
    }

    if ($httpCode === 200) {
        $j = json_decode($response, true);
        if ($j['success'] ?? false) {
            return ["status" => "success", "data" => $j['data']];
        }
        return ["status" => "error", "message" => $j['message'] ?? "Verification failed"];
    }
    
    // Return detailed error for debugging if it's still failing
    $errorDetail = "";
    if ($response) {
        $jErr = json_decode($response, true);
        $errorDetail = " - " . ($jErr['message'] ?? $response);
    }
    return ["status" => "error", "message" => "Surepass API Error: $httpCode" . $errorDetail];
}

try {
    switch ($action) {
        case 'get_drivers':
            // Auto-deactivate expired drivers before sending list
            $pdo->prepare("UPDATE drivers SET status = 'Inactive' WHERE doe < CURDATE() AND status = 'Active' AND partner_id = ?")->execute([$partner_id]);

            $stmt = $pdo->prepare("SELECT * FROM drivers WHERE partner_id = ? ORDER BY id DESC");
            $stmt->execute([$partner_id]);
            $drivers = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode(["status" => "success", "data" => $drivers]);
            break;

        case 'add_driver':
            $license_number = $_POST['license_number'] ?? '';
            $dob = $_POST['dob'] ?? ''; // YYYY-MM-DD
            $phone = $_POST['phone'] ?? ''; // NEW
            $is_self = $_POST['is_self'] ?? 0;

            if (empty($license_number) || empty($dob) || empty($phone))
                throw new Exception("License number, DOB, and Mobile are required");

            $fee = 7.50;

            $verification = verifyDrivingLicense($license_number, $dob);
            if ($verification['status'] !== 'success')
                throw new Exception($verification['message']);

            $data = $verification['data'];

            // Handle Profile Image Saving
            $imgPath = "";
            if (!empty($data['profile_image']) && $data['profile_image'] !== 'base64Image') {
                $imgData = base64_decode($data['profile_image']);
                $fileName = "driver_" . $partner_id . "_" . time() . ".jpg";
                $targetDir = __DIR__ . '/../../uploads/drivers/';
                if (!is_dir($targetDir))
                    mkdir($targetDir, 0777, true);
                file_put_contents($targetDir . $fileName, $imgData);
                $imgPath = "https://chooseataxi.com/uploads/drivers/" . $fileName;
            }

            // Insert into DB
            $stmt = $pdo->prepare("INSERT INTO drivers 
                (partner_id, full_name, license_number, dob, doe, doi, gender, father_or_husband_name, state, permanent_address, profile_image_path, vehicle_classes, phone, is_partner_self) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            $stmt->execute([
                $partner_id,
                $data['name'],
                $data['license_number'],
                $data['dob'],
                $data['doe'],
                $data['doi'],
                $data['gender'],
                $data['father_or_husband_name'],
                $data['state'],
                $data['permanent_address'],
                $imgPath,
                json_encode($data['vehicle_classes']),
                $phone,
                $is_self
            ]);

            // ── Deduct Fee ──
            updateWallet($pdo, $partner_id, $fee, 'Debit', 'Driver Registration', 0, "Registration fee for Driver: " . $data['name']);

            echo json_encode(["status" => "success", "message" => "Driver added successfully and ₹$fee deducted from wallet.", "data" => $data]);
            break;

        case 'update_status':
            $driver_id = $_POST['driver_id'] ?? '';
            $status = $_POST['status'] ?? '';
            if (!$driver_id || !$status)
                throw new Exception("Missing parameters");

            if ($status === 'Active') {
                $stmt = $pdo->prepare("SELECT doe FROM drivers WHERE id = ? AND partner_id = ?");
                $stmt->execute([$driver_id, $partner_id]);
                $d = $stmt->fetch();
                if ($d && strtotime($d['doe']) < time()) {
                    throw new Exception("Cannot activate: Driving License is expired. Please renew first.");
                }
            }

            $stmt = $pdo->prepare("UPDATE drivers SET status = ? WHERE id = ? AND partner_id = ?");
            $stmt->execute([$status, $driver_id, $partner_id]);
            echo json_encode(["status" => "success", "message" => "Status updated"]);
            break;

        case 'renew_license':
            $driver_id = $_POST['driver_id'] ?? '';
            if (!$driver_id) throw new Exception("Driver ID required");

            $stmt = $pdo->prepare("SELECT * FROM drivers WHERE id = ? AND partner_id = ?");
            $stmt->execute([$driver_id, $partner_id]);
            $driver = $stmt->fetch();
            if (!$driver) throw new Exception("Driver not found");

            $fee = 7.50;
            // Wallet check removed to allow negative balance

            // 2. Verify with Surepass
            $verification = verifyDrivingLicense($driver['license_number'], $driver['dob']);
            if ($verification['status'] !== 'success') throw new Exception($verification['message']);
            
            $data = $verification['data'];
            // Check if new doe is still in the past
            if (strtotime($data['doe']) <= time()) {
                 throw new Exception("License still shows as expired in official records (Expires: " . $data['doe'] . "). Please try again once it is updated in the Parivahan system.");
            }

            // 3. Deduct Fee
            if (!updateWallet($pdo, $partner_id, $fee, 'Debit', 'Driver Registration', $driver_id, "License Renewal fee for Driver: " . $driver['full_name'])) {
                throw new Exception("Wallet deduction failed");
            }

            // 4. Update DB
            $stmt = $pdo->prepare("UPDATE drivers SET doe = ?, doi = ?, status = 'Active' WHERE id = ?");
            $stmt->execute([$data['doe'], $data['doi'], $driver_id]);

            echo json_encode(["status" => "success", "message" => "License renewed successfully and Driver activated!", "doe" => $data['doe']]);
            break;

        case 'delete_driver':
            $driver_id = $_POST['driver_id'] ?? '';
            if (!$driver_id)
                throw new Exception("Driver ID required");

            $stmt = $pdo->prepare("DELETE FROM drivers WHERE id = ? AND partner_id = ?");
            $stmt->execute([$driver_id, $partner_id]);
            echo json_encode(["status" => "success", "message" => "Driver removed"]);
            break;

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
