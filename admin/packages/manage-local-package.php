<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? null;
$package = null;
$city_id = null;
$package_name = '';
$existingPrices = [];

// Helper to get Local Trip Type ID
function getLocalId($pdo) {
    $stmt = $pdo->prepare("SELECT id FROM trip_types WHERE name = 'Local / Rental' LIMIT 1");
    $stmt->execute();
    $res = $stmt->fetch();
    if ($res) return $res['id'];
    return null;
}
$localId = getLocalId($pdo);

if ($id) {
    $stmt = $pdo->prepare("SELECT * FROM cars WHERE id = ?");
    $stmt->execute([$id]);
    $package = $stmt->fetch();
    if ($package) {
        $city_id = $package['city_id'];
        $package_name = $package['name'];
        
        // Fetch all packages for this city & package name
        $localStmt = $pdo->prepare("SELECT * FROM cars WHERE city_id = ? AND name = ? AND trip_type_id = ?");
        $localStmt->execute([$city_id, $package_name, $localId]);
        $localPackages = $localStmt->fetchAll();
        foreach ($localPackages as $lp) {
            $existingPrices[$lp['type_id']] = $lp;
        }
    }
}

// Fetch Car Types
$carTypes = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active' ORDER BY name")->fetchAll();

// Fetch Cities
$cities = $pdo->query("SELECT id, name FROM cities WHERE status = 'Active' ORDER BY name")->fetchAll();

$title = $id ? "Edit Local / Hourly Package" : "Add New Local Package";
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <a href="local-package.php" class="btn btn-sm btn-outline-secondary me-3">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                    <h5 class="mb-0 font-weight-bold text-dark"><?= $title ?></h5>
                </div>
                <div class="card-body p-4">
                    <form id="packageForm">
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="id" value="<?= $id ?>">
                        <?php if ($id): ?>
                            <input type="hidden" name="city_id" value="<?= $city_id ?>">
                            <input type="hidden" name="name" value="<?= htmlspecialchars($package_name) ?>">
                        <?php endif; ?>
                        
                        <div class="row g-4">
                            <!-- City -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">City</label>
                                <?php if ($id): ?>
                                    <select class="form-select border-2" disabled>
                                        <?php foreach ($cities as $city): ?>
                                            <option value="<?= $city['id'] ?>" <?= ($city_id == $city['id']) ? 'selected' : '' ?>><?= htmlspecialchars($city['name']) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                <?php else: ?>
                                    <select name="city_id" class="form-select border-2" required>
                                        <option value="">Select City</option>
                                        <?php foreach ($cities as $city): ?>
                                            <option value="<?= $city['id'] ?>"><?= htmlspecialchars($city['name']) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                <?php endif; ?>
                            </div>

                            <!-- Package Name -->
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Package Name <span class="text-muted small">(e.g. 2hrs/40kms, 8hrs/80kms)</span></label>
                                <input type="text" class="form-control border-2" value="<?= htmlspecialchars($package_name) ?>" placeholder="e.g. 2hrs/40kms" <?= $id ? 'disabled' : 'name="name" required' ?>>
                            </div>

                            <!-- Pricing Section -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-3">Car Pricing List (Set Fare for multiple car types)</h6>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped align-middle">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="text-center" style="width: 80px;">Enable</th>
                                                <th>Car Type</th>
                                                <th>Base Fare (₹) <span class="text-danger">*</span></th>
                                                <th>Included KMs <span class="text-danger">*</span></th>
                                                <th>Extra KM Price (₹) <span class="text-danger">*</span></th>
                                                <th>Display Extra KM Price (Optional)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($carTypes as $type): 
                                                $typeId = $type['id'];
                                                $hasPkg = isset($existingPrices[$typeId]);
                                                $pkgData = $hasPkg ? $existingPrices[$typeId] : null;
                                            ?>
                                            <tr class="car-row">
                                                <td class="text-center">
                                                    <input type="checkbox" name="prices[<?= $typeId ?>][enabled]" value="1" class="form-check-input car-type-checkbox border-2" style="width: 20px; height: 20px;" <?= $hasPkg ? 'checked' : '' ?>>
                                                </td>
                                                <td>
                                                    <span class="fw-bold text-dark"><?= htmlspecialchars($type['name']) ?></span>
                                                    <input type="hidden" name="prices[<?= $typeId ?>][type_id]" value="<?= $typeId ?>">
                                                </td>
                                                <td>
                                                    <input type="number" name="prices[<?= $typeId ?>][base_fare]" class="form-control pricing-input border-2" value="<?= $pkgData ? $pkgData['base_fare'] : '' ?>" placeholder="Base Fare" <?= $hasPkg ? 'required' : 'disabled' ?>>
                                                </td>
                                                <td>
                                                    <input type="number" name="prices[<?= $typeId ?>][min_km]" class="form-control pricing-input border-2" value="<?= $pkgData ? $pkgData['min_km'] : '' ?>" placeholder="Min KMs" <?= $hasPkg ? 'required' : 'disabled' ?>>
                                                </td>
                                                <td>
                                                    <input type="number" name="prices[<?= $typeId ?>][extra_km_price]" class="form-control pricing-input border-2" value="<?= $pkgData ? $pkgData['extra_km_price'] : '' ?>" placeholder="Extra KM price" <?= $hasPkg ? 'required' : 'disabled' ?>>
                                                </td>
                                                <td>
                                                    <input type="text" name="prices[<?= $typeId ?>][display_extra_km_price]" class="form-control pricing-input border-2" value="<?= $pkgData ? htmlspecialchars($pkgData['display_extra_km_price']) : '' ?>" placeholder="e.g. ₹12/km" <?= $hasPkg ? '' : 'disabled' ?>>
                                                </td>
                                            </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Inclusions Section -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-0">Inclusions &amp; Exclusions</h6>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">Toll Charges</label>
                                <select name="include_toll" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_toll'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_toll'] == 'Excluded') ? 'selected' : (!isset($package) ? 'selected' : '') ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">State Tax</label>
                                <select name="include_tax" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_tax'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_tax'] == 'Excluded') ? 'selected' : (!isset($package) ? 'selected' : '') ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">Driver Allowance</label>
                                <select name="include_driver_allowance" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_driver_allowance'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_driver_allowance'] == 'Excluded') ? 'selected' : (!isset($package) ? 'selected' : '') ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Night Charges</label>
                                <select name="include_night_charges" class="form-select border-2">
                                    <option value="Included" <?= ($package && $package['include_night_charges'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                    <option value="Excluded" <?= ($package && $package['include_night_charges'] == 'Excluded') ? 'selected' : (!isset($package) ? 'selected' : '') ?>>Excluded</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Parking</label>
                                <select name="include_parking" class="form-select border-2">
                                    <option value="Excluded" <?= ($package && $package['include_parking'] == 'Excluded') ? 'selected' : (!isset($package) ? 'selected' : '') ?>>Excluded</option>
                                    <option value="Included" <?= ($package && $package['include_parking'] == 'Included') ? 'selected' : '' ?>>Included</option>
                                </select>
                            </div>

                            <!-- Description -->
                            <div class="col-md-12 mt-2">
                                <label class="form-label fw-bold">Description (Optional)</label>
                                <textarea name="description" class="form-control border-2" rows="3"><?= htmlspecialchars($package['description'] ?? '') ?></textarea>
                            </div>

                            <!-- Terms & Conditions -->
                            <div class="col-12 mt-4">
                                <h6 class="text-primary fw-bold border-bottom pb-2 mb-0">Terms &amp; Conditions</h6>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-bold">Terms &amp; Conditions</label>
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
</style>

<!-- CKEditor -->
<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
<script>
    CKEDITOR.replace('terms_editor', {
        height: 300,
        removeButtons: 'PasteFromWord',
        startupData: <?= json_encode($package['terms_conditions'] ?? '') ?>
    });

    $(document).ready(function() {
        // Toggle inputs on checkbox change
        $(document).on('change', '.car-type-checkbox', function() {
            const row = $(this).closest('.car-row');
            const inputs = row.find('.pricing-input');
            if ($(this).is(':checked')) {
                inputs.prop('disabled', false);
                row.find('input[name*="[base_fare]"]').prop('required', true);
                row.find('input[name*="[min_km]"]').prop('required', true);
                row.find('input[name*="[extra_km_price]"]').prop('required', true);
            } else {
                inputs.prop('disabled', true).prop('required', false);
            }
        });

        $('#packageForm').on('submit', function(e) {
            e.preventDefault();

            // Validate that at least one car type is enabled
            if ($('.car-type-checkbox:checked').length === 0) {
                Swal.fire('Error', 'Please select at least one car type and enter its pricing details.', 'error');
                return;
            }

            const formData = new FormData(this);
            formData.set('terms_conditions', CKEDITOR.instances.terms_editor.getData());

            $.ajax({
                url: 'api/local_package_actions.php',
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
                        }).then(() => { window.location.href = 'local-package.php'; });
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                }
            });
        });
    });
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
