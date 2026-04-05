<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Add New Plan";
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-plus-circle me-2"></i>Add Subscription Plan</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="plan-management.php" class="btn btn-outline-secondary px-4 shadow-sm rounded-pill">
                    <i class="fas fa-arrow-left me-1"></i> Back to Plans
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <form id="addPlanForm" class="row">
            <div class="col-md-8">
                <div class="card shadow-sm border-0 rounded-4 mb-4">
                    <div class="card-body p-4">
                        <div class="mb-4">
                            <label class="form-label fw-bold">Plan Name <span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control form-control-lg rounded-3" placeholder="e.g. Silver Monthly, Gold Yearly" required>
                        </div>
                        
                        <div class="mb-0">
                            <label class="form-label fw-bold">Terms & Conditions <span class="text-muted small">(Use rich text to format)</span></label>
                            <textarea name="terms" id="editor" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card shadow-sm border-0 rounded-4 mb-4">
                    <div class="card-header bg-white border-0 py-3">
                        <h6 class="card-title fw-bold mb-0">Pricing & Duration</h6>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-4">
                            <label class="form-label fw-bold">Plan Price (INR) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">₹</span>
                                <input type="number" step="0.01" name="price" class="form-control form-control-lg" placeholder="0.00" required>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold">Duration Value <span class="text-danger">*</span></label>
                            <input type="number" name="duration_value" class="form-control form-control-lg" placeholder="e.g. 1, 6, 12" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Duration Unit <span class="text-danger">*</span></label>
                            <select name="duration_unit" class="form-select form-select-lg" required>
                                <option value="days">Days</option>
                                <option value="months" selected>Months</option>
                                <option value="years">Years</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Status</label>
                            <select name="status" class="form-select">
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>

                        <hr>
                        
                        <button type="submit" class="btn btn-primary w-100 py-3 rounded-pill shadow fw-bold">
                            <i class="fas fa-save me-2"></i> Create Plan
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- CKEditor Integration -->
<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
<script>
    CKEDITOR.replace('editor', {
        height: 350,
        removeButtons: 'PasteFromWord'
    });

    document.getElementById('addPlanForm').onsubmit = function(e) {
        e.preventDefault();
        const terms = CKEDITOR.instances.editor.getData();
        const formData = new FormData(this);
        formData.set('terms', terms);

        fetch('api/plan-actions.php?action=add', {
            method: 'POST',
            body: formData
        })
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                window.location.href = 'plan-management.php';
            } else {
                alert('Error: ' + data.message);
            }
        });
    };
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
