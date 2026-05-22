<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Bootstrap trip_types & city_id column
try {
    $pdo->query("SELECT city_id FROM cars LIMIT 1");
} catch (PDOException $e) {
    try {
        $pdo->exec("ALTER TABLE cars ADD COLUMN city_id INT NULL AFTER type_id");
    } catch (PDOException $ex) {}
}

function getLocalId($pdo) {
    $stmt = $pdo->prepare("SELECT id FROM trip_types WHERE name = 'Local / Rental' LIMIT 1");
    $stmt->execute();
    $res = $stmt->fetch();
    if ($res) return $res['id'];
    
    try {
        $stmt = $pdo->prepare("INSERT INTO trip_types (name, status) VALUES ('Local / Rental', 'Active')");
        $stmt->execute();
    } catch (PDOException $e) {
        // Fallback if status column doesn't exist
        $stmt = $pdo->prepare("INSERT INTO trip_types (name) VALUES ('Local / Rental')");
        $stmt->execute();
    }
    return $pdo->lastInsertId();
}

$localId = getLocalId($pdo);

// Fetch Local Packages
$query = "SELECT c.*, ct.name as car_type, ct.image as car_image, ci.city_name 
          FROM cars c 
          LEFT JOIN car_types ct ON c.type_id = ct.id 
          LEFT JOIN cities ci ON c.city_id = ci.id
          WHERE c.trip_type_id = ?
          ORDER BY ci.city_name ASC, c.id DESC";
$stmt = $pdo->prepare($query);
$stmt->execute([$localId]);
$packages = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0 font-weight-bold text-dark">Local / Hourly Rental Packages</h4>
        <a href="manage-local-package.php" class="btn btn-yellow-black btn-sm px-4 shadow-sm">
            <i class="fas fa-plus me-2"></i> Add New Package
        </a>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="packagesTable">
                    <thead class="bg-light text-uppercase text-secondary text-xs font-weight-bolder opacity-7">
                        <tr>
                            <th class="ps-4">Package</th>
                            <th>City</th>
                            <th>Pricing</th>
                            <th>Extra KM</th>
                            <th class="text-center">Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($packages as $pkg): ?>
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <?php if (!empty($pkg['car_image'])): ?>
                                            <img src="<?= htmlspecialchars('../../' . $pkg['car_image']) ?>" class="rounded-circle me-3 border" style="width: 45px; height: 45px; object-fit: cover;">
                                        <?php else: ?>
                                            <div class="bg-light rounded-circle d-flex justify-content-center align-items-center me-3 border text-secondary" style="width: 45px; height: 45px;">
                                                <i class="fas fa-car"></i>
                                            </div>
                                        <?php endif; ?>
                                        <div>
                                            <h6 class="mb-0 text-sm fw-bold"><?= htmlspecialchars($pkg['name']) ?></h6>
                                            <p class="text-xs text-muted mb-0"><?= htmlspecialchars($pkg['car_type'] ?? 'Unknown Car') ?></p>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-info text-white">
                                        <i class="fas fa-map-marker-alt me-1"></i> <?= htmlspecialchars($pkg['city_name'] ?? 'All Cities') ?>
                                    </span>
                                </td>
                                <td>
                                    <p class="text-sm font-weight-bold mb-0">₹<?= htmlspecialchars($pkg['base_fare']) ?></p>
                                    <p class="text-xs text-muted mb-0">Up to <?= htmlspecialchars($pkg['min_km']) ?> kms</p>
                                </td>
                                <td>
                                    <?php if (!empty($pkg['display_extra_km_price'])): ?>
                                        <span class="text-sm font-weight-bold text-dark"><?= htmlspecialchars($pkg['display_extra_km_price']) ?></span>
                                    <?php else: ?>
                                        <span class="text-sm font-weight-bold text-dark">₹<?= htmlspecialchars($pkg['extra_km_price']) ?>/km</span>
                                    <?php endif; ?>
                                </td>
                                <td class="text-center">
                                    <span class="badge badge-sm cursor-pointer toggle-status <?= $pkg['status'] == 'Active' ? 'bg-success' : 'bg-secondary' ?>" 
                                          data-id="<?= $pkg['id'] ?>">
                                        <?= $pkg['status'] ?>
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="manage-local-package.php?id=<?= $pkg['id'] ?>" class="text-primary me-3" title="Edit">
                                        <i class="fas fa-edit fa-lg"></i>
                                    </a>
                                    <a href="#" class="text-danger delete-btn" data-id="<?= $pkg['id'] ?>" title="Delete">
                                        <i class="fas fa-trash fa-lg"></i>
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        
                        <?php if (empty($packages)): ?>
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="fas fa-box-open fa-3x mb-3 text-light"></i>
                                    <h5>No Packages Found</h5>
                                    <p class="text-sm">Click "Add New Package" to get started.</p>
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
    .btn-yellow-black { background-color: #ffc107; color: #000; font-weight: 700; border: none; transition: 0.3s; }
    .btn-yellow-black:hover { background-color: #e0ac08; transform: translateY(-2px); }
</style>

<script>
    $(document).ready(function() {
        // DataTables
        if ($('#packagesTable tbody tr td').length > 1) {
            $('#packagesTable').DataTable({
                "pageLength": 25,
                "ordering": false
            });
        }

        // Toggle Status
        $('.toggle-status').on('click', function() {
            const id = $(this).data('id');
            $.post('api/local_package_actions.php', { action: 'toggle_status', id: id }, function(res) {
                if (res.success) { location.reload(); }
                else { Swal.fire('Error', res.message, 'error'); }
            });
        });

        // Delete
        $('.delete-btn').on('click', function(e) {
            e.preventDefault();
            const id = $(this).data('id');
            Swal.fire({
                title: 'Are you sure?',
                text: "This package will be permanently deleted!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.post('api/local_package_actions.php', { action: 'delete', id: id }, function(res) {
                        if (res.success) {
                            Swal.fire('Deleted!', res.message, 'success').then(() => location.reload());
                        } else {
                            Swal.fire('Error', res.message, 'error');
                        }
                    });
                }
            });
        });
    });
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
