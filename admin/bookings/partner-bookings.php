<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Pagination settings
$limit = 10;
$page = isset($_GET['page']) ? max(1, (int)$_GET['page']) : 1;
$offset = ($page - 1) * $limit;

// Fetch bookings with partner names, car types, and images
try {
    // Total count for pagination
    $total_stmt = $pdo->query("SELECT COUNT(*) FROM partner_bookings");
    $total_records = $total_stmt->fetchColumn();
    $total_pages = ceil($total_records / $limit);

    $sql = "SELECT pb.*, 
                   p.full_name AS poster_name, 
                   p.mobile AS poster_mobile,
                   acc_p.full_name AS acceptor_name,
                   acc_p.mobile AS acceptor_mobile,
                   acc.status AS acceptance_status,
                   ct.name AS car_type_name,
                   ct.image AS car_type_image
            FROM partner_bookings pb
            LEFT JOIN partners p ON p.id = pb.partner_id
            LEFT JOIN accepted_bookings acc ON acc.booking_id = pb.id AND acc.status != 'Cancelled'
            LEFT JOIN partners acc_p ON acc_p.id = acc.partner_id
            LEFT JOIN car_types ct ON (ct.id = pb.car_type OR ct.name = pb.car_type)
            ORDER BY pb.id DESC
            LIMIT $limit OFFSET $offset";
    $stmt = $pdo->query($sql);
    $bookings = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $error = "Error fetching bookings: " . $e->getMessage();
}

$status_badges = [
    'Open' => 'bg-info',
    'Posted' => 'bg-primary',
    'Accepted' => 'bg-success',
    'Active' => 'bg-warning',
    'Completed' => 'bg-success',
    'Cancelled' => 'bg-danger',
    'Expired' => 'bg-secondary'
];
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-calendar-check me-2"></i>Partner Bookings</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="../index.php">Admin</a></li>
                    <li class="breadcrumb-item active">Partner Bookings</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <?php if (isset($error)): ?>
            <div class="alert alert-danger shadow-sm border-0 rounded-3">
                <i class="fas fa-exclamation-circle me-2"></i><?= $error ?>
            </div>
        <?php endif; ?>

        <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
            <div class="card-header bg-white py-3 border-bottom">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <h5 class="mb-0 fw-bold text-dark">Trip Marketplace History</h5>
                        <p class="text-muted small mb-0">Overview of all bookings shared by partners</p>
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-outline-primary btn-sm rounded-pill px-3" onclick="window.location.reload()"><i class="fas fa-sync-alt me-1"></i> Refresh</button>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light text-muted small text-uppercase fw-bold">
                            <tr>
                                <th class="ps-4" style="width: 120px;">Booking</th>
                                <th>Route & Schedule</th>
                                <th>Vehicle & Requirements</th>
                                <th>Commercials</th>
                                <th>Partner (Post/Accept)</th>
                                <th>Status</th>
                                <th class="text-center pe-4" style="width: 140px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="border-top-0">
                            <?php foreach ($bookings as $b): ?>
                            <tr>
                                <td class="ps-4">
                                    <span class="fw-bold text-dark d-block text-nowrap">ID-<?= $b['id'] ?></span>
                                    <span class="badge bg-light text-dark border mt-1" style="font-size: 0.65rem;"><?= htmlspecialchars($b['booking_type']) ?></span>
                                </td>
                                <td>
                                    <div class="d-flex flex-column" style="max-width: 250px;">
                                        <div class="text-truncate" title="<?= htmlspecialchars($b['pickup_location']) ?>">
                                            <i class="fas fa-circle text-success me-1" style="font-size: 0.6rem;"></i> 
                                            <span class="small fw-bold text-dark"><?= htmlspecialchars($b['pickup_location']) ?></span>
                                        </div>
                                        <div class="text-truncate mt-1" title="<?= htmlspecialchars($b['drop_location']) ?>">
                                            <i class="fas fa-circle text-danger me-1" style="font-size: 0.6rem;"></i> 
                                            <span class="small fw-bold text-dark"><?= htmlspecialchars($b['drop_location']) ?></span>
                                        </div>
                                        <div class="mt-2 text-muted" style="font-size: 0.75rem;">
                                            <i class="far fa-calendar-alt me-1"></i> <?= date('d M, Y', strtotime($b['start_date'])) ?> 
                                            <i class="far fa-clock ms-2 me-1"></i> <?= htmlspecialchars($b['start_time']) ?>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="me-2" style="width: 50px; height: 35px;">
                                            <?php if (!empty($b['car_type_image'])): ?>
                                                <img src="../../uploads/car_types/<?= $b['car_type_image'] ?>" class="img-fluid rounded shadow-sm" style="object-fit: contain; width: 100%; height: 100%;">
                                            <?php else: ?>
                                                <div class="bg-light d-flex align-items-center justify-content-center h-100 rounded">
                                                    <i class="fas fa-car text-muted small"></i>
                                                </div>
                                            <?php endif; ?>
                                        </div>
                                        <div>
                                            <div class="small fw-bold text-dark"><?= htmlspecialchars($b['car_type_name'] ?? $b['car_type']) ?></div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <?php if ($b['pricing_option'] === 'fixed'): ?>
                                        <div class="fw-bold text-dark">₹<?= number_format($b['total_amount'], 2) ?></div>
                                        <div class="text-success small" style="font-size: 0.7rem;">Comm: ₹<?= number_format($b['commission'], 2) ?></div>
                                    <?php else: ?>
                                        <span class="badge bg-light text-primary border">Bidding/Quote</span>
                                    <?php endif; ?>
                                    <div class="text-muted mt-1" style="font-size: 0.65rem;">
                                        <i class="fas fa-receipt me-1"></i> Toll/Pkg: <?= $b['toll_tax'] ?>
                                    </div>
                                </td>
                                <td>
                                    <div class="mb-2">
                                        <div class="small fw-bold text-primary"><i class="fas fa-upload me-1 opacity-50"></i> Posted:</div>
                                        <div class="small text-dark fw-bold"><?= htmlspecialchars($b['poster_name'] ?? 'System') ?></div>
                                        <div class="text-muted" style="font-size: 0.7rem;"><i class="fas fa-phone-alt me-1"></i> <?= htmlspecialchars($b['poster_mobile'] ?? 'N/A') ?></div>
                                    </div>
                                    <?php if ($b['acceptor_name']): ?>
                                        <div>
                                            <div class="small fw-bold text-success"><i class="fas fa-check-double me-1 opacity-50"></i> Accepted:</div>
                                            <div class="small text-dark fw-bold"><?= htmlspecialchars($b['acceptor_name']) ?></div>
                                            <div class="text-muted" style="font-size: 0.7rem;"><i class="fas fa-phone-alt me-1"></i> <?= htmlspecialchars($b['acceptor_mobile']) ?></div>
                                        </div>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <span class="badge <?= $status_badges[$b['status']] ?? 'bg-dark' ?> rounded-pill px-3 py-2 shadow-sm" style="font-size: 0.7rem; border: 1px solid rgba(0,0,0,0.05);">
                                        <?= $b['status'] ?>
                                    </span>
                                </td>
                                <td class="text-center pe-4">
                                    <div class="btn-group shadow-sm border rounded overflow-hidden">
                                        <a href="view-booking.php?id=<?= $b['id'] ?>" class="btn btn-white btn-sm px-2" title="View Detail"><i class="fas fa-eye text-info"></i></a>
                                        <?php if (!in_array($b['status'], ['Cancelled', 'Completed', 'Expired'])): ?>
                                            <button class="btn btn-white btn-sm border text-danger cancel-booking" data-id="<?= $b['id'] ?>" title="Cancel Booking"><i class="fas fa-ban"></i></button>
                                        <?php endif; ?>
                                        <button class="btn btn-white btn-sm border text-secondary delete-booking" data-id="<?= $b['id'] ?>" title="Delete Record"><i class="fas fa-trash-alt"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                            <?php if (empty($bookings)): ?>
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <div class="py-4">
                                        <i class="fas fa-folder-open fa-3x text-light mb-3"></i>
                                        <h6 class="text-muted fw-bold">No bookings found</h6>
                                        <p class="text-muted small">Trips shared by partners will appear here.</p>
                                    </div>
                                </td>
                            </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Pagination -->
            <?php if ($total_pages > 1): ?>
            <div class="card-footer bg-white border-top py-3">
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm justify-content-center mb-0">
                        <li class="page-item <?= ($page <= 1) ? 'disabled' : '' ?>">
                            <a class="page-link shadow-none" href="?page=<?= $page - 1 ?>" tabindex="-1">Previous</a>
                        </li>
                        <?php for ($i = 1; $i <= $total_pages; $i++): ?>
                            <li class="page-item <?= ($page == $i) ? 'active' : '' ?>">
                                <a class="page-link shadow-none" href="?page=<?= $i ?>"><?= $i ?></a>
                            </li>
                        <?php endfor; ?>
                        <li class="page-item <?= ($page >= $total_pages) ? 'disabled' : '' ?>">
                            <a class="page-link shadow-none" href="?page=<?= $page + 1 ?>">Next</a>
                        </li>
                    </ul>
                </nav>
                <div class="text-center mt-2 small text-muted">
                    Showing <?= min($total_records, $offset + 1) ?> to <?= min($total_records, $offset + $limit) ?> of <?= $total_records ?> entries
                </div>
            </div>
            <?php endif; ?>
        </div>
    </div>
</div>

<style>
    .bg-gray-200 { background-color: #f1f3f5; color: #495057; }
    .btn-white { background: #fff; border-color: #dee2e6; }
    .btn-white:hover { background: #f8f9fa; }
    .table thead th { border-top: none; }
    .card { border: none !important; }
</style>

<script>
$(document).ready(function() {
    // Cancel Booking
    $('.cancel-booking').on('click', function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Cancel Trip?',
            text: "This will mark the booking as cancelled for both parties.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, cancel it'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'api/booking_actions.php',
                    type: 'POST',
                    data: { action: 'cancel_booking', id: id },
                    success: function(res) {
                        if (res.success) {
                            Swal.fire('Cancelled!', res.message, 'success').then(() => {
                                window.location.reload();
                            });
                        } else {
                            Swal.fire('Error', res.message, 'error');
                        }
                    }
                });
            }
        });
    });

    // Delete Booking
    $('.delete-booking').on('click', function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete Forever?',
            text: "This will permanently remove the booking record.",
            icon: 'error',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'api/booking_actions.php',
                    type: 'POST',
                    data: { action: 'delete_booking', id: id },
                    success: function(res) {
                        if (res.success) {
                            Swal.fire('Deleted!', res.message, 'success').then(() => {
                                window.location.reload();
                            });
                        } else {
                            Swal.fire('Error', res.message, 'error');
                        }
                    }
                });
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
