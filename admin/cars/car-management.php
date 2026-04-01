<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Manage Fleet";

// Fetch all cars with joins
try {
    $stmt = $pdo->query("SELECT c.*, b.name AS brand_name, t.name AS type_name, tt.name AS trip_name 
                        FROM cars c 
                        JOIN car_brands b ON c.brand_id = b.id 
                        JOIN car_types t ON c.type_id = t.id 
                        JOIN trip_types tt ON c.trip_type_id = tt.id 
                        ORDER BY c.created_at DESC");
    $cars = $stmt->fetchAll();
} catch (Exception $e) {
    $cars = [];
    $error = $e->getMessage();
}
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-tasks me-2"></i>Car Management</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="add-car.php" class="btn btn-primary px-4 shadow-sm rounded-pill">
                    <i class="fas fa-plus-circle me-1"></i> Add New Vehicle
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
                         <p class="mb-0">Please run the <a href="api/setup_db.php" target="_blank" class="fw-bold text-white text-decoration-underline">Database Setup</a> first to initialize new tables.</p>
                    </div>
                <?php else: ?>
                    <div class="table-responsive">
                        <table id="carsTable" class="table table-hover align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th width="50">#</th>
                                    <th>Vehicle</th>
                                    <th>Details</th>
                                    <th>Pricing (INR)</th>
                                    <th>Status</th>
                                    <th width="120" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($cars as $index => $car): ?>
                                    <tr>
                                        <td><?= $index + 1 ?></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="car-thumb me-3">
                                                    <?php if (!empty($car['image'])): ?>
                                                        <img src="../../uploads/cars/<?= $car['image'] ?>" class="rounded shadow-sm" style="width:70px; height:50px; object-fit:cover;">
                                                    <?php else: ?>
                                                        <div class="bg-light rounded shadow-sm text-center" style="width:70px; height:50px; padding-top:12px;">
                                                             <i class="fas fa-car text-muted opacity-50"></i>
                                                        </div>
                                                    <?php endif; ?>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1 fw-bold"><?= htmlspecialchars($car['name']) ?></h6>
                                                    <span class="badge bg-yellow-soft text-dark small"><?= htmlspecialchars($car['brand_name']) ?></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="small">
                                                <span class="text-muted">Type:</span> <span class="fw-semibold text-dark"><?= $car['type_name'] ?></span><br>
                                                <span class="text-muted">Trip:</span> <span class="fw-semibold text-primary"><?= $car['trip_name'] ?></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="pricing-badge p-2 rounded bg-light border border-2">
                                                 <span class="small text-muted d-block lh-1">Base Fare: <strong class="text-success">₹<?= number_format($car['base_fare'], 2) ?></strong></span>
                                                 <span class="small text-muted d-block lh-1 mt-1">Extra: <strong class="text-danger">₹<?= number_format($car['extra_km_price'], 2) ?>/Km</strong></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-check form-switch p-0" style="min-height: auto;">
                                                <input class="form-check-input ms-0 status-toggle" type="checkbox" role="switch" <?= $car['status'] === 'Active' ? 'checked' : '' ?> data-id="<?= $car['id'] ?>">
                                                <label class="form-check-label ms-2 small fw-semibold"><?= $car['status'] ?></label>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group shadow-sm">
                                                <a href="edit-car.php?id=<?= $car['id'] ?>" class="btn btn-white btn-sm" title="Edit Car"><i class="fas fa-edit text-primary"></i></a>
                                                <button class="btn btn-white btn-sm delete-btn" data-id="<?= $car['id'] ?>" title="Delete Car"><i class="fas fa-trash-alt text-danger"></i></button>
                                            </div>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    
                    <?php if (empty($cars)): ?>
                        <div class="text-center py-5">
                             <div class="mb-3"><i class="fas fa-car-side fa-4x text-light"></i></div>
                             <h5 class="text-muted fw-bold">No vehicles found in your fleet</h5>
                             <p class="text-muted small">Start adding cars to your system to see them here.</p>
                        </div>
                    <?php endif; ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<style>
    .bg-yellow-soft { background: #fff8e1; color: #ffc107; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.5px; }
    .table th { border-top: none !important; font-size: 0.85rem; text-transform: uppercase; color: #666; letter-spacing: 0.5px; }
    .btn-white { background: #fff; border: 1px solid #efefef; }
    .btn-white:hover { background: #f8f9fa; }
    .status-toggle { width: 40px !important; height: 20px !important; cursor: pointer; }
</style>

<!-- DataTables Scripts -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>

<script>
$(document).ready(function() {
    // Initialize DataTable
    $('#carsTable').DataTable({
        pageLength: 10,
        ordering: true,
        responsive: true
    });

    // Delete Action
    $('.delete-btn').click(function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete this vehicle?',
            text: "This will permanently remove the car from your system.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/car_actions.php', { action: 'delete', id: id }, function(res) {
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
 Westchester
 Westchester
 Westchester
