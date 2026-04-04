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

    // ── Call Surepass RC Full API (token from .env → $_ENV) ──
    $surepassToken = $_ENV['SUREPASS_TOKEN'] ?? '';
    $surepassUrl   = rtrim($_ENV['SUREPASS_BASE_URL'] ?? 'https://kyc-api.surepass.io/api/v1', '/') . '/rc/rc-full';

    if (empty($surepassToken)) {
        echo json_encode(['status' => 'error', 'message' => 'Surepass token not configured. Set SUREPASS_TOKEN in .env']);
        exit;
    }

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

        echo json_encode(['status' => 'success', 'message' => 'Vehicle added successfully!', 'vehicle_id' => $pdo->lastInsertId()]);
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

echo json_encode(['status' => 'error', 'message' => 'Invalid action']);
