<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch trip types for the table
$stmt = $pdo->query("SELECT * FROM trip_types ORDER BY id DESC");
$tripTypes = $stmt->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3 mb-0 text-gray-800">Trip Type Management</h1>
        <a href="add-trip-type.php" class="btn btn-primary shadow-sm">
            <i class="fas fa-plus fa-sm text-white-50 mr-1"></i> Add New Trip Type
        </a>
    </div>

    <div class="card shadow mb-4 border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="tripTypesTable">
                    <thead class="bg-light">
                        <tr>
                            <th class="border-0">ID</th>
                            <th class="border-0">Name</th>
                            <th class="border-0">Description</th>
                            <th class="border-0 text-center">Status</th>
                            <th class="border-0 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($tripTypes as $type): ?>
                            <tr>
                                <td><?= $type['id'] ?></td>
                                <td class="font-weight-bold"><?= htmlspecialchars($type['name']) ?></td>
                                <td><?= htmlspecialchars($type['description']) ?></td>
                                <td class="text-center">
                                    <div class="form-check form-switch d-inline-block">
                                        <input class="form-check-input status-toggle" type="checkbox" 
                                               data-id="<?= $type['id'] ?>" 
                                               <?= $type['status'] === 'Active' ? 'checked' : '' ?>
                                               style="cursor: pointer;">
                                        <span class="badge badge-<?= $type['status'] === 'Active' ? 'success' : 'secondary' ?> ml-2">
                                            <?= $type['status'] ?>
                                        </span>
                                    </div>
                                </td>
                                <td class="text-center">
                                    <a href="edit-trip-type.php?id=<?= $type['id'] ?>" class="btn btn-sm btn-info shadow-sm mr-2" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button class="btn btn-sm btn-danger shadow-sm delete-btn" data-id="<?= $type['id'] ?>" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                        <?php if (empty($tripTypes)): ?>
                            <tr>
                                <td colspan="5" class="text-center py-4">No trip types found.</td>
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
    // Handle Status Toggle
    $('.status-toggle').change(function() {
        const id = $(this).data('id');
        const badge = $(this).siblings('.badge');
        
        $.ajax({
            url: 'api/trip_type_actions.php',
            type: 'POST',
            data: { action: 'toggle_status', id: id },
            success: function(res) {
                if (res.success) {
                    const isActive = res.message.includes('Active') || badge.text().trim() === 'Inactive';
                    badge.text(isActive ? 'Active' : 'Inactive')
                         .removeClass('badge-success badge-secondary')
                         .addClass(isActive ? 'badge-success' : 'badge-secondary');
                    Swal.fire({
                        toast: true,
                        position: 'top-end',
                        icon: 'success',
                        title: 'Status Updated',
                        showConfirmButton: false,
                        timer: 2000
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            }
        });
    });

    // Handle Delete
    $('.delete-btn').click(function() {
        const id = $(this).data('id');
        const row = $(this).closest('tr');

        Swal.fire({
            title: 'Are you sure?',
            text: "This trip type will be permanently deleted!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: 'api/trip_type_actions.php',
                    type: 'POST',
                    data: { action: 'delete', id: id },
                    success: function(res) {
                        if (res.success) {
                            row.fadeOut(function() { $(this).remove(); });
                            Swal.fire('Deleted!', 'Trip type has been deleted.', 'success');
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
