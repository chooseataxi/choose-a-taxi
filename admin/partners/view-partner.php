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
} catch (Exception $e) {
    die("<div class='container mt-5'><div class='alert alert-danger'>".$e->getMessage()."</div><a href='partner-management.php' class='btn btn-primary'>Go Back</a></div>");
}

$page_title = "Partner Details - " . ($partner['full_name'] ?? 'N/A');
?>

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

            <!-- Right Column: Documents -->
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white border-bottom py-3">
                        <h5 class="card-title mb-0 fw-bold"><i class="fas fa-file-alt me-2 text-warning"></i>KYC Documents</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-4">
                            <!-- Aadhaar Front -->
                            <div class="col-md-6">
                                <div class="document-card border rounded-4 p-3 h-100 bg-light">
                                    <h6 class="fw-bold mb-3 d-flex justify-content-between align-items-center">
                                        Aadhar Card (Front)
                                        <?php if (!empty($partner['aadhaar_front_link'])): ?>
                                            <a href="../../uploads/partners/<?= $partner['aadhaar_front_link'] ?>" target="_blank" class="btn btn-xs btn-outline-primary rounded-pill"><i class="fas fa-expand"></i></a>
                                        <?php endif; ?>
                                    </h6>
                                    <?php if (!empty($partner['aadhaar_front_link'])): ?>
                                        <div class="ratio ratio-16x9 rounded-3 overflow-hidden shadow-sm bg-white">
                                            <img src="../../uploads/partners/<?= $partner['aadhaar_front_link'] ?>" style="width:100%; height:100%; object-fit:contain;" class="img-preview">
                                        </div>
                                    <?php else: ?>
                                        <div class="text-center py-5 border border-dashed rounded-3 bg-white">
                                            <i class="fas fa-image fa-3x text-light mb-2"></i>
                                            <div class="small fw-bold text-danger">Not Uploaded</div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <!-- Aadhaar Back -->
                            <div class="col-md-6">
                                <div class="document-card border rounded-4 p-3 h-100 bg-light">
                                    <h6 class="fw-bold mb-3 d-flex justify-content-between align-items-center">
                                        Aadhar Card (Back)
                                        <?php if (!empty($partner['aadhaar_back_link'])): ?>
                                            <a href="../../uploads/partners/<?= $partner['aadhaar_back_link'] ?>" target="_blank" class="btn btn-xs btn-outline-primary rounded-pill"><i class="fas fa-expand"></i></a>
                                        <?php endif; ?>
                                    </h6>
                                    <?php if (!empty($partner['aadhaar_back_link'])): ?>
                                        <div class="ratio ratio-16x9 rounded-3 overflow-hidden shadow-sm bg-white">
                                            <img src="../../uploads/partners/<?= $partner['aadhaar_back_link'] ?>" style="width:100%; height:100%; object-fit:contain;" class="img-preview">
                                        </div>
                                    <?php else: ?>
                                        <div class="text-center py-5 border border-dashed rounded-3 bg-white">
                                            <i class="fas fa-image fa-3x text-light mb-2"></i>
                                            <div class="small fw-bold text-danger">Not Uploaded</div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <!-- Live Selfie -->
                            <div class="col-md-12">
                                <div class="document-card border rounded-4 p-3 bg-light">
                                    <h6 class="fw-bold mb-3 d-flex justify-content-between align-items-center">
                                        Live Selfie Verification
                                        <?php if (!empty($partner['selfie_link'])): ?>
                                            <a href="../../uploads/partners/<?= $partner['selfie_link'] ?>" target="_blank" class="btn btn-xs btn-outline-primary rounded-pill"><i class="fas fa-expand"></i></a>
                                        <?php endif; ?>
                                    </h6>
                                    <?php if (!empty($partner['selfie_link'])): ?>
                                        <div class="d-flex justify-content-center">
                                            <div class="ratio ratio-1x1 rounded-3 overflow-hidden shadow-sm bg-white" style="max-width: 400px;">
                                                <img src="../../uploads/partners/<?= $partner['selfie_link'] ?>" style="width:100%; height:100%; object-fit:contain;" class="img-preview">
                                            </div>
                                        </div>
                                    <?php else: ?>
                                        <div class="text-center py-5 border border-dashed rounded-3 bg-white">
                                            <i class="fas fa-user-circle fa-4x text-light mb-2"></i>
                                            <div class="small fw-bold text-danger">Selfie Not Uploaded</div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-top p-4">
                        <div class="row align-items-center">
                            <div class="col-md-7 mb-3 mb-md-0">
                                <span class="text-muted small"><i class="fas fa-info-circle me-1 text-primary"></i> <b>Admin Note:</b> Please verify all uploaded KYC documents (Aadhar & Selfie) carefully before approving this partner account.</span>
                            </div>
                            <div class="col-md-5 text-md-end">
                                <button class="btn btn-outline-danger px-4 rounded-3 delete-btn me-2" data-id="<?= $partner['id'] ?>">
                                    <i class="fas fa-trash-alt me-1"></i> Delete Partner
                                </button>
                                <a href="edit-partner.php?id=<?= $partner['id'] ?>" class="btn btn-primary px-4 rounded-3 shadow-sm">
                                    <i class="fas fa-user-check me-1"></i> Verify & Approve
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .img-preview { transition: transform .3s ease; cursor: zoom-in; }
    .img-preview:hover { transform: scale(1.02); }
    .btn-xs { padding: 0.1rem 0.4rem; font-size: 0.75rem; }
    .document-card h6 { color: #555; }
</style>

<script>
$(document).ready(function() {
    // Delete Action
    $('.delete-btn').click(function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete this partner?',
            text: "This action cannot be undone.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
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
