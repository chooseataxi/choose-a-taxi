<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$partner_id = $_GET['id'] ?? 0;

try {
    $stmt = $pdo->prepare("SELECT * FROM partners WHERE id = ?");
    $stmt->execute([$partner_id]);
    $partner = $stmt->fetch();

    if (!$partner) {
        throw new Exception("Partner not found or deleted.");
    }
} catch (Exception $e) {
    die("<div class='container mt-5'><div class='alert alert-danger'>".$e->getMessage()."</div><a href='partner-management.php' class='btn btn-primary'>Go Back</a></div>");
}

$page_title = "Add Vehicle - " . ($partner['full_name'] ?? 'N/A');
?>
<style>
    .form-section {
        background: #fff;
        border-radius: 16px;
        border: 1px solid #e9ecef;
        transition: box-shadow .2s ease;
    }
    .form-section:hover {
        box-shadow: 0 4px 20px rgba(0,0,0,0.04);
    }
    .form-section h6 {
        font-size: 13px;
        letter-spacing: 0.5px;
    }
    .form-control[readonly] {
        background-color: #f8f9fa;
        cursor: not-allowed;
    }
    .lookup-spinner {
        display: none;
    }
    .rc-lookup-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
    }
</style>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-car me-2 text-primary"></i>Add Vehicle</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="view-partner.php?id=<?= $partner['id'] ?>" class="btn btn-outline-dark btn-sm px-4 shadow-sm rounded-pill">
                    <i class="fas fa-arrow-left me-1"></i> Back to Partner
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <form id="addVehicleForm" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="partner_id" value="<?= $partner['id'] ?>">
            <input type="hidden" name="raw_rc_data" id="raw_rc_data" value="{}">

            <div class="row g-4">
                <!-- Left: Partner Info -->
                <div class="col-lg-4">
                    <div class="card shadow-sm border-0 rounded-4 overflow-hidden sticky-top" style="top: 20px;">
                        <div class="card-body p-0">
                            <div class="bg-primary text-white p-4 text-center">
                                <div class="rounded-circle shadow border border-4 border-white overflow-hidden mb-3 mx-auto" style="width: 100px; height: 100px; background: #fff;">
                                    <?php if (!empty($partner['selfie_link'])): ?>
                                        <img src="../../uploads/partners/<?= $partner['selfie_link'] ?>" style="width:100%; height:100%; object-fit:cover;">
                                    <?php else: ?>
                                        <div class="h-100 d-flex align-items-center justify-content-center bg-gray-200">
                                            <i class="fas fa-user fa-3x text-muted"></i>
                                        </div>
                                    <?php endif; ?>
                                </div>
                                <h5 class="fw-bold mb-1"><?= htmlspecialchars($partner['full_name'] ?? 'N/A') ?></h5>
                                <p class="mb-0 opacity-75 small">Partner ID: #<?= $partner['id'] ?></p>
                            </div>
                            <div class="p-4">
                                <div class="mb-3">
                                    <label class="small text-muted text-uppercase fw-bold mb-1 d-block">Mobile</label>
                                    <div class="fw-bold text-dark">+91 <?= htmlspecialchars($partner['mobile']) ?></div>
                                </div>
                                <div class="mb-3">
                                    <label class="small text-muted text-uppercase fw-bold mb-1 d-block">Email</label>
                                    <div class="fw-semibold text-dark"><?= htmlspecialchars($partner['email'] ?: 'Not Provided') ?></div>
                                </div>
                                <div class="mb-0">
                                    <label class="small text-muted text-uppercase fw-bold mb-1 d-block">Status</label>
                                    <span class="badge bg-<?= $partner['status'] === 'Active' ? 'success' : 'danger' ?> rounded-pill px-3 py-2"><?= $partner['status'] ?></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right: Vehicle Form -->
                <div class="col-lg-8">
                    <!-- RC Lookup -->
                    <div class="form-section p-4 mb-4 rc-lookup-card">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-7">
                                <label class="form-label small fw-bold text-uppercase mb-2" style="color: rgba(255,255,255,0.85);">
                                    <i class="fas fa-search me-1"></i> RC Number <span class="text-warning">*</span>
                                </label>
                                <div class="input-group input-group-lg">
                                    <input type="text" name="rc_number" id="rc_number_input" class="form-control border-0" placeholder="e.g. HR55BC1321" required style="background: rgba(255,255,255,0.95);">
                                    <button type="button" class="btn btn-light fw-bold px-4" id="lookupRcBtn">
                                        <span class="lookup-text"><i class="fas fa-search me-1"></i> Lookup RC</span>
                                        <span class="lookup-spinner"><i class="fas fa-spinner fa-spin me-1"></i> Looking up...</span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <p class="mb-0 small" style="color: rgba(255,255,255,0.8);">
                                    <i class="fas fa-info-circle me-1"></i> 
                                    Fetches vehicle details from Surepass database. Make sure the RC number is correct.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Vehicle Details -->
                    <div class="form-section p-4 mb-4" id="vehicleDetailsSection" style="display: none;">
                        <div class="d-flex align-items-center mb-4">
                            <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                                <i class="fas fa-list text-primary fa-lg"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0">Vehicle Details</h5>
                                <small class="text-muted">Auto-filled from Surepass (editable fields are white)</small>
                            </div>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Owner Name</label>
                                <input type="text" name="owner_name" id="f_owner_name" class="form-control" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Manufacturer</label>
                                <input type="text" name="maker_description" id="f_maker_description" class="form-control" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Model <span class="text-danger">*</span></label>
                                <input type="text" name="maker_model" id="f_maker_model" class="form-control" placeholder="e.g. INNOVA CRYSTA 2.4G">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Body Type</label>
                                <input type="text" name="body_type" id="f_body_type" class="form-control" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Fuel Type</label>
                                <input type="text" name="fuel_type" id="f_fuel_type" class="form-control" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Color</label>
                                <input type="text" name="color" id="f_color" class="form-control" placeholder="e.g. White">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Seat Capacity</label>
                                <input type="text" name="seat_capacity" id="f_seat_capacity" class="form-control" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Vehicle Category</label>
                                <input type="text" name="vehicle_category_desc" id="f_vehicle_category_desc" class="form-control" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Registration Date</label>
                                <input type="text" name="registration_date" id="f_registration_date" class="form-control" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Norms Type</label>
                                <input type="text" name="norms_type" id="f_norms_type" class="form-control" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Insurance & Documents -->
                    <div class="form-section p-4 mb-4" id="documentsSection" style="display: none;">
                        <div class="d-flex align-items-center mb-4">
                            <div class="rounded-circle bg-success bg-opacity-10 p-3 me-3">
                                <i class="fas fa-shield-alt text-success fa-lg"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0">Insurance & Documents</h5>
                                <small class="text-muted">All fields are read-only from Surepass data</small>
                            </div>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Insurance Company</label>
                                <input type="text" name="insurance_company" id="f_insurance_company" class="form-control" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Policy Number</label>
                                <input type="text" name="insurance_policy_number" id="f_insurance_policy_number" class="form-control" readonly>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small fw-bold text-muted">Insurance Valid Upto</label>
                                <input type="text" name="insurance_upto" id="f_insurance_upto" class="form-control" readonly>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">Fitness Valid Upto</label>
                                <input type="text" name="fit_up_to" id="f_fit_up_to" class="form-control" readonly>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">Permit Type</label>
                                <input type="text" name="permit_type" id="f_permit_type" class="form-control" readonly>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">Permit Valid Upto</label>
                                <input type="text" name="permit_valid_upto" id="f_permit_valid_upto" class="form-control" readonly>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">RC Status</label>
                                <input type="text" name="rc_status" id="f_rc_status" class="form-control" readonly>
                            </div>
                        </div>
                    </div>

                    <!-- Vehicle Images -->
                    <div class="form-section p-4 mb-4" id="imagesSection" style="display: none;">
                        <div class="d-flex align-items-center mb-4">
                            <div class="rounded-circle bg-warning bg-opacity-10 p-3 me-3">
                                <i class="fas fa-images text-warning fa-lg"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0">Vehicle Images</h5>
                                <small class="text-muted">Upload front and back images of the vehicle (optional)</small>
                            </div>
                        </div>
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Front Image</label>
                                <div class="border rounded-4 p-3 text-center bg-light" id="frontImageDrop" style="cursor: pointer; min-height: 160px; display: flex; align-items: center; justify-content: center;">
                                    <div id="frontImagePlaceholder">
                                        <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-2"></i>
                                        <p class="mb-0 small text-muted">Click to upload front image</p>
                                        <p class="mb-0 small text-muted">JPG, PNG, WebP</p>
                                    </div>
                                    <img id="frontImagePreview" class="img-fluid rounded-3" style="display: none; max-height: 160px;">
                                    <input type="file" name="front_image" id="frontImageInput" accept="image/jpeg,image/png,image/webp" style="display: none;">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">Back Image</label>
                                <div class="border rounded-4 p-3 text-center bg-light" id="backImageDrop" style="cursor: pointer; min-height: 160px; display: flex; align-items: center; justify-content: center;">
                                    <div id="backImagePlaceholder">
                                        <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-2"></i>
                                        <p class="mb-0 small text-muted">Click to upload back image</p>
                                        <p class="mb-0 small text-muted">JPG, PNG, WebP</p>
                                    </div>
                                    <img id="backImagePreview" class="img-fluid rounded-3" style="display: none; max-height: 160px;">
                                    <input type="file" name="back_image" id="backImageInput" accept="image/jpeg,image/png,image/webp" style="display: none;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Status & Submit -->
                    <div class="form-section p-4 mb-4" id="statusSection" style="display: none;">
                        <div class="d-flex align-items-center mb-4">
                            <div class="rounded-circle bg-info bg-opacity-10 p-3 me-3">
                                <i class="fas fa-toggle-on text-info fa-lg"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0">Status & Submit</h5>
                            </div>
                        </div>
                        <div class="row g-3 align-items-end">
                            <div class="col-md-4">
                                <label class="form-label small fw-bold text-muted">Vehicle Status</label>
                                <select name="status" class="form-select">
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                    <option value="Pending">Pending</option>
                                </select>
                            </div>
                            <div class="col-md-8 d-flex gap-2 justify-content-md-end">
                                <a href="view-partner.php?id=<?= $partner['id'] ?>" class="btn btn-light rounded-pill px-4">
                                    <i class="fas fa-times me-1"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary rounded-pill px-5 fw-bold" id="submitBtn">
                                    <i class="fas fa-save me-1"></i> Add Vehicle
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    // ── RC Lookup ──
    $('#lookupRcBtn').click(function() {
        const rc = $('#rc_number_input').val().trim().toUpperCase();
        if (!rc) {
            Swal.fire('Error', 'Please enter an RC number first.', 'error');
            return;
        }

        $('#rc_number_input').val(rc);
        const btn = $(this);
        btn.prop('disabled', true);
        btn.find('.lookup-text').hide();
        btn.find('.lookup-spinner').show();

        $.post('api/vehicle_actions.php', { action: 'lookup_rc', rc_number: rc }, function(res) {
            btn.prop('disabled', false);
            btn.find('.lookup-text').show();
            btn.find('.lookup-spinner').hide();

            if (res.success) {
                fillVehicleForm(res.data);
                Swal.fire({
                    icon: 'success',
                    title: 'RC Found!',
                    text: 'Vehicle details fetched from Surepass.',
                    timer: 2000,
                    showConfirmButton: false
                });
            } else {
                Swal.fire('Error', res.message, 'error');
            }
        });
    });

    // Allow pressing Enter in RC field to trigger lookup
    $('#rc_number_input').on('keypress', function(e) {
        if (e.which === 13) {
            e.preventDefault();
            $('#lookupRcBtn').click();
        }
    });

    // ── Fill Form ──
    function fillVehicleForm(data) {
        $('#f_owner_name').val(data.owner_name || '');
        $('#f_maker_description').val(data.maker_description || '');
        $('#f_maker_model').val(data.maker_model || '');
        $('#f_body_type').val(data.body_type || '');
        $('#f_fuel_type').val(data.fuel_type || '');
        $('#f_color').val(data.color || '');
        $('#f_seat_capacity').val(data.seat_capacity || '');
        $('#f_vehicle_category_desc').val(data.vehicle_category_desc || '');
        $('#f_registration_date').val(data.registration_date || '');
        $('#f_insurance_company').val(data.insurance_company || '');
        $('#f_insurance_policy_number').val(data.insurance_policy_number || '');
        $('#f_insurance_upto').val(data.insurance_upto || '');
        $('#f_fit_up_to').val(data.fit_up_to || '');
        $('#f_norms_type').val(data.norms_type || '');
        $('#f_rc_status').val(data.rc_status || '');
        $('#f_permit_type').val(data.permit_type || '');
        $('#f_permit_valid_upto').val(data.permit_valid_upto || '');

        $('#raw_rc_data').val(JSON.stringify(data));

        // Show sections with animation
        $('#vehicleDetailsSection').slideDown(300);
        $('#documentsSection').slideDown(300);
        $('#imagesSection').slideDown(300);
        $('#statusSection').slideDown(300);

        // Scroll to form
        $('html, body').animate({
            scrollTop: $('#vehicleDetailsSection').offset().top - 80
        }, 400);
    }

    // ── Image Upload Preview ──
    function setupImageUpload(inputId, dropId, previewId, placeholderId) {
        $('#' + dropId).click(function() {
            $('#' + inputId).click();
        });

        $('#' + inputId).on('change', function(e) {
            const file = e.target.files[0];
            if (!file) return;

            const allowedTypes = ['image/jpeg', 'image/png', 'image/webp'];
            if (!allowedTypes.includes(file.type)) {
                Swal.fire('Invalid Format', 'Only JPG, PNG & WebP images are allowed.', 'warning');
                $(this).val('');
                return;
            }

            if (file.size > 2 * 1024 * 1024) {
                Swal.fire('File Too Large', 'Image must be less than 2MB.', 'warning');
                $(this).val('');
                return;
            }

            const reader = new FileReader();
            reader.onload = function(ev) {
                $('#' + placeholderId).hide();
                $('#' + previewId).show().attr('src', ev.target.result);
            };
            reader.readAsDataURL(file);
        });
    }

    setupImageUpload('frontImageInput', 'frontImageDrop', 'frontImagePreview', 'frontImagePlaceholder');
    setupImageUpload('backImageInput', 'backImageDrop', 'backImagePreview', 'backImagePlaceholder');

    // ── Form Submission ──
    $('#addVehicleForm').submit(function(e) {
        e.preventDefault();

        const rc = $('#rc_number_input').val().trim();
        if (!rc) {
            Swal.fire('Error', 'Please enter an RC number and click "Lookup RC" first.', 'error');
            return;
        }

        const btn = $('#submitBtn');
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i> Adding Vehicle...');

        $.ajax({
            url: 'api/vehicle_actions.php',
            type: 'POST',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function(res) {
                if (res.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Vehicle Added!',
                        text: res.message,
                        showConfirmButton: true
                    }).then(() => {
                        window.location.href = 'view-partner.php?id=<?= $partner['id'] ?>';
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                    btn.prop('disabled', false).html('<i class="fas fa-save me-1"></i> Add Vehicle');
                }
            },
            error: function() {
                Swal.fire('Server Error', 'An unexpected error occurred.', 'error');
                btn.prop('disabled', false).html('<i class="fas fa-save me-1"></i> Add Vehicle');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
