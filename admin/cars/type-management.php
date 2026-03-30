<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$stmt = $pdo->query("SELECT * FROM car_types ORDER BY id DESC");
$types = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="card shadow border-0">
        <div class="card-header bg-white py-3 d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold text-dark">Car Type Management</h5>
            <a href="add-car-type.php" class="btn btn-yellow-black shadow-sm px-4 ms-auto">
                <i class="fas fa-plus mr-1"></i> Add New Type
            </a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th width="80">Image</th>
                            <th>Type Name</th>
                            <th>Capacity</th>
                            <th>Status</th>
                            <th width="150" class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($types as $type): ?>
                        <tr>
                            <td>
                                <div class="bg-light d-flex align-items-center justify-content-center border rounded" style="width: 60px; height: 60px; overflow: hidden;">
                                    <?php if ($type['image']): ?>
                                        <img src="<?= $adminUrl ?>../<?= $type['image'] ?>" alt="Type" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                    <?php else: ?>
                                        <i class="fas fa-car text-muted fa-lg"></i>
                                    <?php endif; ?>
                                </div>
                            </td>
                            <td>
                                <div class="font-weight-bold text-dark"><?= htmlspecialchars($type['name']) ?></div>
                            </td>
                            <td>
                                <div class="small">
                                    <span class="me-3 text-muted"><i class="fas fa-users me-1"></i> <?= $type['passengers'] ?> Pax</span>
                                    <span class="text-muted"><i class="fas fa-suitcase me-1"></i> <?= $type['luggage'] ?> bags</span>
                                </div>
                            </td>
                            <td>
                                <div class="form-check form-switch">
                                    <input class="form-check-input status-toggle" type="checkbox" data-id="<?= $type['id'] ?>" <?= $type['status'] === 'Active' ? 'checked' : '' ?>>
                                    <span class="badge <?= $type['status'] === 'Active' ? 'bg-success' : 'bg-secondary' ?> ms-2">
                                        <?= $type['status'] ?>
                                    </span>
                                </div>
                            </td>
                            <td class="text-center">
                                <div class="btn-group">
                                    <a href="edit-car-type.php?id=<?= $type['id'] ?>" class="btn btn-sm btn-outline-primary" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button type="button" class="btn btn-sm btn-outline-danger delete-type" data-id="<?= $type['id'] ?>" title="Delete">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                        <?php if (empty($types)): ?>
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">No car types found.</td>
                        </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('.status-toggle').on('change', function() {
        const id = $(this).data('id');
        $.post('api/car_type_actions.php', { action: 'toggle_status', id: id }, function(res) {
            if (res.success) {
                location.reload();
            } else {
                Swal.fire('Error', res.message, 'error');
            }
        });
    });

    $('.delete-type').on('click', function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete Car Type?',
            text: "This will remove the type permanently!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/car_type_actions.php', { action: 'delete', id: id }, function(res) {
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
