<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? '';
if (empty($id)) {
    echo "<div class='alert alert-danger mx-4 mt-4'>Invalid ID provided.</div>";
    exit;
}

$stmt = $pdo->prepare("SELECT * FROM car_brands WHERE id = ?");
$stmt->execute([$id]);
$brand = $stmt->fetch();

if (!$brand) {
    echo "<div class='alert alert-danger mx-4 mt-4'>Car brand not found.</div>";
    exit;
}
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-xl-10">
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark">Edit Car Brand: <?= htmlspecialchars($brand['name']) ?></h5>
                    <a href="brand-management.php" class="btn btn-yellow-black btn-sm shadow-sm px-3 ms-auto">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Back to List
                    </a>
                </div>
                <div class="card-body">
                    <form id="editCarBrandForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<?= $brand['id'] ?>">
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label class="font-weight-bold text-dark">Brand Name *</label>
                                    <input type="text" name="name" id="brandName" class="form-control" value="<?= htmlspecialchars($brand['name']) ?>" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="font-weight-bold text-dark">Tagline</label>
                                    <input type="text" name="tagline" id="brandTagline" class="form-control" value="<?= htmlspecialchars($brand['tagline']) ?>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label class="font-weight-bold text-dark">Brand Logo</label>
                                    <div class="d-flex align-items-center">
                                        <div id="logo-preview" class="border rounded bg-light d-flex align-items-center justify-content-center me-3" style="width: 100px; height: 100px; overflow: hidden;">
                                            <?php if ($brand['logo']): ?>
                                                <img src="<?= $adminUrl . substr($brand['logo'], 2) ?>" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                            <?php else: ?>
                                                <i class="fas fa-image text-muted fa-2x"></i>
                                            <?php endif; ?>
                                        </div>
                                        <div class="flex-grow-1">
                                            <input type="file" name="logo" id="logoInput" class="form-control" accept="image/*">
                                            <small class="text-muted">Upload a new logo to replace the current one.</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark">Description</label>
                            <textarea name="description" id="editor" class="form-control"><?= htmlspecialchars($brand['description']) ?></textarea>
                        </div>

                        <hr class="my-5">
                        <div class="bg-light p-4 rounded-3 border">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6 class="mb-0 font-weight-bold text-primary"><i class="fas fa-search me-2"></i> SEO & Meta Information</h6>
                                <button type="button" id="generateSEO" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-magic me-1"></i> Regenerate SEO
                                </button>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label class="small font-weight-bold">SEO Meta Title</label>
                                        <input type="text" name="seo_title" id="seo_title" class="form-control" value="<?= htmlspecialchars($brand['seo_title']) ?>">
                                    </div>
                                    <div class="form-group mb-3">
                                        <label class="small font-weight-bold">Meta Keywords</label>
                                        <textarea name="meta_keywords" id="meta_keywords" class="form-control" rows="2"><?= htmlspecialchars($brand['meta_keywords']) ?></textarea>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group mb-3">
                                        <label class="small font-weight-bold">Meta Description</label>
                                        <textarea name="meta_description" id="meta_description" class="form-control" rows="5"><?= htmlspecialchars($brand['meta_description']) ?></textarea>
                                    </div>
                                </div>
                                <div class="col-12 mt-3">
                                    <div class="form-group mb-0">
                                        <label class="small font-weight-bold">JSON-LD SEO Schema (JSON Format)</label>
                                        <textarea name="seo_schema" id="seo_schema" class="form-control text-muted" style="font-family: monospace; font-size: 0.85rem;" rows="8"><?= htmlspecialchars($brand['seo_schema']) ?></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mt-5 text-end">
                            <a href="brand-management.php" class="btn btn-light px-5 me-2">Cancel</a>
                            <button type="submit" class="btn btn-success px-5 shadow-sm rounded-pill">
                                <i class="fas fa-save me-1"></i> Update Car Brand
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<?= $adminUrl ?>../vendor/ckeditor/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function() {
    if (typeof CKEDITOR !== 'undefined') {
        CKEDITOR.replace('editor', { height: 300 });
    }

    $('#logoInput').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#logo-preview').html('<img src="' + e.target.result + '" style="max-width: 100%; max-height: 100%; object-fit: contain;">');
            }
            reader.readAsDataURL(file);
        }
    });

    $('#generateSEO').on('click', function() {
        const name = $('#brandName').val();
        const tagline = $('#brandTagline').val();
        $.ajax({
            url: 'api/car_brand_actions.php',
            type: 'GET',
            data: { action: 'generate_seo', name: name, tagline: tagline },
            success: function(res) {
                if (res.success) {
                    $('#seo_title').val(res.data.title);
                    $('#meta_description').val(res.data.description);
                    $('#meta_keywords').val(res.data.keywords);
                    $('#seo_schema').val(res.data.schema);
                }
            }
        });
    });

    $('#editCarBrandForm').on('submit', function(e) {
        e.preventDefault();
        for (instance in CKEDITOR.instances) CKEDITOR.instances[instance].updateElement();

        const formData = new FormData(this);
        $.ajax({
            url: 'api/car_brand_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend: function() {
                $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i> Updating...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire({ icon: 'success', title: 'Success!', text: res.message, timer: 2000, showConfirmButton: false }).then(() => {
                        window.location.href = 'brand-management.php';
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            complete: function() {
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-save me-1"></i> Update Car Brand');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
