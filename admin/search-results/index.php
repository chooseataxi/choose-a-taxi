<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Pagination setup
$limit = 20; // Items per page
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
if ($page < 1) $page = 1;
$offset = ($page - 1) * $limit;

// Capture filter values
$search_phone = trim($_GET['phone'] ?? '');
$search_trip_type = trim($_GET['trip_type'] ?? '');
$search_date_from = trim($_GET['date_from'] ?? '');
$search_date_to = trim($_GET['date_to'] ?? '');

// Build query conditions
$conditions = [];
$params = [];

if ($search_phone !== '') {
    $conditions[] = "phone LIKE :phone";
    $params[':phone'] = "%$search_phone%";
}
if ($search_trip_type !== '') {
    $conditions[] = "trip_type = :trip_type";
    $params[':trip_type'] = $search_trip_type;
}
if ($search_date_from !== '') {
    $conditions[] = "DATE(created_at) >= :date_from";
    $params[':date_from'] = $search_date_from;
}
if ($search_date_to !== '') {
    $conditions[] = "DATE(created_at) <= :date_to";
    $params[':date_to'] = $search_date_to;
}

$where_clause = "";
if (!empty($conditions)) {
    $where_clause = "WHERE " . implode(" AND ", $conditions);
}

try {
    // 1. Get total count of records
    $count_sql = "SELECT COUNT(*) FROM search_logs $where_clause";
    $count_stmt = $pdo->prepare($count_sql);
    foreach ($params as $key => $val) {
        $count_stmt->bindValue($key, $val);
    }
    $count_stmt->execute();
    $total_records = (int)$count_stmt->fetchColumn();
    $total_pages = ceil($total_records / $limit);
    if ($total_pages < 1) $total_pages = 1;
    if ($page > $total_pages) {
        $page = $total_pages;
        $offset = ($page - 1) * $limit;
    }

    // 2. Fetch records for current page
    $select_sql = "SELECT * FROM search_logs $where_clause ORDER BY id DESC LIMIT :offset, :limit";
    $stmt = $pdo->prepare($select_sql);
    foreach ($params as $key => $val) {
        $stmt->bindValue($key, $val);
    }
    $stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
    $stmt->execute();
    $searches = $stmt->fetchAll();

} catch (Exception $e) {
    $searches = [];
    $total_records = 0;
    $total_pages = 1;
    $error = $e->getMessage();
}
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-3 align-items-center">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-search me-2"></i>Search Results Logs</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-end">
                    <li class="breadcrumb-item"><a href="../index.php">Dashboard</a></li>
                    <li class="breadcrumb-item active">Search Results Logs</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <!-- Filter Card -->
        <div class="card shadow-sm border-0 rounded-4 mb-4">
            <div class="card-header bg-light border-0 py-3">
                <h5 class="card-title mb-0 text-dark fw-bold"><i class="fas fa-filter me-2 text-primary"></i>Filter Searches</h5>
            </div>
            <div class="card-body">
                <form method="GET" class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Phone Number</label>
                        <input type="text" name="phone" class="form-control rounded-3" placeholder="Enter phone number" value="<?= htmlspecialchars($search_phone) ?>">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Trip Type</label>
                        <select name="trip_type" class="form-select rounded-3">
                            <option value="">All Trip Types</option>
                            <option value="One Way" <?= ($search_trip_type === 'One Way') ? 'selected' : '' ?>>One Way</option>
                            <option value="Round Trip" <?= ($search_trip_type === 'Round Trip') ? 'selected' : '' ?>>Round Trip</option>
                            <option value="Local / Rental" <?= ($search_trip_type === 'Local / Rental') ? 'selected' : '' ?>>Local / Rental</option>
                            <option value="Airport Transfer" <?= ($search_trip_type === 'Airport Transfer') ? 'selected' : '' ?>>Airport Transfer</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">From Date</label>
                        <input type="date" name="date_from" class="form-control rounded-3" value="<?= htmlspecialchars($search_date_from) ?>">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">To Date</label>
                        <input type="date" name="date_to" class="form-control rounded-3" value="<?= htmlspecialchars($search_date_to) ?>">
                    </div>
                    <div class="col-12 text-end mt-4">
                        <a href="index.php" class="btn btn-outline-secondary px-4 me-2 rounded-pill shadow-sm">
                            <i class="fas fa-undo me-1"></i>Reset
                        </a>
                        <button type="submit" class="btn btn-primary px-5 rounded-pill shadow-sm">
                            <i class="fas fa-search me-1"></i>Apply Filter
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Data Card -->
        <div class="card shadow-sm border-0 rounded-4">
            <div class="card-body">
                <?php if (isset($error)): ?>
                    <div class="alert alert-danger py-4 text-center border-0 rounded-3">
                         <i class="fas fa-exclamation-triangle fa-2x mb-3 text-danger"></i>
                         <h5 class="fw-bold">Database Sync Error</h5>
                         <p class="mb-0 text-muted"><?= htmlspecialchars($error) ?></p>
                    </div>
                <?php else: ?>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th width="60">ID</th>
                                    <th>Search Time</th>
                                    <th>Trip Details</th>
                                    <th>Route</th>
                                    <th>Stops</th>
                                    <th>Start / Return</th>
                                    <th>Specs</th>
                                    <th>Contact</th>
                                    <th>IP Address</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($searches as $search): ?>
                                    <tr>
                                        <td class="text-muted fw-bold">#<?= $search['id'] ?></td>
                                        <td class="small">
                                            <span class="fw-semibold text-dark"><?= date('d M Y', strtotime($search['created_at'])) ?></span><br>
                                            <span class="text-muted"><?= date('h:i A', strtotime($search['created_at'])) ?></span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success-subtle text-success rounded-pill px-3 py-1 border border-success-subtle fw-bold text-uppercase" style="font-size: 10px;">
                                                <?= htmlspecialchars($search['main_tab'] ?? 'Out Station') ?>
                                            </span><br>
                                            <span class="small fw-semibold text-muted"><?= htmlspecialchars($search['trip_type']) ?></span>
                                        </td>
                                        <td>
                                            <div class="small">
                                                <i class="fas fa-map-marker-alt text-danger me-1"></i> <span class="fw-semibold text-dark"><?= htmlspecialchars($search['pickup']) ?></span>
                                                <?php if (!empty($search['drop_location'])): ?>
                                                    <br><i class="fas fa-flag-checkered text-success me-1"></i> <span class="text-muted"><?= htmlspecialchars($search['drop_location']) ?></span>
                                                <?php endif; ?>
                                            </div>
                                        </td>
                                        <td class="small text-muted">
                                            <?php 
                                            $stops = !empty($search['stops']) ? json_decode($search['stops'], true) : [];
                                            if (!empty($stops)) {
                                                echo '<ul class="list-unstyled mb-0 pl-0">';
                                                foreach ($stops as $idx => $stop) {
                                                    echo '<li><i class="fas fa-circle text-warning me-1" style="font-size:8px;"></i>' . htmlspecialchars($stop) . '</li>';
                                                }
                                                echo '</ul>';
                                            } else {
                                                echo '<span class="text-muted">None</span>';
                                            }
                                            ?>
                                        </td>
                                        <td class="small">
                                            <i class="far fa-calendar-alt text-muted me-1"></i> <span class="fw-semibold text-dark"><?= !empty($search['start_date']) ? date('d M Y', strtotime($search['start_date'])) : 'N/A' ?></span>
                                            <?php if (!empty($search['start_time'])): ?>
                                                <span class="text-muted">@ <?= date('h:i A', strtotime($search['start_time'])) ?></span>
                                            <?php endif; ?>
                                            <?php if (!empty($search['return_date'])): ?>
                                                <br><i class="far fa-calendar-check text-muted me-1"></i> <span class="fw-semibold text-success"><?= date('d M Y', strtotime($search['return_date'])) ?></span>
                                                <?php if (!empty($search['return_time'])): ?>
                                                    <span class="text-muted">@ <?= date('h:i A', strtotime($search['return_time'])) ?></span>
                                                <?php endif; ?>
                                            <?php endif; ?>
                                        </td>
                                        <td class="small">
                                            <i class="fas fa-road text-muted me-1"></i> <span class="fw-bold"><?= round($search['distance_km']) ?> km</span>
                                        </td>
                                        <td>
                                            <?php if (!empty($search['phone'])): ?>
                                                <div class="text-nowrap small">
                                                    <a href="tel:<?= htmlspecialchars($search['phone']) ?>" class="text-decoration-none text-dark fw-semibold">
                                                        <i class="fas fa-phone-alt text-muted me-1"></i>+91 <?= htmlspecialchars($search['phone']) ?>
                                                    </a>
                                                </div>
                                            <?php else: ?>
                                                <span class="text-muted small text-nowrap">Not provided</span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="small text-muted"><?= htmlspecialchars($search['ip_address'] ?: 'N/A') ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>

                    <?php if (empty($searches)): ?>
                        <div class="text-center py-5">
                             <div class="mb-3 text-muted"><i class="fas fa-search-minus fa-4x text-light"></i></div>
                             <h5 class="text-muted fw-bold">No search queries match filters</h5>
                             <p class="text-muted small">Try modifying your filter parameters.</p>
                        </div>
                    <?php endif; ?>

                    <!-- Pagination Controls -->
                    <?php if ($total_pages > 1): ?>
                        <div class="d-flex justify-content-between align-items-center border-top pt-4 mt-3">
                            <div class="text-muted small fw-semibold">
                                Showing <?= $offset + 1 ?> to <?= min($offset + $limit, $total_records) ?> of <?= $total_records ?> entries
                            </div>
                            <nav>
                                <ul class="pagination pagination-sm mb-0">
                                    <!-- First Page -->
                                    <li class="page-item <?= ($page <= 1) ? 'disabled' : '' ?>">
                                        <a class="page-link rounded-start-3" href="?page=1&phone=<?= urlencode($search_phone) ?>&trip_type=<?= urlencode($search_trip_type) ?>&date_from=<?= urlencode($search_date_from) ?>&date_to=<?= urlencode($search_date_to) ?>">
                                            <i class="fas fa-angle-double-left"></i>
                                        </a>
                                    </li>
                                    <!-- Previous Page -->
                                    <li class="page-item <?= ($page <= 1) ? 'disabled' : '' ?>">
                                        <a class="page-link" href="?page=<?= $page - 1 ?>&phone=<?= urlencode($search_phone) ?>&trip_type=<?= urlencode($search_trip_type) ?>&date_from=<?= urlencode($search_date_from) ?>&date_to=<?= urlencode($search_date_to) ?>">
                                            <i class="fas fa-angle-left"></i>
                                        </a>
                                    </li>
                                    
                                    <!-- Dynamic Page Numbers -->
                                    <?php 
                                    $start = max(1, $page - 2);
                                    $end = min($total_pages, $page + 2);
                                    for ($i = $start; $i <= $end; $i++): 
                                    ?>
                                        <li class="page-item <?= ($page === $i) ? 'active' : '' ?>">
                                            <a class="page-link" href="?page=<?= $i ?>&phone=<?= urlencode($search_phone) ?>&trip_type=<?= urlencode($search_trip_type) ?>&date_from=<?= urlencode($search_date_from) ?>&date_to=<?= urlencode($search_date_to) ?>">
                                                <?= $i ?>
                                            </a>
                                        </li>
                                    <?php endfor; ?>

                                    <!-- Next Page -->
                                    <li class="page-item <?= ($page >= $total_pages) ? 'disabled' : '' ?>">
                                        <a class="page-link" href="?page=<?= $page + 1 ?>&phone=<?= urlencode($search_phone) ?>&trip_type=<?= urlencode($search_trip_type) ?>&date_from=<?= urlencode($search_date_from) ?>&date_to=<?= urlencode($search_date_to) ?>">
                                            <i class="fas fa-angle-right"></i>
                                        </a>
                                    </li>
                                    <!-- Last Page -->
                                    <li class="page-item <?= ($page >= $total_pages) ? 'disabled' : '' ?>">
                                        <a class="page-link rounded-end-3" href="?page=<?= $total_pages ?>&phone=<?= urlencode($search_phone) ?>&trip_type=<?= urlencode($search_trip_type) ?>&date_from=<?= urlencode($search_date_from) ?>&date_to=<?= urlencode($search_date_to) ?>">
                                            <i class="fas fa-angle-double-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    <?php endif; ?>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<style>
    .table th { border-top: none !important; font-size: 0.85rem; text-transform: uppercase; color: #666; letter-spacing: 0.5px; }
    .pagination .page-link { color: #555; border: 1px solid #dee2e6; }
    .pagination .page-item.active .page-link { background-color: #0d6efd; border-color: #0d6efd; color: #fff; }
    .btn-xs { padding: .2rem .4rem; font-size: .75rem; line-height: 1.5; border-radius: .2rem; }
</style>

<?php require_once __DIR__ . '/../footer.php'; ?>
