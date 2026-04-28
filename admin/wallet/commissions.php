<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Commission Requests";

// Handle Actions (Approve/Reject)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $requestId = $_POST['request_id'] ?? '';
    $action = $_POST['action']; // 'approve' or 'reject'
    $adminNote = $_POST['admin_note'] ?? '';

    try {
        $pdo->beginTransaction();

        // 1. Fetch the request
        $stmt = $pdo->prepare("SELECT * FROM commission_requests WHERE id = ? AND status = 'Processing'");
        $stmt->execute([$requestId]);
        $req = $stmt->fetch();

        if (!$req) throw new Exception("Request not found or already processed.");

        if ($action === 'approve') {
            // 2. Update request status
            $stmt = $pdo->prepare("UPDATE commission_requests SET status = 'Approved', admin_note = ? WHERE id = ?");
            $stmt->execute([$adminNote, $requestId]);

            // 3. Credit Partner Wallet
            $partnerId = $req['partner_id'];
            $amount = $req['final_amount'];
            $bookingId = $req['booking_id'];

            // Ensure wallet exists
            $stmt = $pdo->prepare("INSERT IGNORE INTO partner_wallet (partner_id, balance) VALUES (?, 0)");
            $stmt->execute([$partnerId]);

            // Credit balance
            $stmt = $pdo->prepare("UPDATE partner_wallet SET balance = balance + ? WHERE partner_id = ?");
            $stmt->execute([$amount, $partnerId]);

            // Log Transaction
            $stmt = $pdo->prepare("INSERT INTO partner_transactions (partner_id, type, amount, source, source_id, description) 
                                   VALUES (?, 'Credit', ?, 'Commission', ?, ?)");
            $stmt->execute([$partnerId, $amount, $requestId, "Approved Commission for Booking ID-$bookingId (After 3% Fee)"]);

        } else if ($action === 'reject') {
            $stmt = $pdo->prepare("UPDATE commission_requests SET status = 'Rejected', admin_note = ? WHERE id = ?");
            $stmt->execute([$adminNote, $requestId]);
        }

        $pdo->commit();
        $successMsg = "Request " . ($action === 'approve' ? 'Approved' : 'Rejected') . " successfully.";
    } catch (Exception $e) {
        $pdo->rollBack();
        $errorMsg = $e->getMessage();
    }
}

// Fetch Requests
try {
    $stmt = $pdo->query("
        SELECT cr.*, p.full_name as partner_name, p.mobile as partner_mobile,
               pb.pickup_location, pb.drop_location, pb.start_date
        FROM commission_requests cr
        JOIN partners p ON cr.partner_id = p.id
        JOIN partner_bookings pb ON cr.booking_id = pb.id
        ORDER BY cr.id DESC
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
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-money-bill-wave me-2"></i>Commission Requests</h1>
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
                                <th>Trip Details</th>
                                <th>Amounts</th>
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
                                        <div class="small">
                                            <strong>Booking ID-<?= $req['booking_id'] ?></strong><br>
                                            <span class="text-muted"><?= htmlspecialchars($req['pickup_location']) ?> &rarr; <?= htmlspecialchars($req['drop_location']) ?></span><br>
                                            <span class="text-muted"><?= $req['start_date'] ?></span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="small">
                                            Raw: <span class="fw-bold">₹<?= number_format($req['raw_amount'], 2) ?></span><br>
                                            Fee (3%): <span class="text-danger">₹<?= number_format($req['service_charge'], 2) ?></span><br>
                                            <strong>Final: <span class="text-success">₹<?= number_format($req['final_amount'], 2) ?></span></strong>
                                        </div>
                                    </td>
                                    <td>
                                        <?php 
                                        $badge = 'bg-warning';
                                        if ($req['status'] === 'Approved') $badge = 'bg-success';
                                        if ($req['status'] === 'Rejected') $badge = 'bg-danger';
                                        ?>
                                        <span class="badge <?= $badge ?> rounded-pill px-3 py-2"><?= $req['status'] ?></span>
                                    </td>
                                    <td class="text-center">
                                        <?php if ($req['status'] === 'Processing'): ?>
                                            <button class="btn btn-success btn-sm rounded-pill px-3 me-1" onclick="handleRequest(<?= $req['id'] ?>, 'approve')">Approve</button>
                                            <button class="btn btn-danger btn-sm rounded-pill px-3" onclick="handleRequest(<?= $req['id'] ?>, 'reject')">Reject</button>
                                        <?php else: ?>
                                            <span class="text-muted small"><?= $req['updated_at'] ?></span>
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
                        <h5 class="text-muted">No commission requests found</h5>
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
</form>

<script>
function handleRequest(id, action) {
    const title = action === 'approve' ? 'Approve Commission?' : 'Reject Commission?';
    const text = action === 'approve' ? 'This will credit the partner wallet.' : 'This request will be cancelled.';
    
    Swal.fire({
        title: title,
        text: text,
        input: 'text',
        inputPlaceholder: 'Add a note (optional)',
        showCancelButton: true,
        confirmButtonColor: action === 'approve' ? '#28a745' : '#dc3545',
        confirmButtonText: 'Yes, ' + action + ' it!'
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById('formRequestId').value = id;
            document.getElementById('formAction').value = action;
            document.getElementById('formAdminNote').value = result.value;
            document.getElementById('actionForm').submit();
        }
    });
}
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
