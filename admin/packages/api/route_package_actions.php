<?php
require_once __DIR__ . '/../../auth_check.php';
require_once __DIR__ . '/../../../includes/db.php';

header('Content-Type: application/json');

// ── DB Bootstrap: safely add drop_city_id column if it doesn't exist ──────────────────
try {
    $pdo->query("SELECT drop_city_id FROM cars LIMIT 1");
} catch (PDOException $e) {
    try { $pdo->exec("ALTER TABLE cars ADD COLUMN drop_city_id INT NULL AFTER city_id"); } catch(PDOException $ex) {}
}

// Helper to get One Way Trip ID
function getOneWayId($pdo) {
    $stmt = $pdo->prepare("SELECT id FROM trip_types WHERE name LIKE '%One Way%' LIMIT 1");
    $stmt->execute();
    $res = $stmt->fetch();
    if ($res) {
        return $res['id'];
    } else {
        // Fallback create if missing
        try {
            $stmt = $pdo->prepare("INSERT INTO trip_types (name, status) VALUES ('One Way', 'Active')");
            $stmt->execute();
        } catch (PDOException $e) {
            $stmt = $pdo->prepare("INSERT INTO trip_types (name) VALUES ('One Way')");
            $stmt->execute();
        }
        return $pdo->lastInsertId();
    }
}

$action = $_POST['action'] ?? '';

if ($action === 'save') {
    $id = $_POST['id'] ?? null;
    $type_id = $_POST['type_id'] ?? null;
    $city_id = $_POST['city_id'] ?? null;
    $drop_city_id = $_POST['drop_city_id'] ?? null;
    $base_fare = $_POST['base_fare'] ?? null;
    $min_km = $_POST['min_km'] ?? null;
    $extra_km_price = $_POST['extra_km_price'] ?? null;
    
    if (!$type_id || !$city_id || !$drop_city_id || !$base_fare || !$min_km || !$extra_km_price) {
        echo json_encode(['success' => false, 'message' => 'Please fill all required fields.']);
        exit;
    }

    $trip_type_id = getOneWayId($pdo);

    $params = [
        'type_id' => $type_id,
        'trip_type_id' => $trip_type_id,
        'city_id' => $city_id,
        'drop_city_id' => $drop_city_id,
        'base_fare' => $base_fare,
        'min_km' => $min_km,
        'extra_km_price' => $extra_km_price,
        'display_extra_km_price' => $_POST['display_extra_km_price'] ?? null,
        'include_toll' => $_POST['include_toll'] ?? 'Excluded',
        'include_tax' => $_POST['include_tax'] ?? 'Excluded',
        'include_driver_allowance' => $_POST['include_driver_allowance'] ?? 'Excluded',
        'include_night_charges' => $_POST['include_night_charges'] ?? 'Excluded',
        'include_parking' => $_POST['include_parking'] ?? 'Excluded',
        'description' => $_POST['description'] ?? null,
        'terms_conditions' => $_POST['terms_conditions'] ?? null,
    ];

    if ($id) {
        $sql = "UPDATE cars SET 
            type_id = :type_id,
            city_id = :city_id,
            drop_city_id = :drop_city_id,
            base_fare = :base_fare,
            min_km = :min_km,
            extra_km_price = :extra_km_price,
            display_extra_km_price = :display_extra_km_price,
            include_toll = :include_toll,
            include_tax = :include_tax,
            include_driver_allowance = :include_driver_allowance,
            include_night_charges = :include_night_charges,
            include_parking = :include_parking,
            description = :description,
            terms_conditions = :terms_conditions
            WHERE id = :id";
        $params['id'] = $id;
        $msg = "Route package updated successfully.";
    } else {
        $sql = "INSERT INTO cars (type_id, trip_type_id, city_id, drop_city_id, base_fare, min_km, extra_km_price, display_extra_km_price, include_toll, include_tax, include_driver_allowance, include_night_charges, include_parking, description, terms_conditions, status)
                VALUES (:type_id, :trip_type_id, :city_id, :drop_city_id, :base_fare, :min_km, :extra_km_price, :display_extra_km_price, :include_toll, :include_tax, :include_driver_allowance, :include_night_charges, :include_parking, :description, :terms_conditions, 'Active')";
        $msg = "Route package created successfully.";
    }

    try {
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        echo json_encode(['success' => true, 'message' => $msg]);
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
    }
}
elseif ($action === 'delete') {
    $id = $_POST['id'] ?? null;
    if ($id) {
        $stmt = $pdo->prepare("DELETE FROM cars WHERE id = ?");
        $stmt->execute([$id]);
        echo json_encode(['success' => true, 'message' => 'Package deleted.']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid ID.']);
    }
}
elseif ($action === 'toggle_status') {
    $id = $_POST['id'] ?? null;
    if ($id) {
        $stmt = $pdo->prepare("UPDATE cars SET status = IF(status = 'Active', 'Inactive', 'Active') WHERE id = ?");
        $stmt->execute([$id]);
        echo json_encode(['success' => true, 'message' => 'Status updated.']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid ID.']);
    }
}
else {
    echo json_encode(['success' => false, 'message' => 'Invalid action.']);
}
