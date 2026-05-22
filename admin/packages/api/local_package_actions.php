<?php
require_once __DIR__ . '/../../../includes/db.php';
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

$action = $_POST['action'] ?? '';

// ── DB Bootstrap: safely add new columns if they don't exist ──────────────────
try {
    $pdo->query("SELECT display_extra_km_price FROM cars LIMIT 1");
} catch (PDOException $e) {
    try { $pdo->exec("ALTER TABLE cars ADD COLUMN display_extra_km_price VARCHAR(100) NULL AFTER extra_km_price"); } catch(PDOException $ex) {}
}
try {
    $pdo->query("SELECT terms_conditions FROM cars LIMIT 1");
} catch (PDOException $e) {
    try { $pdo->exec("ALTER TABLE cars ADD COLUMN terms_conditions LONGTEXT NULL"); } catch(PDOException $ex) {}
}
try {
    $pdo->query("SELECT city_id FROM cars LIMIT 1");
} catch (PDOException $e) {
    try { $pdo->exec("ALTER TABLE cars ADD COLUMN city_id INT NULL AFTER type_id"); } catch(PDOException $ex) {}
}

// Helper to get Local/Hourly Trip ID
function getLocalId($pdo) {
    $stmt = $pdo->prepare("SELECT id FROM trip_types WHERE name = 'Local / Rental' LIMIT 1");
    $stmt->execute();
    $res = $stmt->fetch();
    if ($res) {
        return $res['id'];
    } else {
        // Create if not exists
        try {
            $stmt = $pdo->prepare("INSERT INTO trip_types (name, status) VALUES ('Local / Rental', 'Active')");
            $stmt->execute();
        } catch (PDOException $e) {
            $stmt = $pdo->prepare("INSERT INTO trip_types (name) VALUES ('Local / Rental')");
            $stmt->execute();
        }
        return $pdo->lastInsertId();
    }
}

try {
    $localId = getLocalId($pdo);
    if (!$localId) throw new Exception("Local / Rental trip type could not be created or found.");

    switch ($action) {
        case 'save':
            $id = $_POST['id'] ?? null;
            $type_id = $_POST['type_id'];
            $city_id = $_POST['city_id'];
            $name = $_POST['name'] ?? 'Local Package'; // e.g., 2hrs/40kms

            $brand_id              = 1;
            $base_fare             = $_POST['base_fare'];
            $min_km                = $_POST['min_km'] ?? 0;
            $extra_km_price        = $_POST['extra_km_price'] ?? 0;
            $display_extra_km_price = trim($_POST['display_extra_km_price'] ?? '');
            
            // Reusing existing columns for other features, or defaults
            $include_toll          = $_POST['include_toll'] ?? 'Excluded';
            $include_tax           = $_POST['include_tax'] ?? 'Excluded';
            $include_driver_allowance = $_POST['include_driver_allowance'] ?? 'Excluded';
            $include_night_charges = $_POST['include_night_charges'] ?? 'Excluded';
            $include_parking       = $_POST['include_parking'] ?? 'Excluded';
            
            $description           = $_POST['description'] ?? '';
            $terms_conditions      = $_POST['terms_conditions'] ?? '';
            $status                = $_POST['status'] ?? 'Active';

            if ($id) {
                $stmt = $pdo->prepare("UPDATE cars SET
                    type_id = ?, city_id = ?, brand_id = ?, name = ?, base_fare = ?, min_km = ?,
                    extra_km_price = ?, display_extra_km_price = ?,
                    include_toll = ?, include_tax = ?,
                    include_driver_allowance = ?, include_night_charges = ?,
                    include_parking = ?, description = ?, terms_conditions = ?, status = ?
                    WHERE id = ? AND trip_type_id = ?");
                $stmt->execute([
                    $type_id, $city_id, $brand_id, $name, $base_fare, $min_km,
                    $extra_km_price, $display_extra_km_price,
                    $include_toll, $include_tax,
                    $include_driver_allowance, $include_night_charges,
                    $include_parking, $description, $terms_conditions, $status,
                    $id, $localId
                ]);
                $message = "Package updated successfully!";
            } else {
                $stmt = $pdo->prepare("INSERT INTO cars
                    (type_id, city_id, brand_id, trip_type_id, name, base_fare, min_km,
                    extra_km_price, display_extra_km_price, include_toll, include_tax,
                    include_driver_allowance, include_night_charges,
                    include_parking, description, terms_conditions, status)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->execute([
                    $type_id, $city_id, $brand_id, $localId, $name, $base_fare, $min_km,
                    $extra_km_price, $display_extra_km_price, $include_toll, $include_tax,
                    $include_driver_allowance, $include_night_charges,
                    $include_parking, $description, $terms_conditions, $status
                ]);
                $message = "Package added successfully!";
            }
            echo json_encode(['success' => true, 'message' => $message]);
            break;

        case 'delete':
            $id = $_POST['id'];
            $stmt = $pdo->prepare("DELETE FROM cars WHERE id = ? AND trip_type_id = ?");
            $stmt->execute([$id, $localId]);
            echo json_encode(['success' => true, 'message' => 'Package deleted successfully!']);
            break;

        case 'toggle_status':
            $id = $_POST['id'];
            $stmt = $pdo->prepare("UPDATE cars SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ? AND trip_type_id = ?");
            $stmt->execute([$id, $localId]);
            echo json_encode(['success' => true, 'message' => 'Status updated successfully!']);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
