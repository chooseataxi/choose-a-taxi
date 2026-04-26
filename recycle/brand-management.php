<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$stmt = $pdo->query("SELECT * FROM car_brands ORDER BY id DESC");
$brands = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12">
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark">Car Brand Management</h5>
                    <a href="add-car-brand.php" class="btn btn-yellow-black shadow-sm px-4 ms-auto">
                        <i class="fas fa-plus mr-1"></i> Add New Brand
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th width="80">Logo</th>
                                    <th>Brand Details</th>
                                    <th>SEO Title</th>
                                    <th>Status</th>
                                    <th width="150" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($brands as $brand): ?>
                                <tr>
                                    <td>
                                        <div class="bg-light d-flex align-items-center justify-content-center border rounded" style="width: 60px; height: 60px;">
                                            <?php if ($brand['logo']): ?>
                                                <img src="<?= $adminUrl . substr($brand['logo'], 2) ?>" alt="Logo" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                            <?php else: ?>
                                                <i class="fas fa-car text-muted"></i>
                                            <?php endif; ?>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold text-dark"><?= htmlspecialchars($brand['name']) ?></div>
                                        <small class="text-muted"><?= htmlspecialchars($brand['tagline']) ?></small>
                                    </td>
                                    <td>
                                        <small class="text-truncate d-inline-block" style="max-width: 200px;" title="<?= htmlspecialchars($brand['seo_title']) ?>">
                                            <?= htmlspecialchars($brand['seo_title']) ?>
                                        </small>
                                    </td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input status-toggle" type="checkbox" data-id="<?= $brand['id'] ?>" <?= $brand['status'] === 'Active' ? 'checked' : '' ?>>
                                            <span class="badge <?= $brand['status'] === 'Active' ? 'bg-success' : 'bg-secondary' ?> ms-2">
                                                <?= $brand['status'] ?>
                                            </span>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group">
                                            <a href="edit-car-brand.php?id=<?= $brand['id'] ?>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger delete-brand" data-id="<?= $brand['id'] ?>" title="Delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                                <?php if (empty($brands)): ?>
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">No car brands found. Click "Add New Brand" to create one.</td>
                                </tr>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('.status-toggle').on('change', function() {
        const id = $(this).data('id');
        $.ajax({
            url: 'api/car_brand_actions.php',
            type: 'POST',
            data: { action: 'toggle_status', id: id },
            success: function(res) {
                if (res.success) {
                    location.reload();
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            }
        });
    });

    $('.delete-brand').on('click', function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete Brand?',
            text: "This action cannot be undone!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'api/car_brand_actions.php',
                    type: 'POST',
                    data: { action: 'delete', id: id },
                    success: function(res) {
                        if (res.success) {
                            Swal.fire('Deleted!', res.message, 'success').then(() => {
                                location.reload();
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
