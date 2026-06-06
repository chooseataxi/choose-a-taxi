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
            $city_id = $_POST['city_id'] ?? null;
            $name = $_POST['name'] ?? ''; // e.g. 2hrs/40kms
            $prices = $_POST['prices'] ?? [];

            if (!$city_id || empty($name)) {
                echo json_encode(['success' => false, 'message' => 'Please fill all required fields.']);
                exit;
            }

            $brand_id                 = 1;
            $include_toll             = $_POST['include_toll'] ?? 'Excluded';
            $include_tax              = $_POST['include_tax'] ?? 'Excluded';
            $include_driver_allowance = $_POST['include_driver_allowance'] ?? 'Excluded';
            $include_night_charges    = $_POST['include_night_charges'] ?? 'Excluded';
            $include_parking          = $_POST['include_parking'] ?? 'Excluded';
            
            $description              = $_POST['description'] ?? '';
            $terms_conditions         = $_POST['terms_conditions'] ?? '';
            $status                   = $_POST['status'] ?? 'Active';

            // Fetch active car types
            $carTypes = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active'")->fetchAll();

            $pdo->beginTransaction();
            try {
                $savedCount = 0;
                foreach ($carTypes as $carType) {
                    $type_id = $carType['id'];

                    $pricing = $prices[$type_id] ?? null;
                    $enabled = isset($pricing['enabled']) && $pricing['enabled'] == '1';

                    // Check if record already exists for this city + package name + car type + trip type (Local)
                    $checkStmt = $pdo->prepare("SELECT id FROM cars WHERE city_id = ? AND name = ? AND type_id = ? AND trip_type_id = ?");
                    $checkStmt->execute([$city_id, $name, $type_id, $localId]);
                    $existingRow = $checkStmt->fetch();

                    if ($enabled) {
                        $base_fare = $pricing['base_fare'] ?? null;
                        $min_km = $pricing['min_km'] ?? null;
                        $extra_km_price = $pricing['extra_km_price'] ?? null;
                        $display_extra_km_price = trim($pricing['display_extra_km_price'] ?? '');

                        if ($base_fare === '' || $min_km === '' || $extra_km_price === '' || $base_fare === null || $min_km === null || $extra_km_price === null) {
                            continue;
                        }

                        if ($existingRow) {
                            $upStmt = $pdo->prepare("UPDATE cars SET
                                base_fare = ?, min_km = ?, extra_km_price = ?, display_extra_km_price = ?,
                                include_toll = ?, include_tax = ?, include_driver_allowance = ?,
                                include_night_charges = ?, include_parking = ?, description = ?,
                                terms_conditions = ?, status = ?
                                WHERE id = ?");
                            $upStmt->execute([
                                $base_fare, $min_km, $extra_km_price, $display_extra_km_price,
                                $include_toll, $include_tax, $include_driver_allowance,
                                $include_night_charges, $include_parking, $description,
                                $terms_conditions, $status, $existingRow['id']
                            ]);
                        } else {
                            $insStmt = $pdo->prepare("INSERT INTO cars
                                (type_id, city_id, brand_id, trip_type_id, name, base_fare, min_km,
                                extra_km_price, display_extra_km_price, include_toll, include_tax,
                                include_driver_allowance, include_night_charges,
                                include_parking, description, terms_conditions, status)
                                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                            $insStmt->execute([
                                $type_id, $city_id, $brand_id, $localId, $name, $base_fare, $min_km,
                                $extra_km_price, $display_extra_km_price, $include_toll, $include_tax,
                                $include_driver_allowance, $include_night_charges,
                                $include_parking, $description, $terms_conditions, $status
                            ]);
                        }
                        $savedCount++;
                    } else {
                        // Unchecked: delete package record for this city + name + car type
                        if ($existingRow) {
                            $delStmt = $pdo->prepare("DELETE FROM cars WHERE id = ?");
                            $delStmt->execute([$existingRow['id']]);
                        }
                    }
                }

                if ($savedCount === 0) {
                    $pdo->rollBack();
                    echo json_encode(['success' => false, 'message' => 'Please configure pricing for at least one enabled car type.']);
                    exit;
                }

                $pdo->commit();
                $message = $id ? "Packages updated successfully!" : "Packages added successfully!";
                echo json_encode(['success' => true, 'message' => $message]);
            } catch (Exception $e) {
                $pdo->rollBack();
                echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
            }
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
