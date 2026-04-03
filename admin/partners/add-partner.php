<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Add Professional Partner";
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-user-plus me-2"></i>Add New Partner</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="partner-management.php" class="btn btn-outline-dark btn-sm px-3 shadow-sm rounded-pill">
                    <i class="fas fa-list me-1"></i> Partner List
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-dark py-3">
                        <h5 class="card-title mb-0 text-white fw-bold">Manual Enrollment Form</h5>
                    </div>
                    <div class="card-body p-4">
                        <form id="addPartnerForm">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="row g-4">
                                <div class="col-md-12">
                                    <label class="form-label fw-bold">Full Name *</label>
                                    <input type="text" name="full_name" class="form-control form-control-lg border-2 shadow-sm" placeholder="e.g. Ramesh Kumar" required>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Mobile Number *</label>
                                    <div class="input-group input-group-lg shadow-sm">
                                        <span class="input-group-text bg-light text-dark border-2">+91</span>
                                        <input type="number" name="mobile" class="form-control border-2" placeholder="9876543210" required>
                                    </div>
                                    <small class="text-muted">Will be used for OTP login.</small>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Email Address</label>
                                    <div class="input-group input-group-lg shadow-sm">
                                        <input type="email" name="email" class="form-control border-2" placeholder="optional@email.com">
                                    </div>
                                </div>
                                
                                <div class="col-md-12">
                                    <label class="form-label fw-bold">Account Status</label>
                                    <select name="status" class="form-select form-control-lg border-2 shadow-sm">
                                        <option value="Active">Active (Ready to Drive)</option>
                                        <option value="Inactive">Inactive (Paused)</option>
                                    </select>
                                </div>
                                
                            </div>
                            
                            <div class="mt-5 text-end">
                                <button type="submit" class="btn btn-primary px-5 py-3 rounded-pill shadow-lg fw-bold">
                                    <i class="fas fa-check-circle me-2"></i> Register Partner
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#addPartnerForm').on('submit', function(e) {
        e.preventDefault();
        
        $.ajax({
            url: 'api/partner_actions.php',
            type: 'POST',
            data: $(this).serialize(),
            beforeSend: function() {
                Swal.fire({ title: 'Enrolling...', allowOutsideClick: false, didOpen: () => { Swal.showLoading(); } });
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire('Registered!', res.message, 'success').then(() => {
                         window.location.href = 'partner-management.php';
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
