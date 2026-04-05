<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Subscription Plans";

// Fetch all plans
try {
    $stmt = $pdo->query("SELECT * FROM partner_subscription_plans ORDER BY created_at DESC");
    $plans = $stmt->fetchAll();
} catch (Exception $e) {
    $plans = [];
    $error = $e->getMessage();
}
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-medal me-2"></i>Subscription Plans</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="add-plan.php" class="btn btn-primary px-4 shadow-sm rounded-pill">
                    <i class="fas fa-plus-circle me-1"></i> Add New Plan
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
                         <p class="mb-0">Please run the <a href="javascript:void(0);" onclick="runSetup()" class="fw-bold text-white text-decoration-underline">Database Setup</a> first to initialize new tables.</p>
                    </div>
                <?php else: ?>
                    <div class="table-responsive">
                        <table id="plansTable" class="table table-hover align-middle">
                            <thead class="bg-light">
                                <tr>
                                    <th width="50">#</th>
                                    <th>Plan Name</th>
                                    <th>Duration</th>
                                    <th>Price (INR)</th>
                                    <th>Status</th>
                                    <th width="120" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($plans as $index => $plan): ?>
                                    <tr>
                                        <td><?= $index + 1 ?></td>
                                        <td>
                                            <h6 class="mb-0 fw-bold"><?= htmlspecialchars($plan['name']) ?></h6>
                                        </td>
                                        <td>
                                            <span class="badge bg-blue-soft text-primary px-3 py-2">
                                                <?= $plan['duration_value'] ?> <?= ucfirst($plan['duration_unit']) ?>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-success">₹<?= number_format($plan['price'], 2) ?></span>
                                        </td>
                                        <td>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" role="switch" <?= $plan['status'] === 'active' ? 'checked' : '' ?> 
                                                       onchange="toggleStatus(<?= $plan['id'] ?>, this.checked)">
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <div class="btn-group shadow-sm">
                                                <a href="edit-plan.php?id=<?= $plan['id'] ?>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button onclick="deletePlan(<?= $plan['id'] ?>)" class="btn btn-sm btn-outline-danger" title="Delete">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                                <?php if (empty($plans)): ?>
                                    <tr>
                                        <td colspan="6" class="text-center py-5">
                                            <img src="../../assets/img/no-data.png" style="width: 150px; opacity: 0.5;" class="mb-3 d-block mx-auto">
                                            <p class="text-muted fw-semibold">No subscription plans found. Start by adding one!</p>
                                        </td>
                                    </tr>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<script>
function toggleStatus(id, isChecked) {
    const status = isChecked ? 'active' : 'inactive';
    fetch(`api/plan-actions.php?action=toggle_status`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `id=${id}&status=${status}`
    })
    .then(r => r.json())
    .then(data => {
        if (!data.success) alert('Failed to update status: ' + data.message);
    });
}

function deletePlan(id) {
    if (confirm('Are you sure you want to delete this plan? This action cannot be undone.')) {
        fetch(`api/plan-actions.php?action=delete`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `id=${id}`
        })
        .then(r => r.json())
        .then(data => {
            if (data.success) location.reload();
            else alert(data.message);
        });
    }
}

function runSetup() {
    fetch('../../sql/create_subscription_plans.php')
    .then(r => r.text())
    .then(data => {
        alert(data);
        location.reload();
    })
    .catch(e => alert(e.message));
}
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
