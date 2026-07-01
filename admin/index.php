<?php require_once __DIR__ . '/auth_check.php'; ?>
<?php include './header.php'; ?>

<?php
// ===== LIVE DASHBOARD STATS =====
try {
    // --- Partner Stats ---
    $totalPartners      = (int) $pdo->query("SELECT COUNT(*) FROM partners")->fetchColumn();
    $activePartners     = (int) $pdo->query("SELECT COUNT(*) FROM partners WHERE status = 'Active'")->fetchColumn();
    $inactivePartners   = $totalPartners - $activePartners;

    // --- Booking Stats ---
    $totalBookings      = (int) $pdo->query("SELECT COUNT(*) FROM partner_bookings")->fetchColumn();
    $activeBookings     = (int) $pdo->query("SELECT COUNT(*) FROM partner_bookings WHERE status IN ('Open','Posted','Accepted','Active')")->fetchColumn();
    $cancelledBookings  = (int) $pdo->query("SELECT COUNT(*) FROM partner_bookings WHERE status = 'Cancelled'")->fetchColumn();
    $expiredBookings    = (int) $pdo->query("SELECT COUNT(*) FROM partner_bookings WHERE status = 'Expired'")->fetchColumn();
    $inactiveBookings   = $totalBookings - $activeBookings - $cancelledBookings - $expiredBookings;

    // --- Enquiries (Search Logs) ---
    $totalEnquiries     = (int) $pdo->query("SELECT COUNT(*) FROM search_logs")->fetchColumn();

    // --- Payment Received (current month) ---
    $currentMonth       = date('F Y'); // e.g. "July 2026"
    $stmtPay = $pdo->prepare("SELECT COALESCE(SUM(amount), 0) FROM partner_deposits WHERE status = 'Success' AND DATE_FORMAT(created_at, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m')");
    $stmtPay->execute();
    $paymentThisMonth   = (float) $stmtPay->fetchColumn();

    // --- Booking Revenue (current month) ---
    $stmtRev = $pdo->prepare("SELECT COALESCE(SUM(total_fare), 0) FROM accepted_bookings WHERE payment_status = 'Paid' AND DATE_FORMAT(accepted_at, '%Y-%m') = DATE_FORMAT(NOW(), '%Y-%m')");
    $stmtRev->execute();
    $revenueThisMonth   = (float) $stmtRev->fetchColumn();

} catch (Exception $e) {
    // Silently fallback to zeros if DB fails — dashboard still renders
    $totalPartners = $activePartners = $inactivePartners = 0;
    $totalBookings = $activeBookings = $cancelledBookings = $expiredBookings = 0;
    $totalEnquiries = 0;
    $paymentThisMonth = $revenueThisMonth = 0;
    $inactiveBookings = 0;
    $currentMonth = date('F Y');
}
?>

<!-- Row 1: Partner Overview -->
<div class="row">
    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-info">
            <div class="inner">
                <h3><?= number_format($totalPartners) ?></h3>
                <p>Total Partners</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-people"></i>
            </div>
            <a href="partners/partner-management.php" class="small-box-footer">
                Manage Partners <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-success">
            <div class="inner">
                <h3><?= number_format($activePartners) ?></h3>
                <p>Active Partners</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-checkmark-circle"></i>
            </div>
            <a href="partners/partner-management.php" class="small-box-footer">
                View Active <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3><?= number_format($inactivePartners) ?></h3>
                <p>Inactive Partners</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-person"></i>
            </div>
            <a href="partners/partner-management.php" class="small-box-footer">
                Review Inactive <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-primary">
            <div class="inner">
                <h3><?= number_format($totalBookings) ?></h3>
                <p>Total Bookings</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-paper"></i>
            </div>
            <a href="bookings/partner-bookings.php" class="small-box-footer">
                View Bookings <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
</div>

<!-- Row 2: Bookings Breakdown -->
<div class="row">
    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-success">
            <div class="inner">
                <h3><?= number_format($activeBookings) ?></h3>
                <p>Active Bookings</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-bolt"></i>
            </div>
            <a href="bookings/partner-bookings.php" class="small-box-footer">
                View Active <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3><?= number_format($inactiveBookings) ?></h3>
                <p>Inactive / Completed</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-checkmark"></i>
            </div>
            <a href="bookings/partner-bookings.php" class="small-box-footer">
                View Details <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-danger">
            <div class="inner">
                <h3><?= number_format($cancelledBookings) ?></h3>
                <p>Cancelled Bookings</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-close-circle"></i>
            </div>
            <a href="bookings/partner-bookings.php?status=Cancelled" class="small-box-footer">
                View Cancelled <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-secondary">
            <div class="inner">
                <h3><?= number_format($expiredBookings) ?></h3>
                <p>Expired Bookings</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-timer"></i>
            </div>
            <a href="bookings/partner-bookings.php?status=Expired" class="small-box-footer">
                View Expired <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
</div>

<!-- Row 3: Enquiries & Payments -->
<div class="row">
    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-info">
            <div class="inner">
                <h3><?= number_format($totalEnquiries) ?></h3>
                <p>Total Enquiries</p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-search-strong"></i>
            </div>
            <a href="#" class="small-box-footer">
                Search Logs <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-success">
            <div class="inner">
                <h3>₹<?= number_format($paymentThisMonth, 0) ?></h3>
                <p>Payment Received<br><small class="text-white-50"><?= $currentMonth ?></small></p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-cart"></i>
            </div>
            <a href="#" class="small-box-footer">
                View Transactions <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-sm-6 col-12 mb-3">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3>₹<?= number_format($revenueThisMonth, 0) ?></h3>
                <p>Booking Revenue<br><small class="text-white-50"><?= $currentMonth ?></small></p>
            </div>
            <div class="icon">
                <i class="ion ion-ios-stats"></i>
            </div>
            <a href="bookings/partner-bookings.php" class="small-box-footer">
                View Revenue <i class="fas fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>
</div>

<?php include './footer.php'; ?>
