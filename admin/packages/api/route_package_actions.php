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
    $city_id = $_POST['city_id'] ?? null;
    $drop_city_id = $_POST['drop_city_id'] ?? null;
    $prices = $_POST['prices'] ?? [];

    if (!$city_id || !$drop_city_id) {
        echo json_encode(['success' => false, 'message' => 'Please select Pickup and Drop cities.']);
        exit;
    }

    if ($city_id === $drop_city_id) {
        echo json_encode(['success' => false, 'message' => 'Pickup City and Drop City cannot be the same.']);
        exit;
    }

    $brand_id = 1; // Default brand
    $trip_type_id = getOneWayId($pdo);

    $include_toll = $_POST['include_toll'] ?? 'Excluded';
    $include_tax = $_POST['include_tax'] ?? 'Excluded';
    $include_driver_allowance = $_POST['include_driver_allowance'] ?? 'Excluded';
    $include_night_charges = $_POST['include_night_charges'] ?? 'Excluded';
    $include_parking = $_POST['include_parking'] ?? 'Excluded';
    $description = $_POST['description'] ?? null;
    $terms_conditions = $_POST['terms_conditions'] ?? null;

    // Fetch active car types to cross-reference and get their names
    $carTypes = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active'")->fetchAll();

    $pdo->beginTransaction();
    try {
        $savedCount = 0;
        foreach ($carTypes as $carType) {
            $type_id = $carType['id'];
            $name = $carType['name'];

            $pricing = $prices[$type_id] ?? null;
            $enabled = isset($pricing['enabled']) && $pricing['enabled'] == '1';

            // Check if record already exists for this route and car type
            $checkStmt = $pdo->prepare("SELECT id FROM cars WHERE city_id = ? AND drop_city_id = ? AND type_id = ? AND trip_type_id = ?");
            $checkStmt->execute([$city_id, $drop_city_id, $type_id, $trip_type_id]);
            $existingRow = $checkStmt->fetch();

            if ($enabled) {
                $base_fare = $pricing['base_fare'] ?? null;
                $min_km = $pricing['min_km'] ?? null;
                $extra_km_price = $pricing['extra_km_price'] ?? null;
                $display_extra_km_price = $pricing['display_extra_km_price'] ?? null;

                if ($base_fare === '' || $min_km === '' || $extra_km_price === '' || $base_fare === null || $min_km === null || $extra_km_price === null) {
                    // Skip if fields are empty
                    continue;
                }

                $params = [
                    'type_id' => $type_id,
                    'brand_id' => $brand_id,
                    'name' => $name,
                    'trip_type_id' => $trip_type_id,
                    'city_id' => $city_id,
                    'drop_city_id' => $drop_city_id,
                    'base_fare' => $base_fare,
                    'min_km' => $min_km,
                    'extra_km_price' => $extra_km_price,
                    'display_extra_km_price' => $display_extra_km_price,
                    'include_toll' => $include_toll,
                    'include_tax' => $include_tax,
                    'include_driver_allowance' => $include_driver_allowance,
                    'include_night_charges' => $include_night_charges,
                    'include_parking' => $include_parking,
                    'description' => $description,
                    'terms_conditions' => $terms_conditions,
                ];

                if ($existingRow) {
                $sql = "UPDATE cars SET 
                    brand_id = :brand_id,
                    name = :name,
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
                
                $update_params = [
                    'brand_id' => $brand_id,
                    'name' => $name,
                    'base_fare' => $base_fare,
                    'min_km' => $min_km,
                    'extra_km_price' => $extra_km_price,
                    'display_extra_km_price' => $display_extra_km_price,
                    'include_toll' => $include_toll,
                    'include_tax' => $include_tax,
                    'include_driver_allowance' => $include_driver_allowance,
                    'include_night_charges' => $include_night_charges,
                    'include_parking' => $include_parking,
                    'description' => $description,
                    'terms_conditions' => $terms_conditions,
                    'id' => $existingRow['id']
                ];
                
                $stmt = $pdo->prepare($sql);
                $stmt->execute($update_params);
            } else {
                $sql = "INSERT INTO cars (type_id, brand_id, name, trip_type_id, city_id, drop_city_id, base_fare, min_km, extra_km_price, display_extra_km_price, include_toll, include_tax, include_driver_allowance, include_night_charges, include_parking, description, terms_conditions, status)
                        VALUES (:type_id, :brand_id, :name, :trip_type_id, :city_id, :drop_city_id, :base_fare, :min_km, :extra_km_price, :display_extra_km_price, :include_toll, :include_tax, :include_driver_allowance, :include_night_charges, :include_parking, :description, :terms_conditions, 'Active')";
                
                $stmt = $pdo->prepare($sql);
                $stmt->execute($params);
            }
            $savedCount++;
            } else {
                // If it is unchecked / disabled, delete the existing package row for this route & car type
                if ($existingRow) {
                    $delStmt = $pdo->prepare("DELETE FROM cars WHERE id = ?");
                    $delStmt->execute([$existingRow['id']]);
                }
            }
        }

        if ($savedCount === 0) {
            $pdo->rollBack();
            echo json_encode(['success' => false, 'message' => 'Please fill details for at least one enabled car type.']);
            exit;
        }

        $pdo->commit();
        $msg = $id ? "Route packages updated successfully." : "Route packages created successfully.";
        echo json_encode(['success' => true, 'message' => $msg]);
    } catch (PDOException $e) {
        $pdo->rollBack();
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
