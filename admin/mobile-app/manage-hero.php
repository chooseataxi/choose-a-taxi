<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch existing slides
$stmt = $pdo->query("SELECT * FROM hero_slides ORDER BY id DESC");
$slides = $stmt->fetchAll();

$page_title = "Manage Mobile Hero Slides";
?>

<style>
    .hero-preview { width: 100%; height: 160px; object-fit: cover; border-radius: 12px; }
    .hero-card { transition: all 0.3s ease; border: none; }
    .hero-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; }
    .upload-box { border: 2px dashed #ddd; border-radius: 15px; padding: 40px; text-align: center; cursor: pointer; transition: 0.3s; }
    .upload-box:hover { border-color: #007bff; background: #f8f9fa; }
    .hero-size-badge { position: absolute; top: 10px; right: 10px; background: rgba(0,0,0,0.6); color: white; padding: 2px 8px; border-radius: 4px; font-size: 10px; }
</style>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-images me-2 text-primary"></i>Mobile App Hero Slides</h1>
            </div>
            <div class="col-sm-6 text-end">
                <button class="btn btn-primary rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#addHeroModal">
                    <i class="fas fa-plus me-1"></i> Add New Slide
                </button>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="alert alert-info border-0 shadow-sm rounded-4 d-flex align-items-center">
            <i class="fas fa-info-circle fa-2x me-3"></i>
            <div>
                <h6 class="mb-1 fw-bold">Recommended Image Size</h6>
                <p class="small mb-0">For best display in the mobile app, use images with <b>1200 x 600 px</b> (2:1 Ratio) and keep text centered.</p>
            </div>
        </div>

        <div class="row mt-4">
            <?php if (empty($slides)): ?>
                <div class="col-12 text-center py-5">
                    <img src="../../assets/no-data.png" alt="No data" style="width: 150px; opacity: 0.5;">
                    <h5 class="text-muted mt-3">No hero slides found. Add your first one!</h5>
                </div>
            <?php else: ?>
                <?php foreach ($slides as $s): ?>
                    <div class="col-md-4 mb-4">
                        <div class="card hero-card shadow-sm rounded-4 overflow-hidden position-relative">
                            <span class="hero-size-badge">1200x600</span>
                            <img src="../../<?= $s['image_path'] ?>" class="hero-preview" alt="Hero Slide">
                            <div class="card-body p-3">
                                <h6 class="fw-bold text-truncate mb-1"><?= htmlspecialchars($s['title'] ?: 'Untitled Slide') ?></h6>
                                <p class="text-muted small text-truncate mb-3"><?= htmlspecialchars($s['link_url'] ?: 'No target link') ?></p>
                                
                                <div class="d-flex justify-content-between align-items-center mt-auto border-top pt-3">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input toggle-status" type="checkbox" data-id="<?= $s['id'] ?>" <?= $s['status'] === 'Active' ? 'checked' : '' ?>>
                                        <label class="form-check-label small"><?= $s['status'] ?></label>
                                    </div>
                                    <button class="btn btn-outline-danger btn-sm rounded-circle delete-hero" data-id="<?= $s['id'] ?>">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>
</div>

<!-- Add Hero Modal -->
<div class="modal fade" id="addHeroModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">Add New Hero Slide</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="addHeroForm" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="modal-body py-4">
                    <div class="mb-4">
                        <label class="form-label small fw-bold text-muted text-uppercase">Slide Title (Optional)</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g. Special Discount">
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label small fw-bold text-muted text-uppercase">Target Link / URL (Optional)</label>
                        <input type="text" name="link_url" class="form-control" placeholder="https://...">
                    </div>

                    <div class="mb-0">
                        <label class="form-label small fw-bold text-muted text-uppercase">Banner Image (Required)</label>
                        <div class="upload-box" onclick="$('#heroImage').click()">
                            <i class="fas fa-cloud-upload-alt fa-3x text-primary mb-2"></i>
                            <p class="mb-0 small text-muted">Click to upload 1200x600 image</p>
                            <input type="file" name="image" id="heroImage" class="d-none" accept="image/*" required>
                        </div>
                        <div id="imagePreviewContainer" class="mt-3 d-none">
                            <img id="imgPreview" src="#" class="img-fluid rounded-3 border">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light px-4 rounded-pill" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary px-4 rounded-pill" id="saveBtn">Upload Slide</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
    });

    // Image Preview
    $('#heroImage').change(function() {
        const file = this.files[0];
        if (file) {
            let reader = new FileReader();
            reader.onload = function(e) {
                $('#imgPreview').attr('src', e.target.result);
                $('#imagePreviewContainer').removeClass('d-none');
            }
            reader.readAsDataURL(file);
        }
    });

    // Add Hero
    $('#addHeroForm').submit(function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        const btn = $('#saveBtn');
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Uploading...');

        $.ajax({
            url: 'api/hero_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            success: function(res) {
                if (res.success) {
                    Swal.fire('Success!', res.message, 'success').then(() => location.reload());
                } else {
                    Swal.fire('Error', res.message, 'error');
                    btn.prop('disabled', false).text('Upload Slide');
                }
            },
            error: function(xhr) {
                console.error(xhr.responseText);
                Swal.fire('Error', 'Server error or session expired. Please try again.', 'error');
                btn.prop('disabled', false).text('Upload Slide');
            }
        });
    });

    // Delete Hero
    $('.delete-hero').click(function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete this slide?',
            text: "It will be removed from the mobile app dashboard.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/hero_actions.php', { action: 'delete', id: id }, function(res) {
                    if (res.success) Swal.fire('Deleted!', res.message, 'success').then(() => location.reload());
                    else Swal.fire('Error', res.message, 'error');
                }, 'json');
            }
        });
    });

    // Toggle Status
    $('.toggle-status').change(function() {
        const id = $(this).data('id');
        $.post('api/hero_actions.php', { action: 'toggle_status', id: id }, function(res) {
            if (res.success) {
                Toast.fire({ icon: 'success', title: res.message });
                setTimeout(() => location.reload(), 1000);
            } else {
                Swal.fire('Error', res.message, 'error');
            }
        }, 'json');
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
