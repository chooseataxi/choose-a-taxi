<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? '';
if (empty($id)) {
    echo "<div class='alert alert-danger'>ID is required.</div>";
    exit;
}

// Fetch trip type data
$stmt = $pdo->prepare("SELECT * FROM trip_types WHERE id = ?");
$stmt->execute([$id]);
$type = $stmt->fetch();

if (!$type) {
    echo "<div class='alert alert-danger'>Trip type not found.</div>";
    exit;
}
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 font-weight-bold">Edit Trip Type</h5>
                    <a href="index.php" class="btn btn-sm btn-secondary shadow-sm">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Back to List
                    </a>
                </div>
                <div class="card-body">
                    <form id="editTripTypeForm">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<?= $type['id'] ?>">
                        
                        <div class="form-group mb-4">
                            <label class="font-weight-bold">Trip Type Name</label>
                            <input type="text" name="name" class="form-control" value="<?= htmlspecialchars($type['name']) ?>" required>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold">Description</label>
                            <textarea name="description" class="form-control" rows="4"><?= htmlspecialchars($type['description']) ?></textarea>
                        </div>

                        <div class="form-group mb-0">
                            <button type="submit" class="btn btn-success px-4 shadow-sm">
                                <i class="fas fa-save mr-1"></i> Update Trip Type
                            </button>
                            <a href="index.php" class="btn btn-light px-4 ml-2">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#editTripTypeForm').on('submit', function(e) {
        e.preventDefault();
        const formData = $(this).serialize();

        $.ajax({
            url: 'api/trip_type_actions.php',
            type: 'POST',
            data: formData,
            beforeSend: function() {
                $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Updating...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: res.message,
                        timer: 2000,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.href = 'index.php';
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            complete: function() {
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-save mr-1"></i> Update Trip Type');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
