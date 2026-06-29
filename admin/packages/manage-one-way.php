<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? null;
$package = null;

if ($id) {
    $stmt = $pdo->prepare("SELECT * FROM cars WHERE id = ?");
    $stmt->execute([$id]);
    $package = $stmt->fetch();
}

// Fetch Car Types
$carTypes = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active' ORDER BY name")->fetchAll();

$title = $id ? "Edit One Way Package" : "Add New One Way Package";
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <a href="one-way-package.php" class="btn btn-sm btn-outline-secondary me-3">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                    <h5 class="mb-0 font-weight-bold text-dark"><?= $title ?></h5>
                </div>
                <div class="card-body p-4">
                    <form id="packageForm">
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="id" value="<?= $id ?>">
                        
                        <div class="row g-4">
                            <!-- Car Type -->
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Car Type</label>
                                <select name="type_id" class="form-select border-2" required>
                                    <option value="">Select Car Type</option>
                                    <?php foreach ($carTypes as $type): ?>
                                        <option value="<?= $type['id'] ?>" <?= ($package && $package['type_id'] == $type['id']) ? 'selected' : '' ?>><?= $type['name'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <!-- Pricing Section -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-0">Pricing Details</h6>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-bold">Base Fare (₹)</label>
                                <input type="number" name="base_fare" class="form-control border-2" value="<?= $package['base_fare'] ?? '' ?>" placeholder="e.g. 2500" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-bold">Extra KM Price (₹) <span class="text-muted small">(actual calc)</span></label>
                                <input type="number" name="extra_km_price" class="form-control border-2" value="<?= $package['extra_km_price'] ?? '' ?>" placeholder="e.g. 12" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Display Extra KM Price <span class="text-muted small">(shown to customers — e.g. ₹12 - ₹18/km or "Low")</span></label>
                                <input type="text" name="display_extra_km_price" class="form-control border-2" value="<?= htmlspecialchars($package['display_extra_km_price'] ?? '') ?>" placeholder="e.g. ₹12 - ₹18/km">
                                <div class="form-text text-muted">Leave blank to auto-display the actual Extra KM Price above.</div>
                            </div>

                            <!-- Inclusions Section -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-0">Inclusions &amp; Exclusions</h6>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">Toll Charges</label>
                                <select name="include_toll" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_toll'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_toll'] == 'Excluded') ? 'selected' : '' ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">State Tax</label>
                                <select name="include_tax" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_tax'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_tax'] == 'Excluded') ? 'selected' : '' ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">Driver Allowance</label>
                                <select name="include_driver_allowance" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_driver_allowance'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_driver_allowance'] == 'Excluded') ? 'selected' : '' ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Night Charges</label>
                                <select name="include_night_charges" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_night_charges'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_night_charges'] == 'Excluded') ? 'selected' : '' ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Parking</label>
                                <select name="include_parking" class="form-select border-2">
                                    <option value="Excluded" <?= ($package && $package['include_parking'] == 'Excluded') ? 'selected' : '' ?>>Excluded</option>
                                    <option value="Included" <?= ($package && $package['include_parking'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                </select>
                            </div>

                            <!-- Description -->
                            <div class="col-md-12 mt-2">
                                <label class="form-label fw-bold">Description (Optional)</label>
                                <textarea name="description" class="form-control border-2" rows="3"><?= $package['description'] ?? '' ?></textarea>
                            </div>

                            <!-- Terms & Conditions -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-0">Terms &amp; Conditions</h6>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Terms &amp; Conditions <span class="text-muted small">(shown in popup on search results)</span></label>
                                <textarea name="terms_conditions" id="terms_editor" class="form-control border-2" rows="10"><?= htmlspecialchars($package['terms_conditions'] ?? '') ?></textarea>
                            </div>
                        </div>

                        <div class="mt-5 text-end">
                            <button type="submit" class="btn btn-yellow-black btn-lg px-5 shadow-sm">
                                <i class="fas fa-save me-2"></i> Save Package
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .btn-yellow-black { background-color: #ffc107; color: #000; font-weight: 700; border: none; transition: 0.3s; }
    .btn-yellow-black:hover { background-color: #e0ac08; transform: translateY(-2px); }
    .form-control:focus, .form-select:focus { box-shadow: none; border-color: #ffc107 !important; }
    .form-label { color: #555; }
</style>

<!-- CKEditor -->
<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
<script>
    CKEDITOR.replace('terms_editor', {
        height: 300,
        removeButtons: 'PasteFromWord',
        // Pre-fill with existing content when editing
        startupData: <?= json_encode($package['terms_conditions'] ?? '') ?>
    });

    $(document).ready(function() {
        $('#packageForm').on('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            // Push CKEditor content into form data
            formData.set('terms_conditions', CKEDITOR.instances.terms_editor.getData());

            $.ajax({
                url: 'api/one_way_actions.php',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                beforeSend: function() {
                    Swal.fire({ title: 'Saving...', allowOutsideClick: false, didOpen: () => { Swal.showLoading(); } });
                },
                success: function(res) {
                    if (res.success) {
                        Swal.fire({
                            icon: 'success', title: 'Success', text: res.message,
                            timer: 1500, showConfirmButton: false
                        }).then(() => { window.location.href = 'one-way-package.php'; });
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                }
            });
        });
    });
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
