<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-xl-9">
            <div class="card shadow border-0 mb-4">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark">Add New Car Type</h5>
                    <a href="type-management.php" class="btn btn-yellow-black btn-sm shadow-sm px-3 ms-auto">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Back to List
                    </a>
                </div>
                <div class="card-body">
                    <form id="addCarTypeForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="row mb-4">
                            <div class="col-md-12 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Car Type Name *</label>
                                <input type="text" name="name" class="form-control" placeholder="e.g. Sedan, SUV, Minivan" required>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Max Passengers *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-users"></i></span>
                                    <input type="number" name="passengers" class="form-control" value="4" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="font-weight-bold text-dark mb-2">Max Luggage (Number of Suitcases) *</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-suitcase-rolling"></i></span>
                                    <input type="number" name="luggage" class="form-control" value="2" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Representative Image</label>
                            <div class="d-flex align-items-center">
                                <div id="image-preview" class="border rounded bg-light d-flex align-items-center justify-content-center me-3" style="width: 120px; height: 120px; overflow: hidden;">
                                    <i class="fas fa-image text-muted fa-3x"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <input type="file" name="image" id="imageInput" class="form-control" accept="image/*">
                                    <small class="text-muted">Upload a high-quality transparent PNG of the car type.</small>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mt-5 text-end">
                            <button type="reset" class="btn btn-light px-5 me-2">Clear Form</button>
                            <button type="submit" class="btn btn-primary px-5 shadow-sm rounded-pill">
                                <i class="fas fa-check-circle me-1"></i> Save Car Type
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

    $('#addCarTypeForm').on('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        $.ajax({
            url: 'api/car_type_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend: function() {
                $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i> Saving...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire({ icon: 'success', title: 'Success!', text: res.message, timer: 2000, showConfirmButton: false }).then(() => {
                        window.location.href = 'type-management.php';
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            complete: function() {
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-check-circle me-1"></i> Save Car Type');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
