<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Withdrawal Requests";

// Handle Actions (Approve/Reject)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $requestId = $_POST['request_id'] ?? '';
    $action = $_POST['action']; // 'approve' or 'reject'
    $adminNote = $_POST['admin_note'] ?? '';
    $transId = $_POST['transaction_id'] ?? '';

    try {
        $pdo->beginTransaction();

        // 1. Fetch the request
        $stmt = $pdo->prepare("SELECT * FROM partner_withdrawals WHERE id = ? AND status = 'Processing'");
        $stmt->execute([$requestId]);
        $req = $stmt->fetch();

        if (!$req) throw new Exception("Request not found or already processed.");

        if ($action === 'approve') {
            // 2. Update request status to Success
            $stmt = $pdo->prepare("UPDATE partner_withdrawals SET status = 'Success', admin_note = ?, transaction_id = ? WHERE id = ?");
            $stmt->execute([$adminNote, $transId, $requestId]);

            // No wallet update needed here because it was already debited during request.

        } else if ($action === 'reject') {
            // 2. Update status to Rejected
            $stmt = $pdo->prepare("UPDATE partner_withdrawals SET status = 'Rejected', admin_note = ? WHERE id = ?");
            $stmt->execute([$adminNote, $requestId]);

            // 3. REFUND the partner wallet
            $partnerId = $req['partner_id'];
            $amount = $req['amount'];

            $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
            $stmt->execute([$amount, $partnerId]);

            // Log Transaction (Refund)
            $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) 
                                   VALUES (?, 'Credit', ?, 'Withdrawal', ?, ?)");
            $stmt->execute([$partnerId, $amount, $requestId, "Refund for Rejected Withdrawal Request #$requestId"]);
        }

        $pdo->commit();
        $successMsg = "Withdrawal " . ($action === 'approve' ? 'Approved' : 'Rejected') . " successfully.";
    } catch (Exception $e) {
        $pdo->rollBack();
        $errorMsg = $e->getMessage();
    }
}

// Fetch Requests
try {
    $stmt = $pdo->query("
        SELECT w.*, p.full_name as partner_name, p.mobile as partner_mobile,
               bd.holder_name, bd.bank_name, bd.account_number, bd.ifsc_code
        FROM partner_withdrawals w
        JOIN partners p ON w.partner_id = p.id
        LEFT JOIN partner_bank_details bd ON w.partner_id = bd.partner_id
        ORDER BY w.id DESC
    ");
    $requests = $stmt->fetchAll();
} catch (Exception $e) {
    $requests = [];
    $errorMsg = "Error fetching requests: " . $e->getMessage();
}
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-hand-holding-usd me-2"></i>Withdrawal Requests</h1>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <?php if (isset($successMsg)): ?>
            <div class="alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                <i class="fas fa-check-circle me-2"></i> <?= $successMsg ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <?php if (isset($errorMsg)): ?>
            <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> <?= $errorMsg ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <div class="card shadow-sm border-0 rounded-4">
            <div class="card-body">
                <div class="table-responsive">
                    <table id="requestsTable" class="table table-hover align-middle">
                        <thead class="bg-light">
                            <tr>
                                <th>ID</th>
                                <th>Partner</th>
                                <th>Bank Details</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($requests as $req): ?>
                                <tr>
                                    <td class="fw-bold text-muted">#<?= $req['id'] ?></td>
                                    <td>
                                        <div class="fw-bold text-dark"><?= htmlspecialchars($req['partner_name']) ?></div>
                                        <div class="small text-muted">+91 <?= htmlspecialchars($req['partner_mobile']) ?></div>
                                    </td>
                                    <td>
                                        <?php if ($req['account_number']): ?>
                                            <div class="small">
                                                <strong><?= htmlspecialchars($req['holder_name']) ?></strong><br>
                                                <?= htmlspecialchars($req['bank_name']) ?><br>
                                                A/C: <?= htmlspecialchars($req['account_number']) ?><br>
                                                IFSC: <?= htmlspecialchars($req['ifsc_code']) ?>
                                            </div>
                                        <?php else: ?>
                                            <span class="text-danger small">No Bank Details</span>
                                        <?php endif; ?>
                                    </td>
                                    <td>
                                        <div class="fs-5 fw-bold text-dark">₹<?= number_format($req['amount'], 2) ?></div>
                                    </td>
                                    <td>
                                        <?php 
                                        $badge = 'bg-warning';
                                        if ($req['status'] === 'Success' || $req['status'] === 'Paid') $badge = 'bg-success';
                                        if ($req['status'] === 'Rejected') $badge = 'bg-danger';
                                        ?>
                                        <span class="badge <?= $badge ?> rounded-pill px-3 py-2"><?= $req['status'] ?></span>
                                        <?php if ($req['transaction_id']): ?>
                                            <div class="small text-muted mt-1">TXN: <?= htmlspecialchars($req['transaction_id']) ?></div>
                                        <?php endif; ?>
                                    </td>
                                    <td class="text-center">
                                        <?php if ($req['status'] === 'Processing'): ?>
                                            <button class="btn btn-success btn-sm rounded-pill px-3 me-1" onclick="handleWithdrawal(<?= $req['id'] ?>, 'approve')">Mark Success</button>
                                            <button class="btn btn-danger btn-sm rounded-pill px-3" onclick="handleWithdrawal(<?= $req['id'] ?>, 'reject')">Reject</button>
                                        <?php else: ?>
                                            <span class="text-muted small"><?= $req['created_at'] ?></span>
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
                <?php if (empty($requests)): ?>
                    <div class="text-center py-5">
                        <i class="fas fa-inbox fa-3x text-light mb-3"></i>
                        <h5 class="text-muted">No withdrawal requests found</h5>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<form id="actionForm" method="POST">
    <input type="hidden" name="request_id" id="formRequestId">
    <input type="hidden" name="action" id="formAction">
    <input type="hidden" name="admin_note" id="formAdminNote">
    <input type="hidden" name="transaction_id" id="formTransId">
</form>

<script>
function handleWithdrawal(id, action) {
    if (action === 'approve') {
        Swal.fire({
            title: 'Approve Withdrawal?',
            text: 'Please enter the Bank Transaction ID for record:',
            input: 'text',
            inputLabel: 'Transaction ID',
            inputPlaceholder: 'e.g. UTR12345678',
            showCancelButton: true,
            confirmButtonColor: '#28a745',
            confirmButtonText: 'Approve & Mark Paid',
            inputValidator: (value) => {
                if (!value) return 'You need to provide a Transaction ID!';
            }
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('formRequestId').value = id;
                document.getElementById('formAction').value = 'approve';
                document.getElementById('formTransId').value = result.value;
                document.getElementById('actionForm').submit();
            }
        });
    } else {
        Swal.fire({
            title: 'Reject Withdrawal?',
            text: 'This will refund the amount back to partner wallet. Reason:',
            input: 'text',
            inputPlaceholder: 'Reason for rejection',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            confirmButtonText: 'Yes, reject it!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('formRequestId').value = id;
                document.getElementById('formAction').value = 'reject';
                document.getElementById('formAdminNote').value = result.value;
                document.getElementById('actionForm').submit();
            }
        });
    }
}
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
