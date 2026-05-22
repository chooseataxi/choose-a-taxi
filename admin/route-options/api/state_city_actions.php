<?php
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

try {
    // 1. Create Tables if they don't exist
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS states (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            country VARCHAR(255) DEFAULT 'India',
            status ENUM('Active', 'Inactive') DEFAULT 'Active',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    ");

    $pdo->exec("
        CREATE TABLE IF NOT EXISTS cities (
            id INT AUTO_INCREMENT PRIMARY KEY,
            state_id INT NOT NULL,
            name VARCHAR(255) NOT NULL,
            status ENUM('Active', 'Inactive') DEFAULT 'Active',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (state_id) REFERENCES states(id) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    ");

    $action = $_POST['action'] ?? '';

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        switch ($action) {
            // --- STATE ACTIONS ---
            case 'add_state':
                $name = trim($_POST['name'] ?? '');
                $country = trim($_POST['country'] ?? 'India');
                
                if (empty($name)) {
                    echo json_encode(['success' => false, 'message' => 'State name is required']);
                    exit;
                }

                $stmt = $pdo->prepare("INSERT INTO states (name, country) VALUES (?, ?)");
                if ($stmt->execute([$name, $country])) {
                    echo json_encode(['success' => true, 'message' => 'State added successfully']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to add state']);
                }
                break;

            case 'update_state':
                $id = (int)($_POST['id'] ?? 0);
                $name = trim($_POST['name'] ?? '');
                $country = trim($_POST['country'] ?? 'India');

                if (!$id || empty($name)) {
                    echo json_encode(['success' => false, 'message' => 'Invalid parameters']);
                    exit;
                }

                $stmt = $pdo->prepare("UPDATE states SET name = ?, country = ? WHERE id = ?");
                if ($stmt->execute([$name, $country, $id])) {
                    echo json_encode(['success' => true, 'message' => 'State updated successfully']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to update state']);
                }
                break;

            case 'delete_state':
                $id = (int)($_POST['id'] ?? 0);
                if (!$id) {
                    echo json_encode(['success' => false, 'message' => 'Invalid state ID']);
                    exit;
                }

                $stmt = $pdo->prepare("DELETE FROM states WHERE id = ?");
                if ($stmt->execute([$id])) {
                    echo json_encode(['success' => true, 'message' => 'State deleted successfully']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to delete state']);
                }
                break;

            case 'toggle_state_status':
                $id = (int)($_POST['id'] ?? 0);
                if (!$id) {
                    echo json_encode(['success' => false, 'message' => 'Invalid state ID']);
                    exit;
                }

                $stmt = $pdo->prepare("UPDATE states SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ?");
                if ($stmt->execute([$id])) {
                    echo json_encode(['success' => true, 'message' => 'Status updated']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to update status']);
                }
                break;

            // --- CITY ACTIONS ---
            case 'add_city':
                $name = trim($_POST['name'] ?? '');
                $state_id = (int)($_POST['state_id'] ?? 0);
                
                if (empty($name) || !$state_id) {
                    echo json_encode(['success' => false, 'message' => 'City name and state are required']);
                    exit;
                }

                $stmt = $pdo->prepare("INSERT INTO cities (name, state_id) VALUES (?, ?)");
                if ($stmt->execute([$name, $state_id])) {
                    echo json_encode(['success' => true, 'message' => 'City added successfully']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to add city']);
                }
                break;

            case 'update_city':
                $id = (int)($_POST['id'] ?? 0);
                $name = trim($_POST['name'] ?? '');
                $state_id = (int)($_POST['state_id'] ?? 0);

                if (!$id || empty($name) || !$state_id) {
                    echo json_encode(['success' => false, 'message' => 'Invalid parameters']);
                    exit;
                }

                $stmt = $pdo->prepare("UPDATE cities SET name = ?, state_id = ? WHERE id = ?");
                if ($stmt->execute([$name, $state_id, $id])) {
                    echo json_encode(['success' => true, 'message' => 'City updated successfully']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to update city']);
                }
                break;

            case 'delete_city':
                $id = (int)($_POST['id'] ?? 0);
                if (!$id) {
                    echo json_encode(['success' => false, 'message' => 'Invalid city ID']);
                    exit;
                }

                $stmt = $pdo->prepare("DELETE FROM cities WHERE id = ?");
                if ($stmt->execute([$id])) {
                    echo json_encode(['success' => true, 'message' => 'City deleted successfully']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to delete city']);
                }
                break;

            case 'toggle_city_status':
                $id = (int)($_POST['id'] ?? 0);
                if (!$id) {
                    echo json_encode(['success' => false, 'message' => 'Invalid city ID']);
                    exit;
                }

                $stmt = $pdo->prepare("UPDATE cities SET status = IF(status='Active', 'Inactive', 'Active') WHERE id = ?");
                if ($stmt->execute([$id])) {
                    echo json_encode(['success' => true, 'message' => 'Status updated']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Failed to update status']);
                }
                break;

            default:
                echo json_encode(['success' => false, 'message' => 'Unknown action']);
        }
    }
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}
