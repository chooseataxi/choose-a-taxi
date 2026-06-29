<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Bootstrap: Auto-create 'Airport Transfer' trip type if it doesn't exist
try {
    $airportCheckStmt = $pdo->prepare("SELECT id FROM trip_types WHERE name = 'Airport Transfer' LIMIT 1");
    $airportCheckStmt->execute();
    $airportRow = $airportCheckStmt->fetch();
    if (!$airportRow) {
        try {
            $createStmt = $pdo->prepare("INSERT INTO trip_types (name, description, status) VALUES ('Airport Transfer', 'Airport transfer taxi service', 'Active')");
            $createStmt->execute();
            $airportId = $pdo->lastInsertId();
        } catch (PDOException $e) {
            $createStmt = $pdo->prepare("INSERT INTO trip_types (name) VALUES ('Airport Transfer')");
            $createStmt->execute();
            $airportId = $pdo->lastInsertId();
        }
    } else {
        $airportId = $airportRow['id'];
    }
} catch (PDOException $e) {
    $airportId = 0;
}

// Fetch Car Types
$carTypes = $pdo->query("SELECT id, name FROM car_types WHERE status = 'Active' ORDER BY name")->fetchAll();

// Fetch Existing Airport Transfer Packages
$stmt = $pdo->prepare("SELECT c.*, ct.name as type_name, ct.image as type_image, cb.name as brand_name 
                      FROM cars c 
                      JOIN car_types ct ON c.type_id = ct.id 
                      JOIN car_brands cb ON c.brand_id = cb.id 
                      WHERE c.trip_type_id = ? 
                      ORDER BY c.id DESC");
$stmt->execute([$airportId]);
$packages = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="card shadow mb-4 border-0">
        <div class="card-header bg-white py-3 d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold text-dark">Airport Transfer Package Management</h5>
            <a href="manage-airport-transfer.php" class="btn btn-yellow-black shadow-sm px-4 ms-auto">
                <i class="fas fa-plus mr-1"></i> Add Airport Transfer Package
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
                                        <span class="badge bg-yellow-soft text-dark x-small">Airport Transfer</span>
                                    </div>
                                </div>
                            </td>
                            <td class="fw-bold text-success">₹<?= number_format($pkg['base_fare'], 0) ?></td>
                            <td><?= $pkg['min_km'] ?> KM</td>
                            <td>
                                <?php if (!empty($pkg['display_extra_km_price'])): ?>
                                    <?= htmlspecialchars($pkg['display_extra_km_price']) ?>
                                <?php else: ?>
                                    ₹<?= $pkg['extra_km_price'] ?>/KM
                                <?php endif; ?>
                            </td>
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
                                <a href="manage-airport-transfer.php?id=<?= $pkg['id'] ?>" class="btn btn-sm btn-outline-primary me-2">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <button class="btn btn-sm btn-outline-danger" onclick="deletePackage(<?= $pkg['id'] ?>)">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if (empty($packages)): ?>
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <i class="fas fa-plane fa-3x mb-3 text-light"></i>
                                    <h5>No Airport Transfer Packages Found</h5>
                                    <p class="text-sm">Click "Add Airport Transfer Package" to get started.</p>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

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
    $.post('api/airport_transfer_actions.php', { action: 'toggle_status', id: id }, function(res) {
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
            $.post('api/airport_transfer_actions.php', { action: 'delete', id: id }, function(res) {
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
