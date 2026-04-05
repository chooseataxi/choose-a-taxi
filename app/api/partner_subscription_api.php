<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../vendor/autoload.php';

header('Content-Type: application/json');

$action = $_GET['action'] ?? '';

try {
    switch ($action) {
        case 'get_plans':
            $stmt = $pdo->query("SELECT id, name, price, duration_value, duration_unit, terms 
                                FROM partner_subscription_plans 
                                WHERE status = 'active' 
                                ORDER BY price ASC");
            $plans = $stmt->fetchAll();

            echo json_encode([
                'status' => 'success',
                'plans' => $plans
            ]);
            break;

        default:
            throw new Exception("Invalid action");
    }
} catch (Exception $e) {
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
?>
