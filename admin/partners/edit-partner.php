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

$page_title = "Edit & Verify Partner";
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-user-edit me-2"></i>Modify Partner</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="partner-management.php" class="btn btn-outline-dark btn-sm px-3 shadow-sm rounded-pill">
                    <i class="fas fa-list me-1"></i> Back to List
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row g-4">
            
            <!-- Left Side: Profile Editing -->
            <div class="col-lg-7">
                <div class="card shadow-lg border-0 rounded-4 overflow-hidden h-100">
                    <div class="card-body p-4 text-center border-bottom bg-light">
                        <div class="position-relative d-inline-block">
                            <div class="rounded-circle shadow border border-4 border-white overflow-hidden mb-3" style="width: 120px; height: 120px; background: #fff;">
                                <?php if (!empty($partner['selfie_link'])): ?>
                                    <img src="../../uploads/partners/<?= $partner['selfie_link'] ?>" style="width:100%; height:100%; object-fit:cover;">
                                <?php else: ?>
                                    <div class="h-100 d-flex align-items-center justify-content-center bg-gray-200">
                                        <i class="fas fa-user fa-3x text-muted"></i>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-0 text-dark"><?= htmlspecialchars($partner['full_name'] ?? 'Incomplete Profile') ?></h4>
                        <p class="text-muted small mb-0"><i class="fas fa-id-badge me-1"></i> Partner ID: #<?= $partner['id'] ?></p>
                    </div>
                    <div class="card-body p-4">
                        <form id="editPartnerForm">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<?= $partner['id'] ?>">
                            
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <label class="form-label fw-bold small text-muted">Full Legal Name *</label>
                                    <input type="text" name="full_name" class="form-control border-2 shadow-sm fw-bold text-dark" value="<?= htmlspecialchars($partner['full_name'] ?? '') ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">Secure Mobile Number *</label>
                                    <input type="number" name="mobile" class="form-control border-2 shadow-sm text-dark" value="<?= htmlspecialchars($partner['mobile']) ?>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">Contact Email</label>
                                    <input type="email" name="email" class="form-control border-2 shadow-sm" value="<?= htmlspecialchars($partner['email'] ?? '') ?>">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-muted">Account System Status</label>
                                    <select name="status" class="form-select border-2 shadow-sm">
                                        <option value="Active" <?= $partner['status'] === 'Active' ? 'selected' : '' ?>>Active (Enabled)</option>
                                        <option value="Inactive" <?= $partner['status'] === 'Inactive' ? 'selected' : '' ?>>Inactive (Suspended)</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold small text-primary">Master Document Verification</label>
                                    <select name="manual_verification_status" class="form-select border-primary border-2 shadow-sm fw-bold">
                                        <option value="Pending" <?= $partner['manual_verification_status'] === 'Pending' ? 'selected' : '' ?>>Pending Review</option>
                                        <option value="Approved" <?= $partner['manual_verification_status'] === 'Approved' ? 'selected' : '' ?>>Approved Verified</option>
                                        <option value="Rejected" <?= $partner['manual_verification_status'] === 'Rejected' ? 'selected' : '' ?>>Rejected Revoked</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mt-4 pt-3 border-top text-end">
                                <button type="submit" class="btn btn-primary px-4 py-2 rounded-pill shadow-sm fw-bold">
                                    <i class="fas fa-save me-2"></i> Update Details
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Right Side: Document Assets -->
            <div class="col-lg-5">
                <div class="card shadow border-0 rounded-4 overflow-hidden h-100">
                    <div class="card-header bg-light border-bottom border-2 py-3">
                        <h5 class="card-title mb-0 fw-bold text-dark"><i class="fas fa-id-card me-2 text-warning"></i> Uploaded Documents</h5>
                    </div>
                    <div class="card-body bg-gray-100 p-4">
                        
                        <!-- Aadhaar Front -->
                        <div class="bg-white p-3 rounded-4 shadow-sm border border-light mb-4">
                            <h6 class="fw-bold mb-3 border-bottom pb-2 text-muted">Aadhar Card (Front)</h6>
                            <?php if (!empty($partner['aadhaar_front_link'])): ?>
                                <div class="ratio ratio-16x9 rounded-3 overflow-hidden shadow-sm" style="max-height: 200px;">
                                    <?php $url = "../../uploads/partners/" . $partner['aadhaar_front_link']; ?>
                                    <a href="<?= $url ?>" target="_blank">
                                        <img src="<?= $url ?>" style="width:100%; height:100%; object-fit:cover;">
                                    </a>
                                </div>
                                <div class="mt-2 text-end small">
                                    <a href="<?= $url ?>" target="_blank" class="text-primary text-decoration-none"><i class="fas fa-expand me-1"></i> View Full Image</a>
                                </div>
                            <?php else: ?>
                                <div class="text-center py-4 bg-light rounded border border-dashed">
                                    <div class="small fw-bold text-danger">Front Not Uploaded</div>
                                </div>
                            <?php endif; ?>
                        </div>

                        <!-- Aadhaar Back -->
                        <div class="bg-white p-3 rounded-4 shadow-sm border border-light mb-4">
                            <h6 class="fw-bold mb-3 border-bottom pb-2 text-muted">Aadhar Card (Back)</h6>
                            <?php if (!empty($partner['aadhaar_back_link'])): ?>
                                <div class="ratio ratio-16x9 rounded-3 overflow-hidden shadow-sm" style="max-height: 200px;">
                                    <?php $url = "../../uploads/partners/" . $partner['aadhaar_back_link']; ?>
                                    <a href="<?= $url ?>" target="_blank">
                                        <img src="<?= $url ?>" style="width:100%; height:100%; object-fit:cover;">
                                    </a>
                                </div>
                                <div class="mt-2 text-end small">
                                    <a href="<?= $url ?>" target="_blank" class="text-primary text-decoration-none"><i class="fas fa-expand me-1"></i> View Full Image</a>
                                </div>
                            <?php else: ?>
                                <div class="text-center py-4 bg-light rounded border border-dashed">
                                    <div class="small fw-bold text-danger">Back Not Uploaded</div>
                                </div>
                            <?php endif; ?>
                        </div>

                        <!-- Full Selfie -->
                        <div class="bg-white p-3 rounded-4 shadow-sm border border-light">
                            <h6 class="fw-bold mb-3 border-bottom pb-2 text-muted">Live Selfie Screenshot</h6>
                            <?php if (!empty($partner['selfie_link'])): ?>
                                <div class="ratio ratio-1x1 rounded-3 overflow-hidden shadow-sm mx-auto" style="max-width: 250px;">
                                    <?php $url = "../../uploads/partners/" . $partner['selfie_link']; ?>
                                    <a href="<?= $url ?>" target="_blank">
                                        <img src="<?= $url ?>" style="width:100%; height:100%; object-fit:cover;">
                                    </a>
                                </div>
                                <div class="mt-3 text-center small">
                                    <a href="<?= $url ?>" target="_blank" class="btn btn-sm btn-dark rounded-pill px-3"><i class="fas fa-search-plus me-1"></i> Inspect Image</a>
                                </div>
                            <?php else: ?>
                                <div class="text-center py-4 bg-light rounded border border-dashed">
                                    <div class="small fw-bold text-danger">Selfie Missing</div>
                                </div>
                            <?php endif; ?>
                        </div>
                        
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#editPartnerForm').on('submit', function(e) {
        e.preventDefault();
        
        $.ajax({
            url: 'api/partner_actions.php',
            type: 'POST',
            data: $(this).serialize(),
            beforeSend: function() {
                Swal.fire({ title: 'Saving...', allowOutsideClick: false, didOpen: () => { Swal.showLoading(); } });
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire('Updated!', res.message, 'success').then(() => {
                         window.location.reload();
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
