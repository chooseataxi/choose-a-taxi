<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? 0;

try {
    $sql = "SELECT pb.*, 
                   p.full_name AS poster_name, 
                   p.mobile AS poster_mobile,
                   p.email AS poster_email,
                   p.selfie_link AS poster_image,
                   acc_p.full_name AS acceptor_name,
                   acc_p.mobile AS acceptor_mobile,
                   acc_p.email AS acceptor_email,
                   acc_p.selfie_link AS acceptor_image,
                   acc.status AS acceptance_status,
                   acc.accepted_at,
                   ct.name AS car_type_name,
                   ct.image AS car_type_image,
                   c.name AS car_specific_name,
                   c.model AS car_model
            FROM partner_bookings pb
            LEFT JOIN partners p ON p.id = pb.partner_id
            LEFT JOIN accepted_bookings acc ON acc.booking_id = pb.id AND acc.status != 'Cancelled'
            LEFT JOIN partners acc_p ON acc_p.id = acc.partner_id
            LEFT JOIN cars c ON c.id = pb.car_type
            LEFT JOIN car_types ct ON ct.id = c.type_id
            WHERE pb.id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$id]);
    $booking = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$booking) {
        throw new Exception("Booking record not found.");
    }
} catch (Exception $e) {
    die("<div class='container mt-5'><div class='alert alert-danger'>".$e->getMessage()."</div><a href='partner-bookings.php' class='btn btn-primary'>Go Back</a></div>");
}

$status_colors = [
    'Open' => 'info',
    'Posted' => 'primary',
    'Accepted' => 'success',
    'Active' => 'warning',
    'Completed' => 'success',
    'Cancelled' => 'danger',
    'Expired' => 'secondary'
];
$color = $status_colors[$booking['status']] ?? 'dark';
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-info-circle me-2"></i>Booking Details</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="partner-bookings.php" class="btn btn-outline-dark btn-sm px-3 shadow-sm rounded-pill">
                    <i class="fas fa-arrow-left me-1"></i> Back to List
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row g-4">
            <!-- Left Side: Trip Overview -->
            <div class="col-lg-8">
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
                    <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between">
                        <h5 class="mb-0 fw-bold text-dark">Trip ID: ID-<?= $booking['id'] ?></h5>
                        <span class="badge bg-<?= $color ?> rounded-pill px-3 py-2 shadow-sm"><?= $booking['status'] ?></span>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-4">
                            <!-- Route Info -->
                            <div class="col-md-12">
                                <div class="bg-light p-4 rounded-4 border">
                                    <div class="row align-items-center">
                                        <div class="col-md-5">
                                            <label class="text-muted small text-uppercase fw-bold mb-1 d-block">Pickup Location</label>
                                            <div class="h6 fw-bold text-dark mb-0"><i class="fas fa-map-marker-alt text-success me-2"></i><?= htmlspecialchars($booking['pickup_location']) ?></div>
                                        </div>
                                        <div class="col-md-2 text-center d-none d-md-block">
                                            <i class="fas fa-long-arrow-alt-right fa-2x text-muted opacity-50"></i>
                                        </div>
                                        <div class="col-md-5">
                                            <label class="text-muted small text-uppercase fw-bold mb-1 d-block">Drop Location</label>
                                            <div class="h6 fw-bold text-dark mb-0"><i class="fas fa-location-arrow text-danger me-2"></i><?= htmlspecialchars($booking['drop_location']) ?></div>
                                        </div>
                                    </div>
                                    <?php 
                                        $stops = json_decode($booking['stops'], true);
                                        if (!empty($stops)): 
                                    ?>
                                        <div class="mt-3 pt-3 border-top">
                                            <label class="text-muted small text-uppercase fw-bold mb-2 d-block">Intermediate Stops</label>
                                            <div class="d-flex flex-wrap gap-2">
                                                <?php foreach ($stops as $stop): ?>
                                                    <span class="badge bg-white text-dark border rounded-pill px-3 py-2"><i class="fas fa-stop-circle text-warning me-1"></i><?= htmlspecialchars($stop) ?></span>
                                                <?php endforeach; ?>
                                            </div>
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <!-- Schedule & Vehicle -->
                            <div class="col-md-6">
                                <div class="card border-0 bg-light h-100 rounded-4">
                                    <div class="card-body">
                                        <label class="text-muted small text-uppercase fw-bold mb-3 d-block"><i class="fas fa-clock me-2"></i>Trip Schedule</label>
                                        <div class="mb-3">
                                            <div class="small text-muted">Start Date & Time</div>
                                            <div class="fw-bold text-dark"><?= date('D, d M Y', strtotime($booking['start_date'])) ?> at <?= $booking['start_time'] ?></div>
                                        </div>
                                        <?php if ($booking['end_date']): ?>
                                        <div>
                                            <div class="small text-muted">Return Date & Time</div>
                                            <div class="fw-bold text-dark"><?= date('D, d M Y', strtotime($booking['end_date'])) ?> at <?= $booking['end_time'] ?></div>
                                        </div>
                                        <?php endif; ?>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="card border-0 bg-light h-100 rounded-4">
                                    <div class="card-body">
                                        <label class="text-muted small text-uppercase fw-bold mb-3 d-block"><i class="fas fa-car me-2"></i>Vehicle Selection</label>
                                        <div class="d-flex align-items-center">
                                            <div class="me-3" style="width: 80px;">
                                                <?php if (!empty($booking['car_type_image'])): ?>
                                                    <img src="../../uploads/car_types/<?= $booking['car_type_image'] ?>" class="img-fluid rounded shadow-sm">
                                                <?php else: ?>
                                                    <div class="bg-white rounded d-flex align-items-center justify-content-center" style="height: 60px;">
                                                        <i class="fas fa-car fa-2x text-light"></i>
                                                    </div>
                                                <?php endif; ?>
                                            </div>
                                            <div>
                                                <div class="h6 fw-bold text-dark mb-0"><?= htmlspecialchars($booking['car_type_name'] ?? 'Custom') ?></div>
                                                <div class="small text-muted"><?= htmlspecialchars($booking['car_specific_name'] ?? 'Standard Configuration') ?></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pricing & Notes -->
                            <div class="col-md-12">
                                <div class="card border-0 bg-dark text-white rounded-4 overflow-hidden shadow">
                                    <div class="card-body p-4">
                                        <div class="row">
                                            <div class="col-md-4 border-end border-secondary">
                                                <div class="small text-light opacity-75 text-uppercase fw-bold mb-1">Total Trip Value</div>
                                                <div class="h3 fw-bold mb-0 text-warning">₹<?= number_format($booking['total_amount'], 2) ?></div>
                                            </div>
                                            <div class="col-md-4 border-end border-secondary ps-md-4">
                                                <div class="small text-light opacity-75 text-uppercase fw-bold mb-1">Admin Commission</div>
                                                <div class="h3 fw-bold mb-0 text-success">₹<?= number_format($booking['commission'], 2) ?></div>
                                            </div>
                                            <div class="col-md-4 ps-md-4">
                                                <div class="small text-light opacity-75 text-uppercase fw-bold mb-1">Partner Payout</div>
                                                <div class="h3 fw-bold mb-0">₹<?= number_format($booking['total_amount'] - $booking['commission'], 2) ?></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="p-3 bg-light rounded-4 border">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="small text-muted fw-bold">Toll & Parking</div>
                                            <div class="text-dark"><?= $booking['toll_tax'] ?></div>
                                        </div>
                                        <div class="col-md-8 border-start">
                                            <div class="small text-muted fw-bold">Partner Notes</div>
                                            <div class="text-dark italic"><?= !empty($booking['note']) ? '"'.htmlspecialchars($booking['note']).'"' : 'No extra notes provided.' ?></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side: Partners Info -->
            <div class="col-lg-4">
                <!-- Posting Partner -->
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4">
                    <div class="card-header bg-primary py-3">
                        <h6 class="mb-0 fw-bold text-white"><i class="fas fa-user-tie me-2"></i>Posting Partner</h6>
                    </div>
                    <div class="card-body p-4 text-center">
                        <div class="rounded-circle shadow-sm border border-4 border-white overflow-hidden mx-auto mb-3" style="width: 80px; height: 80px;">
                            <?php if (!empty($booking['poster_image'])): ?>
                                <img src="../../uploads/partners/<?= $booking['poster_image'] ?>" style="width:100%; height:100%; object-fit:cover;">
                            <?php else: ?>
                                <div class="h-100 d-flex align-items-center justify-content-center bg-gray-200">
                                    <i class="fas fa-user fa-2x text-muted"></i>
                                </div>
                            <?php endif; ?>
                        </div>
                        <h5 class="fw-bold text-dark mb-1"><?= htmlspecialchars($booking['poster_name']) ?></h5>
                        <p class="text-muted small mb-3"><i class="fas fa-phone-alt me-1 text-success"></i> <?= $booking['poster_mobile'] ?></p>
                        <div class="d-grid gap-2">
                            <a href="../partners/view-partner.php?id=<?= $booking['partner_id'] ?>" class="btn btn-outline-primary btn-sm rounded-pill">View Profile</a>
                        </div>
                    </div>
                </div>

                <!-- Accepting Partner -->
                <?php if ($booking['acceptor_name']): ?>
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mb-4 border-success" style="border-width: 2px !important;">
                    <div class="card-header bg-success py-3">
                        <h6 class="mb-0 fw-bold text-white"><i class="fas fa-check-circle me-2"></i>Accepting Partner</h6>
                    </div>
                    <div class="card-body p-4 text-center">
                        <div class="rounded-circle shadow-sm border border-4 border-white overflow-hidden mx-auto mb-3" style="width: 80px; height: 80px;">
                            <?php if (!empty($booking['acceptor_image'])): ?>
                                <img src="../../uploads/partners/<?= $booking['acceptor_image'] ?>" style="width:100%; height:100%; object-fit:cover;">
                            <?php else: ?>
                                <div class="h-100 d-flex align-items-center justify-content-center bg-gray-200">
                                    <i class="fas fa-user fa-2x text-muted"></i>
                                </div>
                            <?php endif; ?>
                        </div>
                        <h5 class="fw-bold text-dark mb-1"><?= htmlspecialchars($booking['acceptor_name']) ?></h5>
                        <p class="text-muted small mb-1"><i class="fas fa-phone-alt me-1 text-success"></i> <?= $booking['acceptor_mobile'] ?></p>
                        <div class="small text-muted mb-3"><i class="far fa-clock me-1"></i> Accepted at: <?= date('d M, Y h:i A', strtotime($booking['accepted_at'])) ?></div>
                        <div class="d-grid gap-2">
                            <a href="../partners/view-partner.php?id=<?= $booking['accepted_partner_id'] ?>" class="btn btn-outline-success btn-sm rounded-pill">View Profile</a>
                        </div>
                    </div>
                </div>
                <?php else: ?>
                <div class="card shadow-sm border-0 rounded-4 bg-light text-center p-4">
                    <i class="fas fa-user-slash fa-3x text-muted opacity-25 mb-3"></i>
                    <h6 class="fw-bold text-muted">Not Yet Accepted</h6>
                    <p class="small text-muted mb-0">This booking is currently open for partners to accept.</p>
                </div>
                <?php endif; ?>
                
                <!-- Admin Actions -->
                <div class="card shadow-sm border-0 rounded-4 overflow-hidden mt-4">
                    <div class="card-header bg-dark py-3">
                        <h6 class="mb-0 fw-bold text-white">Management Actions</h6>
                    </div>
                    <div class="card-body p-3">
                        <div class="d-grid gap-2">
                            <?php if (!in_array($booking['status'], ['Cancelled', 'Completed', 'Expired'])): ?>
                                <button class="btn btn-danger rounded-pill fw-bold" id="cancelBtn"><i class="fas fa-ban me-2"></i> Cancel Booking</button>
                            <?php endif; ?>
                            <button class="btn btn-outline-secondary btn-sm rounded-pill mt-2" id="deleteBtn"><i class="fas fa-trash me-2"></i> Delete Record</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    const bookingId = <?= $booking['id'] ?>;

    $('#cancelBtn').on('click', function() {
        Swal.fire({
            title: 'Cancel Booking?',
            text: "This will notify both partners and mark the trip as cancelled.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, Cancel it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/booking_actions.php', { action: 'cancel_booking', id: bookingId }, function(res) {
                    if(res.success) Swal.fire('Cancelled!', res.message, 'success').then(() => location.reload());
                    else Swal.fire('Error', res.message, 'error');
                });
            }
        });
    });

    $('#deleteBtn').on('click', function() {
        Swal.fire({
            title: 'Delete Forever?',
            text: "Permanent record deletion. Cannot be undone.",
            icon: 'error',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Delete Permanently'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/booking_actions.php', { action: 'delete_booking', id: bookingId }, function(res) {
                    if(res.success) Swal.fire('Deleted!', res.message, 'success').then(() => window.location.href = 'partner-bookings.php');
                    else Swal.fire('Error', res.message, 'error');
                });
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
