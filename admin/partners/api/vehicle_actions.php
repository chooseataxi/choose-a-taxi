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

        // ──────────────────────────────────────────────
        // ACTION: lookup_rc  — hit Surepass API
        // ──────────────────────────────────────────────
        case 'lookup_rc':
            $rc_number = strtoupper(trim($_POST['rc_number'] ?? ''));
            if (empty($rc_number)) {
                throw new Exception("RC number is required.");
            }

            $surepassToken = $_ENV['SUREPASS_TOKEN'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTc3OTcxODcxNCwianRpIjoiYjI2OTU0YjEtODE3OS00MWRkLTg2ZGMtNmYxZTgzNzdmNDE4IiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LnJvaGl0XzAzNDVAc3VyZXBhc3MuaW8iLCJuYmYiOjE3Nzk3MTg3MTQsImV4cCI6MjA5NTA3ODcxNCwiZW1haWwiOiJyb2hpdF8wMzQ1QHN1cmVwYXNzLmlvIiwidGVuYW50X2lkIjoibWFpbiIsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ1c2VyIl19fQ.8ZYs7N7vRhAD50h5x7WDMYcMWu2ctZTjUst833FclMA';
            $surepassUrl   = rtrim($_ENV['SUREPASS_BASE_URL'] ?? 'https://kyc-api.surepass.app/api/v1', '/') . '/rc/rc-v2';

            $ch = curl_init($surepassUrl);
            curl_setopt_array($ch, [
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_POST           => true,
                CURLOPT_HTTPHEADER     => [
                    'Content-Type: application/json',
                    "Authorization: Bearer $surepassToken",
                ],
                CURLOPT_POSTFIELDS     => json_encode([
                    'id_number' => $rc_number,
                    'enrich'    => false
                ]),
                CURLOPT_TIMEOUT        => 15,
            ]);
            $response = curl_exec($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            $curlErr  = curl_error($ch);
            curl_close($ch);

            if ($curlErr) {
                throw new Exception('cURL error: ' . $curlErr);
            }
            if ($httpCode !== 200) {
                throw new Exception("Surepass API returned HTTP $httpCode. Check token or RC number.");
            }

            $rcJson = json_decode($response, true);
            if (!isset($rcJson['data'])) {
                throw new Exception('Invalid response from Surepass: ' . $response);
            }

            // Map Surepass fields to our form fields
            $data = $rcJson['data'];
            $mapped = [
                'rc_number'             => $data['rc_number'] ?? '',
                'owner_name'            => $data['owner_name'] ?? '',
                'maker_description'     => $data['maker_description'] ?? '',
                'maker_model'           => $data['maker_model'] ?? '',
                'body_type'             => $data['body_type'] ?? '',
                'fuel_type'             => $data['fuel_type'] ?? '',
                'color'                 => $data['color'] ?? '',
                'seat_capacity'         => $data['seat_capacity'] ?? '',
                'vehicle_category_desc' => $data['vehicle_category_description'] ?? '',
                'registration_date'     => $data['registration_date'] ?? '',
                'fit_up_to'             => $data['fit_up_to'] ?? '',
                'insurance_company'     => $data['insurance_company'] ?? '',
                'insurance_policy_number' => $data['insurance_policy_number'] ?? '',
                'insurance_upto'        => $data['insurance_upto'] ?? '',
                'norms_type'            => $data['norms_type'] ?? '',
                'rc_status'             => $data['rc_status'] ?? '',
                'permit_type'           => $data['permit_type'] ?? '',
                'permit_valid_upto'     => $data['permit_valid_upto'] ?? '',
            ];

            echo json_encode(['success' => true, 'data' => $mapped]);
            break;

        // ──────────────────────────────────────────────
        // ACTION: add  — full vehicle insert
        // ──────────────────────────────────────────────
        case 'add':
            $partner_id = intval($_POST['partner_id'] ?? 0);
            $rc_number = strtoupper(trim($_POST['rc_number'] ?? ''));
            $owner_name = trim($_POST['owner_name'] ?? '');
            $maker_description = trim($_POST['maker_description'] ?? '');
            $maker_model = trim($_POST['maker_model'] ?? '');
            $body_type = trim($_POST['body_type'] ?? '');
            $fuel_type = trim($_POST['fuel_type'] ?? '');
            $color = trim($_POST['color'] ?? '');
            $seat_capacity = trim($_POST['seat_capacity'] ?? '');
            $vehicle_category_desc = trim($_POST['vehicle_category_desc'] ?? '');
            $registration_date = trim($_POST['registration_date'] ?? '');
            $fit_up_to = trim($_POST['fit_up_to'] ?? '');
            $insurance_company = trim($_POST['insurance_company'] ?? '');
            $insurance_policy_number = trim($_POST['insurance_policy_number'] ?? '');
            $insurance_upto = trim($_POST['insurance_upto'] ?? '');
            $norms_type = trim($_POST['norms_type'] ?? '');
            $rc_status = trim($_POST['rc_status'] ?? '');
            $permit_type = trim($_POST['permit_type'] ?? '');
            $permit_valid_upto = trim($_POST['permit_valid_upto'] ?? '');
            $raw_rc_data = $_POST['raw_rc_data'] ?? '{}';
            $status = trim($_POST['status'] ?? 'Active');

            if (empty($partner_id) || empty($rc_number)) {
                throw new Exception("Partner ID and RC Number are required.");
            }

            // Check duplicate RC
            $check = $pdo->prepare("SELECT id FROM partner_vehicles WHERE rc_number = ? AND partner_id = ?");
            $check->execute([$rc_number, $partner_id]);
            if ($check->fetch()) {
                throw new Exception("A vehicle with this RC number already exists for this partner.");
            }

            // Handle image uploads
            $uploadDir = __DIR__ . '/../../../uploads/vehicles/';
            if (!is_dir($uploadDir)) {
                mkdir($uploadDir, 0755, true);
            }

            $front_image = '';
            $back_image = '';

            foreach (['front_image' => &$front_image, 'back_image' => &$back_image] as $field => &$targetVar) {
                if (isset($_FILES[$field]) && $_FILES[$field]['error'] === UPLOAD_ERR_OK) {
                    $ext = strtolower(pathinfo($_FILES[$field]['name'], PATHINFO_EXTENSION));
                    $allowed = ['jpg', 'jpeg', 'png', 'webp'];
                    if (in_array($ext, $allowed)) {
                        $filename = $rc_number . '_' . $field . '_' . time() . '.' . $ext;
                        if (move_uploaded_file($_FILES[$field]['tmp_name'], $uploadDir . $filename)) {
                            $targetVar = 'uploads/vehicles/' . $filename;
                        }
                    }
                }
            }

            $stmt = $pdo->prepare("INSERT INTO partner_vehicles 
                (partner_id, rc_number, owner_name, maker_description, maker_model, body_type, fuel_type, color,
                 seat_capacity, vehicle_category_desc, registration_date, fit_up_to, insurance_company,
                 insurance_policy_number, insurance_upto, norms_type, rc_status, permit_type, permit_valid_upto,
                 raw_rc_data, front_image, back_image, status)
                VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            $stmt->execute([
                $partner_id, $rc_number, $owner_name, $maker_description, $maker_model, $body_type, $fuel_type, $color,
                $seat_capacity, $vehicle_category_desc, $registration_date, $fit_up_to, $insurance_company,
                $insurance_policy_number, $insurance_upto, $norms_type, $rc_status, $permit_type, $permit_valid_upto,
                $raw_rc_data, $front_image, $back_image, $status
            ]);

            echo json_encode(['success' => true, 'message' => 'Vehicle added successfully!', 'vehicle_id' => $pdo->lastInsertId()]);
            break;

        // ──────────────────────────────────────────────
        // ACTION: delete  — remove vehicle
        // ──────────────────────────────────────────────
        case 'delete':
            $id = intval($_POST['id'] ?? 0);
            if (empty($id)) throw new Exception("Vehicle ID missing.");

            $stmt = $pdo->prepare("SELECT front_image, back_image FROM partner_vehicles WHERE id = ?");
            $stmt->execute([$id]);
            $vehicle = $stmt->fetch();

            if ($vehicle) {
                if (!empty($vehicle['front_image'])) {
                    $frontPath = __DIR__ . '/../../../' . $vehicle['front_image'];
                    if (file_exists($frontPath)) {
                        @unlink($frontPath);
                    }
                }
                if (!empty($vehicle['back_image'])) {
                    $backPath = __DIR__ . '/../../../' . $vehicle['back_image'];
                    if (file_exists($backPath)) {
                        @unlink($backPath);
                    }
                }
            }

            $stmt = $pdo->prepare("DELETE FROM partner_vehicles WHERE id = ?");
            $stmt->execute([$id]);

            echo json_encode(['success' => true, 'message' => 'Vehicle removed successfully!']);
            break;

        default:
            throw new Exception("Invalid action.");
    }

} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
