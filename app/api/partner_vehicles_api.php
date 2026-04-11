<?php
error_reporting(0);
ini_set('display_errors', 0);
require_once __DIR__ . '/../../includes/db.php';
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// ──────────────────────────────────────────────
// Create partner_vehicles table if not exists
// ──────────────────────────────────────────────
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS partner_vehicles (
        id                      INT AUTO_INCREMENT PRIMARY KEY,
        partner_id              INT NOT NULL,
        rc_number               VARCHAR(20) NOT NULL,
        owner_name              VARCHAR(150),
        maker_description       VARCHAR(150),
        maker_model             VARCHAR(150),
        body_type               VARCHAR(100),
        fuel_type               VARCHAR(50),
        color                   VARCHAR(50),
        seat_capacity           VARCHAR(10),
        vehicle_category_desc   VARCHAR(100),
        registration_date       VARCHAR(20),
        fit_up_to               VARCHAR(20),
        insurance_company       VARCHAR(200),
        insurance_policy_number VARCHAR(100),
        insurance_upto          VARCHAR(20),
        norms_type              VARCHAR(100),
        rc_status               VARCHAR(50),
        permit_type             VARCHAR(100),
        permit_valid_upto       VARCHAR(20),
        raw_rc_data             LONGTEXT,
        front_image             VARCHAR(255),
        back_image              VARCHAR(255),
        status                  ENUM('Active','Inactive','Pending') DEFAULT 'Active',
        created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )");
} catch(PDOException $e) {}

$action = $_REQUEST['action'] ?? '';
$partner_id = $_REQUEST['partner_id'] ?? '';

if (empty($partner_id) && $action !== 'lookup_rc' && $action !== 'options') {
    echo json_encode(['status' => 'error', 'message' => 'partner_id required']);
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

        $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, description) VALUES (?, ?, ?, 'Vehicle Registration', ?)");
        $stmt->execute([$partner_id, $type, $amount, $description]);
        return true;
    } catch (Exception $e) { return false; }
}

// ──────────────────────────────────────────────────────────────────────────────
// Helper: Check Vehicle Compliance (Dates & Permit)
// ──────────────────────────────────────────────────────────────────────────────
function isVehicleCompliant($v) {
    $today = date('Y-m-d');
    
    // 1. Check Date Formats and Expiry
    $fit     = $v['fit_up_to'] ?? '';
    $ins     = $v['insurance_upto'] ?? '';
    $permit  = $v['permit_valid_upto'] ?? '';
    $pType   = strtolower($v['permit_type'] ?? '');

    if (empty($fit) || empty($ins) || empty($permit)) return ['status' => false, 'msg' => 'Required documents (Fitness, Insurance, or Permit) are missing.'];
    
    if (strtotime($fit) < strtotime($today)) return ['status' => false, 'msg' => 'Vehicle Fitness (Passing) has expired.'];
    if (strtotime($ins) < strtotime($today)) return ['status' => false, 'msg' => 'Vehicle Insurance has expired.'];
    if (strtotime($permit) < strtotime($today)) return ['status' => false, 'msg' => 'Vehicle Permit has expired.'];

    // 2. Check for Private vs Taxi
    // Permits usually contain 'Taxi' or 'Transport' for commercial vehicles.
    // If it's explicitly 'Private' or no permit type provided, it's likely not a taxi.
    if (empty($pType) || strpos($pType, 'private') !== false) {
        return ['status' => false, 'msg' => "This vehicle can't be added because it's a private vehicle, not a taxi."];
    }

    return ['status' => true];
}

// ──────────────────────────────────────────────
// ACTION: lookup_rc  — hits Surepass API
// ──────────────────────────────────────────────
if ($action === 'lookup_rc') {
    $raw = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data)) $data = $_POST;

    $rc_number = strtoupper(trim($data['rc_number'] ?? ''));
    if (empty($rc_number)) {
        echo json_encode(['status' => 'error', 'message' => 'RC number is required']);
        exit;
    }

    // ── Call Surepass RC Full API (token from .env → $_ENV, with fallback like partner_auth.php) ──
    $surepassToken = $_ENV['SUREPASS_TOKEN'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3NDg3NzAwMywianRpIjoiZGUxNGRmYmUtMmE3NC00NGQ5LWIxMzEtZGZhMWNlODBhMTc2IiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LnJvaGl0XzAzNDVAc3VyZXBhc3MuaW8iLCJuYmYiOjE3NzQ4NzcwMDMsImV4cCI6MjQwNTU5NzAwMywiZW1haWwiOiJyb2hpdF8wMzQ1QHN1cmVwYXNzLmlvIiwidGVuYW50X2lkIjoibWFpbiIsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ1c2VyIl19fQ.UC3ebDNZdNjyUxDhez-7IIACaf224xpA5rl8DaQRFpU';
    $surepassUrl   = rtrim($_ENV['SUREPASS_BASE_URL'] ?? 'https://kyc-api.surepass.app/api/v1', '/') . '/rc/rc-full';

    $ch = curl_init($surepassUrl);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_HTTPHEADER     => [
            'Content-Type: application/json',
            "Authorization: Bearer $surepassToken",
        ],
        CURLOPT_POSTFIELDS     => json_encode(['id_number' => $rc_number]),
        CURLOPT_TIMEOUT        => 15,
    ]);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlErr  = curl_error($ch);
    curl_close($ch);

    if ($curlErr) {
        echo json_encode(['status' => 'error', 'message' => 'cURL error: ' . $curlErr]);
        exit;
    }
    if ($httpCode !== 200) {
        echo json_encode(['status' => 'error', 'message' => "Surepass API returned HTTP $httpCode. Check token or RC number."]);
        exit;
    }

    $rcJson = json_decode($response, true);
    if (!isset($rcJson['data'])) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid response from Surepass: ' . $response]);
        exit;
    }

    echo json_encode(['status' => 'success', 'data' => $rcJson['data']]);
    exit;
}

// ──────────────────────────────────────────────
// ACTION: add_vehicle
// ──────────────────────────────────────────────
if ($action === 'add_vehicle') {
    $partner_id = $_POST['partner_id'] ?? '';
    if (empty($partner_id)) {
        echo json_encode(['status' => 'error', 'message' => 'partner_id required']);
        exit;
    }

    // ── 0. Check Wallet Balance ──
    $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
    $stmt->execute([$partner_id]);
    $wallet = $stmt->fetch();
    $fee = 7.50;
    if (!$wallet || $wallet['balance'] < $fee) {
        echo json_encode(['status' => 'error', 'message' => "Insufficient wallet balance. Deposit at least ₹$fee to register a vehicle."]);
        exit;
    }

    $rc_number               = strtoupper(trim($_POST['rc_number'] ?? ''));
    $owner_name              = $_POST['owner_name'] ?? '';
    $maker_description       = $_POST['maker_description'] ?? '';
    $maker_model             = $_POST['maker_model'] ?? '';
    $body_type               = $_POST['body_type'] ?? '';
    $fuel_type               = $_POST['fuel_type'] ?? '';
    $color                   = $_POST['color'] ?? '';
    $seat_capacity           = $_POST['seat_capacity'] ?? '';
    $vehicle_category_desc   = $_POST['vehicle_category_desc'] ?? '';
    $registration_date       = $_POST['registration_date'] ?? '';
    $fit_up_to               = $_POST['fit_up_to'] ?? '';
    $insurance_company       = $_POST['insurance_company'] ?? '';
    $insurance_policy_number = $_POST['insurance_policy_number'] ?? '';
    $insurance_upto          = $_POST['insurance_upto'] ?? '';
    $norms_type              = $_POST['norms_type'] ?? '';
    $rc_status               = $_POST['rc_status'] ?? '';
    $permit_type             = $_POST['permit_type'] ?? '';
    $permit_valid_upto       = $_POST['permit_valid_upto'] ?? '';
    $raw_rc_data             = $_POST['raw_rc_data'] ?? '{}';

    // ── Pre-Check Compliance ──
    $compliance = isVehicleCompliant([
        'fit_up_to' => $fit_up_to,
        'insurance_upto' => $insurance_upto,
        'permit_valid_upto' => $permit_valid_upto,
        'permit_type' => $permit_type
    ]);
    if (!$compliance['status']) {
        echo json_encode(['status' => 'error', 'message' => $compliance['msg']]);
        exit;
    }

    // ── Handle image uploads ──
    $uploadDir   = __DIR__ . '/../../uploads/vehicles/';
    if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);

    $front_image = '';
    $back_image  = '';

    foreach (['front_image' => &$front_image, 'back_image' => &$back_image] as $field => &$targetVar) {
        if (isset($_FILES[$field]) && $_FILES[$field]['error'] === UPLOAD_ERR_OK) {
            $ext      = strtolower(pathinfo($_FILES[$field]['name'], PATHINFO_EXTENSION));
            $allowed  = ['jpg', 'jpeg', 'png', 'webp'];
            if (!in_array($ext, $allowed)) continue;
            $filename = $rc_number . '_' . $field . '_' . time() . '.' . $ext;
            if (move_uploaded_file($_FILES[$field]['tmp_name'], $uploadDir . $filename)) {
                $targetVar = 'uploads/vehicles/' . $filename;
            }
        }
    }

    // ── Check for duplicate RC ──
    try {
        $chkStmt = $pdo->prepare("SELECT id FROM partner_vehicles WHERE partner_id = ? AND rc_number = ?");
        $chkStmt->execute([$partner_id, $rc_number]);
        if ($chkStmt->fetch()) {
            echo json_encode(['status' => 'error', 'message' => 'This vehicle is already registered under your account.']);
            exit;
        }

        $stmt = $pdo->prepare("INSERT INTO partner_vehicles 
            (partner_id, rc_number, owner_name, maker_description, maker_model, body_type, fuel_type, color,
             seat_capacity, vehicle_category_desc, registration_date, fit_up_to, insurance_company,
             insurance_policy_number, insurance_upto, norms_type, rc_status, permit_type, permit_valid_upto,
             raw_rc_data, front_image, back_image)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

        $stmt->execute([
            $partner_id, $rc_number, $owner_name, $maker_description, $maker_model, $body_type, $fuel_type, $color,
            $seat_capacity, $vehicle_category_desc, $registration_date, $fit_up_to, $insurance_company,
            $insurance_policy_number, $insurance_upto, $norms_type, $rc_status, $permit_type, $permit_valid_upto,
            $raw_rc_data, $front_image, $back_image
        ]);

        // ── Deduct Fee ──
        updateWallet($pdo, $partner_id, $fee, 'Debit', "Registration fee for Vehicle: $maker_model ($rc_number)");

        echo json_encode(['status' => 'success', 'message' => "Vehicle added successfully and ₹$fee deducted from wallet.", 'vehicle_id' => $pdo->lastInsertId()]);
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'DB Error: ' . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────
// ACTION: get_vehicles
// ──────────────────────────────────────────────
if ($action === 'get_vehicles') {
    $partner_id = $_GET['partner_id'] ?? '';
    if (empty($partner_id)) {
        echo json_encode(['status' => 'error', 'message' => 'partner_id required']);
        exit;
    }
    try {
        $stmt = $pdo->prepare("SELECT * FROM partner_vehicles WHERE partner_id = ? ORDER BY id DESC");
        $stmt->execute([$partner_id]);
        $vehicles = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Auto-Deactivate expired vehicles
        foreach ($vehicles as &$v) {
            if ($v['status'] === 'Active') {
                $compliance = isVehicleCompliant($v);
                if (!$compliance['status']) {
                    $pdo->prepare("UPDATE partner_vehicles SET status = 'Inactive' WHERE id = ?")
                        ->execute([$v['id']]);
                    $v['status'] = 'Inactive';
                }
            }
        }
        echo json_encode(['status' => 'success', 'vehicles' => $vehicles]);
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'DB Error: ' . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────
// ACTION: delete_vehicle
// ──────────────────────────────────────────────
if ($action === 'delete_vehicle') {
    $raw  = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data)) $data = $_POST;

    $vehicle_id = $data['vehicle_id'] ?? '';
    $partner_id = $data['partner_id'] ?? '';
    if (empty($vehicle_id) || empty($partner_id)) {
        echo json_encode(['status' => 'error', 'message' => 'vehicle_id and partner_id required']);
        exit;
    }
    try {
        $stmt = $pdo->prepare("DELETE FROM partner_vehicles WHERE id = ? AND partner_id = ?");
        $stmt->execute([$vehicle_id, $partner_id]);
        echo json_encode(['status' => 'success', 'message' => 'Vehicle removed.']);
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'DB Error: ' . $e->getMessage()]);
    }
    exit;
}

// ──────────────────────────────────────────────
// ACTION: renew_vehicle
// ──────────────────────────────────────────────
if ($action === 'renew_vehicle') {
    $raw  = file_get_contents("php://input");
    $data = json_decode($raw, true);
    if (!is_array($data)) $data = $_POST;

    $vehicle_id = $data['vehicle_id'] ?? '';
    $partner_id = $data['partner_id'] ?? '';
    
    if (empty($vehicle_id) || empty($partner_id)) {
        echo json_encode(['status' => 'error', 'message' => 'vehicle_id and partner_id required']);
        exit;
    }

    try {
        // 1. Get current vehicle details
        $stmt = $pdo->prepare("SELECT * FROM partner_vehicles WHERE id = ? AND partner_id = ?");
        $stmt->execute([$vehicle_id, $partner_id]);
        $vehicle = $stmt->fetch();
        if (!$vehicle) throw new Exception("Vehicle not found");

        // 2. Check Wallet for ₹7.50
        $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
        $stmt->execute([$partner_id]);
        $wallet = $stmt->fetch();
        $fee = 7.50;
        if (!$wallet || $wallet['balance'] < $fee) throw new Exception("Insufficient balance to renew. Fee: ₹$fee");

        // 3. Re-fetch from Surepass
        $rc_number = $vehicle['rc_number'];
        $surepassToken = $_ENV['SUREPASS_TOKEN'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3NDg3NzAwMywianRpIjoiZGUxNGRmYmUtMmE3NC00NGQ5LWIxMzEtZGZhMWNlODBhMTc2IiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LnJvaGl0XzAzNDVAc3VyZXBhc3MuaW8iLCJuYmYiOjE3NzQ4NzcwMDMsImV4cCI6MjQwNTU5NzAwMywiZW1haWwiOiJyb2hpdF8wMzQ1QHN1cmVwYXNzLmlvIiwidGVuYW50X2lkIjoibWFpbiIsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ1c2VyIl19fQ.UC3ebDNZdNjyUxDhez-7IIACaf224xpA5rl8DaQRFpU';
        $surepassUrl   = rtrim($_ENV['SUREPASS_BASE_URL'] ?? 'https://kyc-api.surepass.app/api/v1', '/') . '/rc/rc-full';

        $ch = curl_init($surepassUrl);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST           => true,
            CURLOPT_HTTPHEADER     => ['Content-Type: application/json', "Authorization: Bearer $surepassToken"],
            CURLOPT_POSTFIELDS     => json_encode(['id_number' => $rc_number]),
            CURLOPT_TIMEOUT        => 15,
        ]);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpCode !== 200) throw new Exception("Document re-fetch failed. Please try later.");
        $rcJson = json_decode($response, true);
        $newData = $rcJson['data'];

        // 4. Validate New Compliance
        $compliance = isVehicleCompliant($newData);
        if (!$compliance['status']) throw new Exception("Renewal failed: " . $compliance['msg']);

        // 5. Update DB & Wallet
        $pdo->beginTransaction();
        $stmt = $pdo->prepare("UPDATE partner_vehicles SET 
            fit_up_to = ?, insurance_upto = ?, permit_valid_upto = ?, 
            rc_status = ?, status = 'Active', raw_rc_data = ?
            WHERE id = ?");
        $stmt->execute([
            $newData['fit_up_to'], $newData['insurance_upto'], $newData['permit_valid_upto'],
            $newData['rc_status'] ?? 'Active', json_encode($newData), $vehicle_id
        ]);

        updateWallet($pdo, $partner_id, $fee, 'Debit', "Document renewal fee for Vehicle: " . $vehicle['maker_model'] . " ($rc_number)");
        $pdo->commit();

        echo json_encode(['status' => 'success', 'message' => 'Vehicle documents renewed and updated successfully.']);
    } catch (Exception $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
    exit;
}

echo json_encode(['status' => 'error', 'message' => 'Invalid action']);
