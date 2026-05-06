<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch One Way Trip ID
$oneWayIdStmt = $pdo->prepare("SELECT id FROM trip_types WHERE name LIKE '%One Way%' LIMIT 1");
$oneWayIdStmt->execute();
$oneWayRow = $oneWayIdStmt->fetch();
$oneWayId = $oneWayRow ? $oneWayRow['id'] : 0;

// Fetch Car Types
$carTypes = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active' ORDER BY name")->fetchAll();

// Fetch Existing One Way Packages
$stmt = $pdo->prepare("SELECT c.*, ct.name as type_name, cb.name as brand_name 
                      FROM cars c 
                      JOIN car_types ct ON c.type_id = ct.id 
                      JOIN car_brands cb ON c.brand_id = cb.id 
                      WHERE c.trip_type_id = ? 
                      ORDER BY c.id DESC");
$stmt->execute([$oneWayId]);
$packages = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
            <div class="card shadow border-0 rounded-4">
                <div class="card-header bg-white py-3 d-flex align-items-center justify-content-between">
                    <div>
                        <h5 class="mb-0 fw-bold text-dark"><i class="fas fa-box-open me-2 text-primary"></i>One Way Packages</h5>
                        <p class="text-muted small mb-0">Manage fixed price one-way trip packages for search results</p>
                    </div>
                    <button class="btn btn-yellow-black shadow-sm px-4 rounded-pill" data-bs-toggle="modal" data-bs-target="#packageModal" onclick="resetForm()">
                        <i class="fas fa-plus me-1"></i> Add New Package
                    </button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="packageTable" class="table table-hover align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th width="50">#</th>
                                    <th>Vehicle/Package</th>
                                    <th>Base Fare</th>
                                    <th>Min KM</th>
                                    <th>Extra Km</th>
                                    <th>Inclusions</th>
                                    <th>Status</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($packages as $idx => $pkg): ?>
                                <tr>
                                    <td><?= $idx + 1 ?></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div>
                                                <div class="fw-bold text-dark"><?= $pkg['type_name'] ?></div>
                                                <span class="badge bg-primary-subtle text-primary x-small">One Way</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="fw-bold text-success">₹<?= number_format($pkg['base_fare'], 0) ?></td>
                                    <td><?= $pkg['min_km'] ?> KM</td>
                                    <td>₹<?= $pkg['extra_km_price'] ?>/KM</td>
                                    <td>
                                        <div class="inclusion-icons d-flex gap-2">
                                            <i class="fas fa-road <?= $pkg['include_toll'] === 'Included' ? 'text-success' : 'text-danger opacity-50' ?>" title="Toll: <?= $pkg['include_toll'] ?>"></i>
                                            <i class="fas fa-receipt <?= $pkg['include_tax'] === 'Included' ? 'text-success' : 'text-danger opacity-50' ?>" title="Tax: <?= $pkg['include_tax'] ?>"></i>
                                            <i class="fas fa-user-tie <?= $pkg['include_driver_allowance'] === 'Included' ? 'text-success' : 'text-danger opacity-50' ?>" title="Driver: <?= $pkg['include_driver_allowance'] ?>"></i>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" role="switch" <?= $pkg['status'] === 'Active' ? 'checked' : '' ?> onchange="toggleStatus(<?= $pkg['id'] ?>)">
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary me-2" onclick='editPackage(<?= json_encode($pkg) ?>)'>
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" onclick="deletePackage(<?= $pkg['id'] ?>)">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="packageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow">
            <form id="packageForm">
                <input type="hidden" name="action" value="save">
                <input type="hidden" name="id" id="pkg_id">
                
                <div class="modal-header bg-light border-bottom-0">
                    <h5 class="modal-title fw-bold" id="modalTitle">Add One Way Package</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <div class="row g-3">
                        <!-- Car Type -->
                        <div class="col-md-12">
                            <label class="form-label fw-semibold">Car Type</label>
                            <select name="type_id" id="pkg_type_id" class="form-select border-2" required>
                                <option value="">Select Car Type</option>
                                <?php foreach ($carTypes as $type): ?>
                                    <option value="<?= $type['id'] ?>"><?= $type['name'] ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <!-- Pricing -->
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Base Fare (₹)</label>
                            <input type="number" name="base_fare" id="pkg_base_fare" class="form-control border-2" placeholder="0" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Included KMs</label>
                            <input type="number" name="min_km" id="pkg_min_km" class="form-control border-2" placeholder="0" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold">Extra KM Price (₹)</label>
                            <input type="number" name="extra_km_price" id="pkg_extra_km_price" class="form-control border-2" placeholder="0" required>
                        </div>

                        <!-- Inclusions -->
                        <div class="col-12 mt-4">
                            <h6 class="fw-bold text-muted border-bottom pb-2 mb-3">Inclusions Policy</h6>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Toll Charges</label>
                            <select name="include_toll" id="pkg_include_toll" class="form-select">
                                <option value="Included">Included</option>
                                <option value="Excluded">Excluded</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">State Tax</label>
                            <select name="include_tax" id="pkg_include_tax" class="form-select">
                                <option value="Included">Included</option>
                                <option value="Excluded">Excluded</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Driver Allowance</label>
                            <select name="include_driver_allowance" id="pkg_include_driver_allowance" class="form-select">
                                <option value="Included">Included</option>
                                <option value="Excluded">Excluded</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Night Charges</label>
                            <select name="include_night_charges" id="pkg_include_night_charges" class="form-select">
                                <option value="Included">Included</option>
                                <option value="Excluded">Excluded</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold">Parking</label>
                            <select name="include_parking" id="pkg_include_parking" class="form-select">
                                <option value="Excluded">Excluded</option>
                                <option value="Included">Included</option>
                            </select>
                        </div>

                        <!-- Description -->
                        <div class="col-md-12">
                            <label class="form-label fw-semibold">Description</label>
                            <textarea name="description" id="pkg_description" class="form-control border-2" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-top-0 py-3">
                    <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-yellow-black px-5 shadow-sm">Save Package</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    .x-small { font-size: 0.65rem; padding: 2px 8px; border-radius: 10px; }
    .inclusion-icons i { font-size: 14px; }
    .btn-yellow-black { background-color: #ffc107; color: #000; font-weight: 700; border: none; transition: 0.3s; }
    .btn-yellow-black:hover { background-color: #e0ac08; transform: translateY(-2px); }
    .modal-lg { max-width: 800px; }
    .form-label { margin-bottom: 0.3rem; }
    .form-control:focus, .form-select:focus { box-shadow: none; border-color: #ffc107 !important; }
</style>

<script>
function resetForm() {
    $('#packageForm')[0].reset();
    $('#pkg_id').val('');
    $('#modalTitle').text('Add One Way Package');
}

function editPackage(pkg) {
    resetForm();
    $('#pkg_id').val(pkg.id);
    $('#pkg_type_id').val(pkg.type_id);
    $('#pkg_base_fare').val(pkg.base_fare);
    $('#pkg_min_km').val(pkg.min_km);
    $('#pkg_extra_km_price').val(pkg.extra_km_price);
    $('#pkg_include_toll').val(pkg.include_toll);
    $('#pkg_include_tax').val(pkg.include_tax);
    $('#pkg_include_driver_allowance').val(pkg.include_driver_allowance);
    $('#pkg_include_night_charges').val(pkg.include_night_charges);
    $('#pkg_include_parking').val(pkg.include_parking);
    $('#pkg_description').val(pkg.description);
    
    $('#modalTitle').text('Edit Package: ' + pkg.type_name);
    $('#packageModal').modal('show');
}

function toggleStatus(id) {
    $.post('api/one_way_actions.php', { action: 'toggle_status', id: id }, function(res) {
        if (!res.success) Swal.fire('Error', res.message, 'error');
    });
}

function deletePackage(id) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonText: 'No, cancel!',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.post('api/one_way_actions.php', { action: 'delete', id: id }, function(res) {
                if (res.success) {
                    Swal.fire('Deleted!', res.message, 'success').then(() => location.reload());
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            });
        }
    });
}

$(document).ready(function() {
    $('#packageForm').on('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/one_way_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(res) {
                if (res.success) {
                    $('#packageModal').modal('hide');
                    Swal.fire('Success', res.message, 'success').then(() => location.reload());
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
