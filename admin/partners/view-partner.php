<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? 0;

try {
    $stmt = $pdo->prepare("SELECT * FROM partners WHERE id = ?");
    $stmt->execute([$id]);
    $partner = $stmt->fetch();

    if (!$partner) {
        throw new Exception("Partner not found or deleted.");
    }

    // Fetch Wallet Balance
    $stmt = $pdo->prepare("SELECT balance FROM partner_wallet WHERE partner_id = ?");
    $stmt->execute([$id]);
    $wallet = $stmt->fetch();
    $balance = $wallet ? $wallet['balance'] : 0.00;

    // Fetch Recent Transactions
    $stmt = $pdo->prepare("SELECT * FROM partner_transactions WHERE partner_id = ? ORDER BY id DESC LIMIT 10");
    $stmt->execute([$id]);
    $transactions = $stmt->fetchAll();

    // Fetch Added Drivers
    $stmt = $pdo->prepare("SELECT * FROM drivers WHERE partner_id = ? ORDER BY id DESC");
    $stmt->execute([$id]);
    $drivers = $stmt->fetchAll();

    // Fetch Added Vehicles
    $stmt = $pdo->prepare("SELECT * FROM partner_vehicles WHERE partner_id = ? ORDER BY id DESC");
    $stmt->execute([$id]);
    $vehicles = $stmt->fetchAll();

} catch (Exception $e) {
    die("<div class='container mt-5'><div class='alert alert-danger'>".$e->getMessage()."</div><a href='partner-management.php' class='btn btn-primary'>Go Back</a></div>");
}

$page_title = "Partner Details - " . ($partner['full_name'] ?? 'N/A');
?>
<style>
    .img-preview { transition: transform .3s ease; cursor: zoom-in; }
    .img-preview:hover { transform: scale(1.02); }
    .btn-xs { padding: 0.1rem 0.4rem; font-size: 0.75rem; }
    .document-card h6 { color: #555; }
    .wallet-card { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; border: none; }
    .transaction-table th { font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: #888; background: #f8f9fa; border: none; }
    .transaction-table td { font-size: 13px; vertical-align: middle; border-bottom: 1px solid #eee; }
    .badge-soft-success { background-color: rgba(40, 167, 69, 0.1); color: #28a745; }
    .badge-soft-danger { background-color: rgba(220, 53, 69, 0.1); color: #dc3545; }
</style>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-id-card me-2 text-primary"></i>Partner Profile</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="partner-management.php" class="btn btn-outline-dark btn-sm px-4 shadow-sm rounded-pill">
                    <i class="fas fa-arrow-left me-1"></i> Back to List
                </a>
                <a href="edit-partner.php?id=<?= $partner['id'] ?>" class="btn btn-primary btn-sm px-4 shadow-sm rounded-pill ms-2">
                    <i class="fas fa-edit me-1"></i> Edit Partner
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row g-4">
            <!-- Left Column: Personal Information & Status -->
            <div class="col-lg-4">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
                    <div class="card-body p-0">
                        <div class="bg-primary text-white p-4 text-center">
                            <div class="position-relative d-inline-block">
                                <div class="rounded-circle shadow border border-4 border-white overflow-hidden mb-3 mx-auto" style="width: 120px; height: 120px; background: #fff;">
                                    <?php if (!empty($partner['selfie_link'])): ?>
                                        <img src="../../uploads/partners/<?= $partner['selfie_link'] ?>" style="width:100%; height:100%; object-fit:cover;">
                                    <?php else: ?>
                                        <div class="h-100 d-flex align-items-center justify-content-center bg-gray-200">
                                            <i class="fas fa-user fa-3x text-muted"></i>
                                        </div>
                                    <?php endif; ?>
                                </div>
                                <span class="badge position-absolute bottom-0 end-0 rounded-circle p-2 <?= $partner['status'] === 'Active' ? 'bg-success' : 'bg-danger' ?> border border-white border-2" title="<?= $partner['status'] ?>" style="width: 25px; height: 25px;"></span>
                            </div>
                            <h4 class="fw-bold mb-1"><?= htmlspecialchars($partner['full_name'] ?? 'N/A') ?></h4>
                            <p class="mb-0 opacity-75 small">Partner ID: #<?= $partner['id'] ?></p>
                        </div>
                        <div class="p-4">
                            <div class="mb-4">
                                <label class="small text-muted text-uppercase fw-bold mb-1 d-block">Verification Status</label>
                                <?php 
                                $vStatus = $partner['manual_verification_status'];
                                $vClass = 'bg-warning text-dark';
                                if ($vStatus === 'Approved') $vClass = 'bg-success text-white';
                                if ($vStatus === 'Rejected') $vClass = 'bg-danger text-white';
                                ?>
                                <span class="badge <?= $vClass ?> rounded-pill px-3 py-2 w-100 fs-6">
                                    <i class="fas <?= $vStatus==='Approved' ? 'fa-check-circle' : 'fa-clock' ?> me-1"></i> <?= $vStatus ?>
                                </span>
                            </div>

                            <div class="info-list">
                                <div class="mb-3">
                                    <label class="small text-muted text-uppercase fw-bold mb-0 d-block">Mobile Number</label>
                                    <div class="fw-bold text-dark fs-5">+91 <?= htmlspecialchars($partner['mobile']) ?></div>
                                </div>
                                <div class="mb-3">
                                    <label class="small text-muted text-uppercase fw-bold mb-0 d-block">Email Address</label>
                                    <div class="fw-semibold text-dark"><?= htmlspecialchars($partner['email'] ?: 'Not Provided') ?></div>
                                </div>
                                <div class="mb-3">
                                    <label class="small text-muted text-uppercase fw-bold mb-0 d-block">Account Status</label>
                                    <div class="fw-semibold <?= $partner['status'] === 'Active' ? 'text-success' : 'text-danger' ?>">
                                        <i class="fas <?= $partner['status'] === 'Active' ? 'fa-toggle-on' : 'fa-toggle-off' ?> me-1"></i> <?= $partner['status'] ?>
                                    </div>
                                </div>
                                <div class="mb-0">
                                    <label class="small text-muted text-uppercase fw-bold mb-0 d-block">Registered On</label>
                                    <div class="fw-semibold text-dark"><?= date('d M Y, h:i A', strtotime($partner['created_at'] ?? 'now')) ?></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Wallet Management -->
            <div class="col-lg-8">
                <div class="row g-4">
                    <!-- Wallet Summary Card -->
                    <div class="col-md-5">
                        <div class="card wallet-card shadow-sm rounded-4 position-relative overflow-hidden">
                            <div class="card-body p-4 position-relative" style="z-index: 1;">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h6 class="text-uppercase fw-bold opacity-75 mb-0" style="letter-spacing: 1px;">Partner Wallet</h6>
                                    <i class="fas fa-wallet fa-2x opacity-25"></i>
                                </div>
                                <h1 class="fw-bold mb-1">₹<?= number_format($balance, 2) ?></h1>
                                <p class="small opacity-75 mb-4">Available Balance</p>
                                
                                <div class="d-flex gap-2">
                                    <button class="btn btn-light btn-sm flex-fill fw-bold rounded-pill" data-bs-toggle="modal" data-bs-target="#walletModal" onclick="setWalletAction('Credit')">
                                        <i class="fas fa-plus-circle me-1 text-success"></i> Add Funds
                                    </button>
                                    <button class="btn btn-light btn-sm flex-fill fw-bold rounded-pill" data-bs-toggle="modal" data-bs-target="#walletModal" onclick="setWalletAction('Debit')">
                                        <i class="fas fa-minus-circle me-1 text-danger"></i> Deduct
                                    </button>
                                </div>
                            </div>
                            <!-- Background Decoration -->
                            <div class="position-absolute" style="right: -20px; bottom: -20px; opacity: 0.1;">
                                <i class="fas fa-coins fa-8x"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Transaction History -->
                    <div class="col-md-7">
                        <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-bold"><i class="fas fa-history me-2 text-primary"></i>Recent Transactions</h6>
                                <a href="#" class="text-primary small text-decoration-none fw-bold">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive border-0" style="max-height: 200px; overflow-y: auto;">
                                    <table class="table transaction-table mb-0" style="table-layout: fixed;">
                                        <thead>
                                            <tr>
                                                <th class="ps-3" style="width: 80px;">Type</th>
                                                <th style="width: 90px;">Amount</th>
                                                <th>Description</th>
                                                <th class="pe-3 text-end" style="width: 90px;">Date</th>
                                            </tr>
                                        </thead>
                                        <tbody class="border-top-0">
                                            <?php if (empty($transactions)): ?>
                                                <tr><td colspan="4" class="text-center py-4 text-muted">No transactions yet</td></tr>
                                            <?php else: ?>
                                                <?php foreach ($transactions as $tx): ?>
                                                    <tr>
                                                        <td class="ps-3">
                                                            <span class="badge rounded-pill <?= $tx['type'] === 'Credit' ? 'badge-soft-success' : 'badge-soft-danger' ?> px-2 py-1" style="font-size: 10px;">
                                                                <i class="fas fa-<?= $tx['type'] === 'Credit' ? 'arrow-down' : 'arrow-up' ?>"></i> <?= $tx['type'] ?>
                                                            </span>
                                                        </td>
                                                        <td class="fw-bold <?= $tx['type'] === 'Credit' ? 'text-success' : 'text-danger' ?>" style="font-size: 12px;">
                                                            <?= $tx['type'] === 'Credit' ? '+' : '-' ?>₹<?= number_format($tx['amount'], 2) ?>
                                                        </td>
                                                        <td style="line-height: 1.2;">
                                                            <div class="text-truncate small fw-semibold text-dark" title="<?= $tx['description'] ?>">
                                                                <?= htmlspecialchars($tx['description']) ?>
                                                            </div>
                                                            <span class="text-muted text-xs" style="font-size: 10px;"><?= $tx['source'] ?></span>
                                                        </td>
                                                        <td class="pe-3 text-end text-muted" style="font-size: 11px;">
                                                            <?= date('d M, y', strtotime($tx['created_at'])) ?>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Asset Section: Drivers & Vehicles -->
            <div class="col-lg-12">
                <div class="row g-4">
                    <!-- Added Drivers List -->
                    <div class="col-md-6">
                        <div class="card shadow-sm border-0 rounded-4 overflow-hidden h-100">
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-bold"><i class="fas fa-users-cog me-2 text-primary"></i>Registered Drivers (<?= count($drivers) ?>)</h6>
                                <span class="badge bg-light text-primary border rounded-pill">Total: <?= count($drivers) ?></span>
                            </div>
                            <div class="card-body p-0">
                                <div class="list-group list-group-flush" style="max-height: 250px; overflow-y: auto;">
                                    <?php if (empty($drivers)): ?>
                                        <div class="text-center py-5 text-muted">
                                            <i class="fas fa-user-slash fa-2x opacity-25 mb-2"></i>
                                            <p class="small mb-0">No drivers registered yet</p>
                                        </div>
                                    <?php else: ?>
                                        <?php foreach ($drivers as $dr): ?>
                                            <div class="list-group-item px-4 py-3 border-0 border-bottom">
                                                <div class="d-flex align-items-center">
                                                    <div class="me-3 position-relative">
                                                        <img src="<?= htmlspecialchars($dr['profile_image_path'] ?: '../../assets/driver-icon.png') ?>" 
                                                             class="rounded-circle border" style="width: 45px; height: 45px; object-fit: cover;">
                                                        <span class="position-absolute bottom-0 end-0 bg-<?= $dr['status'] === 'Active' ? 'success' : 'danger' ?> border border-white rounded-circle" style="width: 10px; height: 10px;"></span>
                                                    </div>
                                                    <div class="flex-fill">
                                                        <div class="h6 mb-0 fw-bold small"><?= htmlspecialchars($dr['full_name']) ?></div>
                                                        <div class="text-muted text-xs">DL: <?= htmlspecialchars($dr['license_number']) ?></div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="small fw-bold text-dark"><?= htmlspecialchars($dr['phone']) ?></div>
                                                        <span class="badge bg-<?= $dr['status'] === 'Active' ? 'success' : 'secondary' ?>-light text-<?= $dr['status'] === 'Active' ? 'success' : 'secondary' ?> py-1 px-2" style="font-size: 9px;"><?= $dr['status'] ?></span>
                                                    </div>
                                                </div>
                                            </div>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Added Vehicles List -->
                    <div class="col-md-6">
                        <div class="card shadow-sm border-0 rounded-4 overflow-hidden h-100">
                            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                <h6 class="mb-0 fw-bold"><i class="fas fa-car me-2 text-primary"></i>Registered Vehicles (<?= count($vehicles) ?>)</h6>
                                <span class="badge bg-light text-primary border rounded-pill">Total: <?= count($vehicles) ?></span>
                            </div>
                            <div class="card-body p-0">
                                <div class="list-group list-group-flush" style="max-height: 250px; overflow-y: auto;">
                                    <?php if (empty($vehicles)): ?>
                                        <div class="text-center py-5 text-muted">
                                            <i class="fas fa-car-crash fa-2x opacity-25 mb-2"></i>
                                            <p class="small mb-0">No vehicles registered yet</p>
                                        </div>
                                    <?php else: ?>
                                        <?php foreach ($vehicles as $vh): ?>
                                            <div class="list-group-item px-4 py-3 border-0 border-bottom">
                                                <div class="d-flex align-items-center">
                                                    <div class="me-3">
                                                        <div class="rounded border bg-light overflow-hidden shadow-sm" style="width: 55px; height: 35px;">
                                                            <img src="../../<?= htmlspecialchars($vh['front_image']) ?>" 
                                                                 class="w-100 h-100" style="object-fit: cover;"
                                                                 onerror="this.src='../../assets/car_types/default.png'">
                                                        </div>
                                                    </div>
                                                    <div class="flex-fill">
                                                        <div class="h6 mb-0 fw-bold small"><?= htmlspecialchars($vh['maker_model']) ?></div>
                                                        <div class="text-muted text-xs"><?= htmlspecialchars($vh['rc_number']) ?></div>
                                                    </div>
                                                    <div class="text-end">
                                                        <div class="small fw-bold text-dark"><?= htmlspecialchars($vh['color'] ?: 'N/A') ?></div>
                                                        <span class="badge bg-<?= $vh['status'] === 'Active' ? 'success' : 'secondary' ?>-light text-<?= $vh['status'] === 'Active' ? 'success' : 'secondary' ?> py-1 px-2" style="font-size: 9px;"><?= $vh['status'] ?></span>
                                                    </div>
                                                </div>
                                            </div>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Full Width Bottom Row: Documents -->
            <div class="col-lg-12">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-white border-bottom py-3 d-flex align-items-center justify-content-between">
                        <h5 class="card-title mb-0 fw-bold"><i class="fas fa-file-alt me-2 text-warning"></i>KYC Verification Documents</h5>
                        <div class="d-flex gap-2">
                             <?php 
                                $vStatus = $partner['manual_verification_status'];
                                if ($vStatus !== 'Approved'): 
                            ?>
                                <button class="btn btn-success btn-sm px-4 rounded-pill shadow-sm" onclick="approvePartner()">
                                    <i class="fas fa-check-circle me-1"></i> Verify & Approve Now
                                </button>
                            <?php endif; ?>
                            <button class="btn btn-outline-danger btn-sm px-4 rounded-pill delete-btn" data-id="<?= $partner['id'] ?>">
                                <i class="fas fa-trash-alt me-1"></i> Delete Partner
                            </button>
                        </div>
                    </div>
                    <div class="card-body p-4 bg-light">
                        <div class="row g-4">
                            <!-- Aadhaar Front -->
                            <div class="col-md-4">
                                <div class="document-card border-0 shadow-sm rounded-4 p-3 h-100 bg-white">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <label class="small text-muted fw-bold text-uppercase">Aadhar Front</label>
                                        <?php if (!empty($partner['aadhaar_front_link'])): ?>
                                            <a href="../../uploads/partners/<?= $partner['aadhaar_front_link'] ?>" target="_blank" class="text-primary small"><i class="fas fa-external-link-alt"></i></a>
                                        <?php endif; ?>
                                    </div>
                                    <?php if (!empty($partner['aadhaar_front_link'])): ?>
                                        <div class="ratio ratio-16x9 rounded-3 overflow-hidden bg-light">
                                            <img src="../../uploads/partners/<?= $partner['aadhaar_front_link'] ?>" style="width:100%; height:100%; object-fit:contain;" class="img-preview">
                                        </div>
                                    <?php else: ?>
                                        <div class="text-center py-4 border border-dashed rounded-3">
                                            <i class="fas fa-image fa-2x text-light mb-1"></i>
                                            <div class="small text-danger">Pending</div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <!-- Aadhaar Back -->
                            <div class="col-md-4">
                                <div class="document-card border-0 shadow-sm rounded-4 p-3 h-100 bg-white">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <label class="small text-muted fw-bold text-uppercase">Aadhar Back</label>
                                        <?php if (!empty($partner['aadhaar_back_link'])): ?>
                                            <a href="../../uploads/partners/<?= $partner['aadhaar_back_link'] ?>" target="_blank" class="text-primary small"><i class="fas fa-external-link-alt"></i></a>
                                        <?php endif; ?>
                                    </div>
                                    <?php if (!empty($partner['aadhaar_back_link'])): ?>
                                        <div class="ratio ratio-16x9 rounded-3 overflow-hidden bg-light">
                                            <img src="../../uploads/partners/<?= $partner['aadhaar_back_link'] ?>" style="width:100%; height:100%; object-fit:contain;" class="img-preview">
                                        </div>
                                    <?php else: ?>
                                        <div class="text-center py-4 border border-dashed rounded-3">
                                            <i class="fas fa-image fa-2x text-light mb-1"></i>
                                            <div class="small text-danger">Pending</div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <!-- Live Selfie -->
                            <div class="col-md-4">
                                <div class="document-card border-0 shadow-sm rounded-4 p-3 h-100 bg-white">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <label class="small text-muted fw-bold text-uppercase">Selfie</label>
                                        <?php if (!empty($partner['selfie_link'])): ?>
                                            <a href="../../uploads/partners/<?= $partner['selfie_link'] ?>" target="_blank" class="text-primary small"><i class="fas fa-external-link-alt"></i></a>
                                        <?php endif; ?>
                                    </div>
                                    <?php if (!empty($partner['selfie_link'])): ?>
                                        <div class="ratio ratio-16x9 rounded-3 overflow-hidden bg-light">
                                            <img src="../../uploads/partners/<?= $partner['selfie_link'] ?>" style="width:100%; height:100%; object-fit:contain;" class="img-preview">
                                        </div>
                                    <?php else: ?>
                                        <div class="text-center py-4 border border-dashed rounded-3">
                                            <i class="fas fa-user-circle fa-2x text-light mb-1"></i>
                                            <div class="small text-danger">Pending</div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    </div>
</div>

<!-- Wallet Management Modal -->
<div class="modal fade" id="walletModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header border-bottom-0 pb-0">
                <h5 class="modal-title fw-bold" id="walletModalTitle">Manage Wallet</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="walletForm">
                <input type="hidden" name="partner_id" value="<?= $partner['id'] ?>">
                <input type="hidden" name="action" value="manage_wallet">
                <input type="hidden" name="type" id="walletType">
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted text-uppercase">Adjustment Amount (₹)</label>
                        <div class="input-group input-group-lg">
                            <span class="input-group-text bg-white border-end-0 text-muted">₹</span>
                            <input type="number" step="0.01" name="amount" class="form-control border-start-0" placeholder="0.00" required>
                        </div>
                    </div>
                    <div class="mb-0">
                        <label class="form-label small fw-bold text-muted text-uppercase">Remark / Description</label>
                        <textarea name="description" class="form-control" rows="2" placeholder="Enter reason for adjustment..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer border-top-0 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary rounded-pill px-4" id="walletSubmitBtn">Confirm Transaction</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function setWalletAction(type) {
    $('#walletType').val(type);
    $('#walletModalTitle').text(type === 'Credit' ? 'Add Funds to Wallet' : 'Deduct Funds from Wallet');
    $('#walletSubmitBtn').removeClass('btn-primary btn-success btn-danger')
        .addClass(type === 'Credit' ? 'btn-success' : 'btn-danger')
        .text(type === 'Credit' ? 'Add Money' : 'Deduct Money');
}

function approvePartner() {
    Swal.fire({
        title: 'Approve this partner?',
        text: "Partner will be verified and marked as Approved.",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#28a745',
        confirmButtonText: 'Yes, Approve!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.post('api/partner_actions.php', { action: 'approve', id: <?= $partner['id'] ?> }, function(res) {
                if (res.success) Swal.fire('Approved!', res.message, 'success').then(() => location.reload());
                else Swal.fire('Error', res.message, 'error');
            });
        }
    });
}

$(document).ready(function() {
    // Wallet Form Submission
    $('#walletForm').submit(function(e) {
        e.preventDefault();
        const btn = $('#walletSubmitBtn');
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Processing...');

        $.post('api/wallet_actions.php', $(this).serialize(), function(res) {
            if (res.success) {
                Swal.fire('Success!', res.message, 'success').then(() => location.reload());
            } else {
                Swal.fire('Error', res.message, 'error');
                btn.prop('disabled', false).text('Confirm Transaction');
            }
        });
    });

    // Delete Action
    $('.delete-btn').click(function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete this partner?',
            text: "This action cannot be undone and will remove all associated data.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, delete forever!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/partner_actions.php', { action: 'delete', id: id }, function(res) {
                    if (res.success) {
                        Swal.fire('Deleted!', res.message, 'success').then(() => { window.location.href = 'partner-management.php'; });
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            }
        })
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>

