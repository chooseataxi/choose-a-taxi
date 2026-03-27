<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';
?>

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 font-weight-bold">Add New Trip Type</h5>
                    <a href="index.php" class="btn btn-sm btn-secondary shadow-sm">
                        <i class="fas fa-arrow-left fa-sm mr-1"></i> Back to List
                    </a>
                </div>
                <div class="card-body">
                    <form id="addTripTypeForm">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="form-group mb-4">
                            <label class="font-weight-bold">Trip Type Name</label>
                            <input type="text" name="name" class="form-control" placeholder="e.g., One Way, Outstation" required>
                            <small class="text-muted">Enter a unique name for this trip category.</small>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold">Description</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="Brief description of this trip type..."></textarea>
                        </div>

                        <div class="form-group mb-0">
                            <button type="submit" class="btn btn-primary px-4 shadow-sm">
                                <i class="fas fa-plus-circle mr-1"></i> Create Trip Type
                            </button>
                            <button type="reset" class="btn btn-light px-4 ml-2">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#addTripTypeForm').on('submit', function(e) {
        e.preventDefault();
        const formData = $(this).serialize();

        $.ajax({
            url: 'api/trip_type_actions.php',
            type: 'POST',
            data: formData,
            beforeSend: function() {
                $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Creating...');
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
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-plus-circle mr-1"></i> Create Trip Type');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
