<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Partner Management";

try {
    $stmt = $pdo->query("SELECT * FROM partners ORDER BY id DESC");
    $partners = $stmt->fetchAll();
} catch (Exception $e) {
    $partners = [];
    $error = $e->getMessage();
}
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-handshake me-2"></i>Partner Management</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="add-partner.php" class="btn btn-primary px-4 shadow-sm rounded-pill">
                    <i class="fas fa-plus-circle me-1"></i> Add New Partner
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="card shadow-sm border-0 rounded-4">
            <div class="card-body">
                <?php if (isset($error)): ?>
                    <div class="alert alert-danger py-4 text-center">
                         <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                         <h5>Database Sync Error</h5>
                         <p class="mb-0"><?= htmlspecialchars($error) ?></p>
                    </div>
                <?php else: ?>
                    <div class="table-responsive">
                        <table id="partnersTable" class="table table-hover align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th width="40">ID</th>
                                    <th>Partner Name</th>
                                    <th>Contact</th>
                                    <th>Verification</th>
                                    <th>Account Status</th>
                                    <th width="120" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($partners as $partner): ?>
                                    <tr>
                                        <td class="text-muted fw-bold">#<?= $partner['id'] ?></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle shadow-sm text-center d-flex align-items-center justify-content-center me-3" style="width:40px; height:40px;">
                                                     <i class="fas fa-user text-primary"></i>
                                                </div>
                                                <div>
                                                    <h6 class="mb-0 fw-bold"><?= htmlspecialchars($partner['full_name'] ?? 'N/A') ?></h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="small">
                                                <i class="fas fa-phone-alt text-muted me-1"></i> <span class="fw-semibold text-dark">+91 <?= htmlspecialchars($partner['mobile']) ?></span><br>
                                                <i class="fas fa-envelope text-muted me-1"></i> <span class="text-muted"><?= htmlspecialchars($partner['email'] ?? 'Not Provided') ?></span>
                                            </div>
                                        </td>
                                        <td>
                                            <?php 
                                            // Verification Badge
                                            $vStatus = $partner['manual_verification_status'];
                                            $vClass = 'bg-warning text-dark';
                                            if ($vStatus === 'Approved') $vClass = 'bg-success text-white';
                                            if ($vStatus === 'Rejected') $vClass = 'bg-danger text-white';
                                            ?>
                                            <span class="badge <?= $vClass ?> rounded-pill px-3 py-2 border"><i class="fas <?= $vStatus==='Approved' ? 'fa-check-circle' : 'fa-clock' ?> me-1"></i> <?= $vStatus ?></span>
                                        </td>
                                        <td>
                                            <div class="form-check form-switch p-0" style="min-height: auto;">
                                                <input class="form-check-input ms-0 status-toggle" type="checkbox" role="switch" <?= $partner['status'] === 'Active' ? 'checked' : '' ?> data-id="<?= $partner['id'] ?>">
                                                <label class="form-check-label ms-2 small fw-semibold status-label"><?= $partner['status'] ?></label>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group shadow-sm">
                                                <a href="edit-partner.php?id=<?= $partner['id'] ?>" class="btn btn-white btn-sm" title="Edit & Verify Partner"><i class="fas fa-edit text-primary"></i></a>
                                                <button class="btn btn-white btn-sm delete-btn" data-id="<?= $partner['id'] ?>" title="Delete Partner"><i class="fas fa-trash-alt text-danger"></i></button>
                                            </div>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    
                    <?php if (empty($partners)): ?>
                        <div class="text-center py-5">
                             <div class="mb-3"><i class="fas fa-users-slash fa-4x text-light"></i></div>
                             <h5 class="text-muted fw-bold">No partners registered yet</h5>
                             <p class="text-muted small">Start adding driving partners to expand your network.</p>
                        </div>
                    <?php endif; ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<style>
    .table th { border-top: none !important; font-size: 0.85rem; text-transform: uppercase; color: #666; letter-spacing: 0.5px; }
    .btn-white { background: #fff; border: 1px solid #efefef; }
    .btn-white:hover { background: #f8f9fa; }
    .status-toggle { width: 40px !important; height: 20px !important; cursor: pointer; }
    .dataTables_wrapper .dataTables_paginate .paginate_button { margin-top: 10px; }
</style>

<!-- DataTables Scripts -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>

<script>
$(document).ready(function() {
    // Initialize DataTable
    $('#partnersTable').DataTable({
        pageLength: 10,
        ordering: true,
        responsive: true
    });

    // Toggle Status Action
    $('.status-toggle').change(function() {
        const id = $(this).data('id');
        const label = $(this).closest('td').find('.status-label');
        
        $.post('api/partner_actions.php', { action: 'toggle_status', id: id }, function(res) {
            if (res.success) {
                label.text(res.new_status);
            } else {
                Swal.fire('Error', res.message, 'error');
            }
        });
    });

    // Delete Action
    $('.delete-btn').click(function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete this partner?',
            text: "This will permanently remove the partner account and associated documents.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/partner_actions.php', { action: 'delete', id: id }, function(res) {
                    if (res.success) {
                        Swal.fire('Deleted!', res.message, 'success').then(() => { location.reload(); });
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
