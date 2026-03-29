<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? '';
if (empty($id)) {
    echo "<div class='alert alert-danger mx-4 mt-4'>Invalid ID provided.</div>";
    exit;
}

$stmt = $pdo->prepare("SELECT * FROM car_types WHERE id = ?");
$stmt->execute([$id]);
$type = $stmt->fetch();

if (!$type) {
    echo "<div class='alert alert-danger mx-4 mt-4'>Car type not found.</div>";
    exit;
}
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-xl-9">
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark">Edit Car Type: <?= htmlspecialchars($type['name']) ?></h5>
                    <a href="type-management.php" class="btn btn-yellow-black btn-sm shadow-sm px-3 ms-auto">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Back to List
                    </a>
                </div>
                <div class="card-body">
                    <form id="editCarTypeForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<?= $type['id'] ?>">
                        
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Car Type Name *</label>
                                <input type="text" name="name" class="form-control" value="<?= htmlspecialchars($type['name']) ?>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Base Minimum Price (per KM) *</label>
                                <div class="input-group">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" step="0.01" name="base_price" class="form-control" value="<?= $type['base_price'] ?>" required>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Max Passengers *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-users"></i></span>
                                    <input type="number" name="passengers" class="form-control" value="<?= $type['passengers'] ?>" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Max Luggage (Number of Suitcases) *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-suitcase-rolling"></i></span>
                                    <input type="number" name="luggage" class="form-control" value="<?= $type['luggage'] ?>" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Representative Image</label>
                            <div class="d-flex align-items-center">
                                <div id="image-preview" class="border rounded bg-light d-flex align-items-center justify-content-center me-3" style="width: 120px; height: 120px; overflow: hidden;">
                                    <?php if ($type['image']): ?>
                                        <img src="<?= $adminUrl . substr($type['image'], 2) ?>" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                    <?php else: ?>
                                        <i class="fas fa-image text-muted fa-3x"></i>
                                    <?php endif; ?>
                                </div>
                                <div class="flex-grow-1">
                                    <input type="file" name="image" id="imageInput" class="form-control" accept="image/*">
                                    <small class="text-muted">Upload a new image to replace the current one.</small>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mt-5 text-end">
                            <a href="type-management.php" class="btn btn-light px-5 me-2">Cancel</a>
                            <button type="submit" class="btn btn-primary px-5 shadow-sm rounded-pill">
                                <i class="fas fa-check-circle me-1"></i> Update Car Type
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#imageInput').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#image-preview').html('<img src="' + e.target.result + '" style="max-width: 100%; max-height: 100%; object-fit: contain;">');
            }
            reader.readAsDataURL(file);
        }
    });

    $('#editCarTypeForm').on('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/car_type_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend: function() {
                $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i> Updating...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire({ icon: 'success', title: 'Updated!', text: res.message, timer: 2000, showConfirmButton: false }).then(() => {
                        window.location.href = 'type-management.php';
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            complete: function() {
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-check-circle me-1"></i> Update Car Type');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
