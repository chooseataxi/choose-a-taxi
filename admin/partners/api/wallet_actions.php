<?php
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

$action = $_POST['action'] ?? '';
$partner_id = $_POST['partner_id'] ?? 0;

if (!$partner_id) {
    echo json_encode(['success' => false, 'message' => 'Partner ID is required']);
    exit;
}

try {
    switch ($action) {
        case 'manage_wallet':
            $amount = floatval($_POST['amount'] ?? 0);
            $type = $_POST['type'] ?? ''; // 'Credit' or 'Debit'
            $description = $_POST['description'] ?? 'Admin Adjustment';

            if ($amount <= 0) throw new Exception("Amount must be greater than zero.");
            if (!in_array($type, ['Credit', 'Debit'])) throw new Exception("Invalid transaction type.");

            $pdo->beginTransaction();

            // 1. Ensure wallet exists
            $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
            $stmt->execute([$partner_id]);

            // 2. Update balance
            if ($type === 'Credit') {
                $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
            } else {
                // Fetch current balance to ensure no negative if needed, but app allows it for lookup fees etc.
                $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance - ? WHERE partner_id = ?");
            }
            $stmt->execute([$amount, $partner_id]);

            // 3. Log transaction
            $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, description) VALUES (?, ?, ?, 'Admin', ?)");
            $stmt->execute([$partner_id, $type, $amount, $description]);

            $pdo->commit();
            echo json_encode(['success' => true, 'message' => "Wallet " . ($type === 'Credit' ? 'credited' : 'debited') . " successfully!"]);
            break;

        default:
            throw new Exception("Invalid action.");
    }
} catch (Exception $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
