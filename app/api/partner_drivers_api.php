<?php

require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/../../includes/db.php';

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

if (empty($partner_id) && $action !== 'options') {
    echo json_encode(["status" => "error", "message" => "partner_id is required"]);
    exit;
}

// ──────────────────────────────────────────────────────────────────────────────
// Helper: Update Wallet & Log Transaction
// ──────────────────────────────────────────────────────────────────────────────
function updateWallet($pdo, $partner_id, $amount, $type, $description) {
    try {
        $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
        $stmt->execute([$partner_id]);

        if ($type === 'Credit') {
            $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
        } else {
            $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance - ? WHERE partner_id = ?");
        }
        $stmt->execute([$amount, $partner_id]);

        $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, description) VALUES (?, ?, ?, 'Driver Registration', ?)");
        $stmt->execute([$partner_id, $type, $amount, $description]);
        return true;
    } catch (Exception $e) { return false; }
}

// ──────────────────────────────────────────────────────────────────────────────
// Helper: Surepass DL API call
// ──────────────────────────────────────────────────────────────────────────────
function verifyDrivingLicense($license_number, $dob)
{
    // ── Token retrieval with fallback (same as partner_vehicles_api.php) ──
    $token = $_ENV['SUREPASS_TOKEN'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3NDg3NzAwMywianRpIjoiZGUxNGRmYmUtMmE3NC00NGQ5LWIxMzEtZGZhMWNlODBhMTc2IiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LnJvaGl0XzAzNDVAc3VyZXBhc3MuaW8iLCJuYmYiOjE3NzQ4NzcwMDMsImV4cCI6MjQwNTU5NzAwMywiZW1haWwiOiJyb2hpdF8wMzQ1QHN1cmVwYXNzLmlvIiwidGVuYW50X2lkIjoibWFpbiIsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ1c2VyIl19fQ.UC3ebDNZdNjyUxDhez-7IIACaf224xpA5rl8DaQRFpU';
    if (!$token)
        return ["status" => "error", "message" => "SUREPASS_TOKEN missing"];

    $url = "https://kyc-api.surepass.io/api/v1/driving-license/driving-license";
    $body = json_encode([
        "id_number" => $license_number,
        "dob" => $dob
    ]);

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30); // 30s max
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10); // 10s to connect
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "Content-Type: application/json",
        "Authorization: Bearer " . $token
    ]);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $body);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode === 200) {
        $j = json_decode($response, true);
        if ($j['success'] ?? false) {
            return ["status" => "success", "data" => $j['data']];
        }
        return ["status" => "error", "message" => $j['message'] ?? "Verification failed"];
    }
    return ["status" => "error", "message" => "Surepass API Error: $httpCode"];
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
            updateWallet($pdo, $partner_id, $fee, 'Debit', "Registration fee for Driver: " . $data['name']);

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
            if (!updateWallet($pdo, $partner_id, $fee, 'Debit', "License Renewal fee for Driver: " . $driver['full_name'])) {
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
