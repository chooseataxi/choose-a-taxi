<?php
/**
 * Wallet Helper
 * Shared function to update partner wallet and log transactions
 */

if (!function_exists('updateWallet')) {
    function updateWallet($pdo, $partner_id, $amount, $type, $source, $source_id, $description) {
        $isNested = $pdo->inTransaction();
        if (!$isNested) $pdo->beginTransaction();
        try {
            // 1. Ensure wallet exists
            $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
            $stmt->execute([$partner_id]);

            // 2. Update balance
            if ($type === 'Credit') {
                $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
            } else {
                $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance - ? WHERE partner_id = ?");
            }
            $stmt->execute([$amount, $partner_id]);

            // 3. Log transaction
            $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->execute([$partner_id, $type, $amount, $source, $source_id, $description]);

            if (!$isNested) $pdo->commit();
            return true;
        } catch (Exception $e) {
            if (!$isNested) $pdo->rollBack();
            return false;
        }
    }
}
