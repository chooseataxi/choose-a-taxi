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
$stmt = $pdo->prepare("SELECT c.*, ct.name as type_name, ct.image as type_image, cb.name as brand_name 
                      FROM cars c 
                      JOIN car_types ct ON c.type_id = ct.id 
                      JOIN car_brands cb ON c.brand_id = cb.id 
                      WHERE c.trip_type_id = ? 
                      ORDER BY c.id DESC");
$stmt->execute([$oneWayId]);
$packages = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="card shadow mb-4 border-0">
        <div class="card-header bg-white py-3 d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold text-dark">One Way Package Management</h5>
            <a href="manage-one-way.php" class="btn btn-yellow-black shadow-sm px-4 ms-auto">
                <i class="fas fa-plus mr-1"></i> Add One Way Package
            </a>
        </div>
        <div class="card-body p-0">
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
                                            <div class="bg-light d-flex align-items-center justify-content-center border rounded me-3" style="width: 60px; height: 45px; overflow: hidden;">
                                                <?php if ($pkg['type_image']): ?>
                                                    <img src="../../<?= $pkg['type_image'] ?>" alt="Type" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                                <?php else: ?>
                                                    <i class="fas fa-car text-muted"></i>
                                                <?php endif; ?>
                                            </div>
                                            <div>
                                                <div class="font-weight-bold text-dark"><?= htmlspecialchars($pkg['type_name']) ?></div>
                                                <span class="badge bg-yellow-soft text-dark x-small">One Way Trip</span>
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
                                        <a href="manage-one-way.php?id=<?= $pkg['id'] ?>" class="btn btn-sm btn-outline-primary me-2">
                                            <i class="fas fa-edit"></i>
                                        </a>
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

<!-- Modal Removed -->

<style>
    .bg-yellow-soft { background: #fff8e1; color: #856404; font-size: 0.65rem; font-weight: 700; text-transform: uppercase; padding: 2px 8px; border-radius: 4px; }
    .inclusion-icons i { font-size: 14px; margin-right: 5px; }
    .btn-yellow-black { background-color: #ffc107; color: #000; font-weight: 700; border: none; transition: 0.3s; }
    .btn-yellow-black:hover { background-color: #e0ac08; }
    .table thead th { background-color: #f8f9fa; border-bottom: 2px solid #dee2e6; color: #495057; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; }
    .table-hover tbody tr:hover { background-color: rgba(255, 193, 7, 0.05); }
    .form-check-input:checked { background-color: #ffc107; border-color: #ffc107; }
</style>

<script>
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
    $('#packageTable').DataTable({
        pageLength: 10,
        ordering: true,
        responsive: true
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
