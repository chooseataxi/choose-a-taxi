<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$id = $_GET['id'] ?? 0;
if (!$id) {
    echo "<script>window.location.href='car-management.php';</script>";
    exit;
}

$page_title = "Edit Professional Car";
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark font-weight-bold"><i class="fas fa-edit me-2 text-primary"></i>Edit Car Information</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="car-management.php" class="btn btn-outline-dark btn-sm px-3 shadow-sm rounded-pill">
                    <i class="fas fa-arrow-left me-1"></i> Back to Fleet
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12">
                <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-primary py-3">
                        <h5 class="card-title mb-0 text-white font-weight-bold">Vehicle Modification Wizard</h5>
                    </div>
                    <div class="card-body p-0">
                        <form id="editCarForm" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<?= $id ?>">
                            
                            <!-- Wizard Navigation -->
                            <div class="wizard-nav d-flex border-bottom bg-light">
                                <div class="wizard-step-tab active" data-step="1">
                                    <span class="step-num">1</span>
                                    <span class="step-text">Basic Info</span>
                                </div>
                                <div class="wizard-step-tab" data-step="2">
                                    <span class="step-num">2</span>
                                    <span class="step-text">Pricing</span>
                                </div>
                                <div class="wizard-step-tab" data-step="3">
                                    <span class="step-num">3</span>
                                    <span class="step-text">Media</span>
                                </div>
                                <div class="wizard-step-tab" data-step="4">
                                    <span class="step-num">4</span>
                                    <span class="step-text">SEO & Desc</span>
                                </div>
                            </div>

                            <div class="p-4">
                                <!-- Step 1: Basic Info -->
                                <div class="step-content active" id="step-1">
                                    <div class="row g-4">
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold">Car Brand *</label>
                                            <select name="brand_id" id="brand_id" class="form-select form-control-lg border-2 shadow-sm" required>
                                                <option value="">Loading Brands...</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold">Car Category/Type *</label>
                                            <select name="type_id" id="type_id" class="form-select form-control-lg border-2 shadow-sm" required>
                                                <option value="">Loading Types...</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold">Model Name *</label>
                                            <input type="text" name="name" id="car_name" class="form-control form-control-lg border-2 shadow-sm" placeholder="e.g. Innova Hycross" required>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label fw-bold">Variant/Short Model Info</label>
                                            <input type="text" name="model" id="car_model_info" class="form-control border-2 shadow-sm" placeholder="e.g. 2024 V-Series Hybrid">
                                        </div>
                                        <div class="col-md-12 mt-4">
                                            <h6 class="fw-bold text-muted border-bottom pb-2">Service Inclusions/Exclusions</h6>
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label class="small fw-bold">Toll Charges</label>
                                                    <select name="include_toll" id="include_toll" class="form-select border-2">
                                                        <option value="Included">Included</option>
                                                        <option value="Excluded">Excluded</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="small fw-bold">Tax</label>
                                                    <select name="include_tax" id="include_tax" class="form-select border-2">
                                                        <option value="Included">Included</option>
                                                        <option value="Excluded">Excluded</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="small fw-bold">Driver Allowance</label>
                                                    <select name="include_driver_allowance" id="include_driver_allowance" class="form-select border-2">
                                                        <option value="Included">Included</option>
                                                        <option value="Excluded">Excluded</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="small fw-bold">Night Charges</label>
                                                    <select name="include_night_charges" id="include_night_charges" class="form-select border-2">
                                                        <option value="Included">Included</option>
                                                        <option value="Excluded">Excluded</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="small fw-bold">Parking</label>
                                                    <select name="include_parking" id="include_parking" class="form-select border-2">
                                                        <option value="Included">Included</option>
                                                        <option value="Excluded">Excluded</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-5 text-end">
                                        <button type="button" class="btn btn-primary px-5 py-2 rounded-pill shadow-sm next-step">Next: Pricing <i class="fas fa-arrow-right ms-2"></i></button>
                                    </div>
                                </div>

                                <!-- Step 2: Pricing -->
                                <div class="step-content d-none" id="step-2">
                                    <div class="row g-4">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-primary">Primary Trip Type *</label>
                                            <select name="trip_type_id" id="trip_type_id" class="form-select form-control-lg border-primary border-2 shadow-sm" required>
                                                <option value="">Loading Trip Types...</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-success">Base Fare (INR) / Flag Fall *</label>
                                            <div class="input-group input-group-lg shadow-sm">
                                                <span class="input-group-text bg-success text-white border-0">₹</span>
                                                <input type="number" name="base_fare" id="base_fare" class="form-control border-2" placeholder="0.00" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">Minimum Kilometers Included *</label>
                                            <div class="input-group shadow-sm">
                                                <input type="number" name="min_km" id="min_km" class="form-control border-2" placeholder="e.g. 100" required>
                                                <span class="input-group-text bg-light border-2">KM</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-danger">Extra Price Per KM (INR) *</label>
                                            <div class="input-group shadow-sm">
                                                <span class="input-group-text bg-danger text-white border-0">₹</span>
                                                <input type="number" name="extra_km_price" id="extra_km_price" class="form-control border-2" placeholder="e.g. 15.00" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-5 d-flex justify-content-between">
                                        <button type="button" class="btn btn-light px-5 py-2 rounded-pill prev-step"><i class="fas fa-arrow-left me-2"></i> Back</button>
                                        <button type="button" class="btn btn-primary px-5 py-2 rounded-pill shadow-sm next-step">Next: Media <i class="fas fa-arrow-right ms-2"></i></button>
                                    </div>
                                </div>

                                <!-- Step 3: Media -->
                                <div class="step-content d-none" id="step-3">
                                    <div class="row g-4">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="form-label fw-bold">Vehicle Image (Leave blank to keep current)</label>
                                                <div class="dropzone-lite border-2 border-dashed rounded-4 p-4 text-center bg-light mb-3" id="image-dropzone" style="cursor: pointer;">
                                                    <div id="image-preview" class="mb-2">
                                                        <i class="fas fa-cloud-upload-alt fa-3x text-muted"></i>
                                                    </div>
                                                    <p class="text-muted small mb-0">Click to Replace or drag & drop high-quality PNG/JPG</p>
                                                </div>
                                                <input type="file" name="car_image" id="car_image" style="position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0,0,0,0); border: 0;" accept="image/*">
                                                <div id="current-image-info" class="small text-muted mt-2"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-4">
                                                <label class="form-label fw-bold">YouTube Video URL</label>
                                                <div class="input-group shadow-sm">
                                                    <span class="input-group-text bg-danger text-white"><i class="fab fa-youtube"></i></span>
                                                    <input type="url" name="youtube_url" id="youtube_url" class="form-control" placeholder="https://youtube.com/watch?v=...">
                                                </div>
                                            </div>
                                            <div id="yt-preview-container" class="d-none">
                                                <label class="small fw-bold text-muted">Video Preview</label>
                                                <div class="ratio ratio-16x9 rounded-3 shadow-sm overflow-hidden">
                                                    <iframe id="yt-preview" src="" frameborder="0" allowfullscreen></iframe>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-5 d-flex justify-content-between">
                                        <button type="button" class="btn btn-light px-5 py-2 rounded-pill prev-step"><i class="fas fa-arrow-left me-2"></i> Back</button>
                                        <button type="button" class="btn btn-primary px-5 py-2 rounded-pill shadow-sm next-step">Next: SEO <i class="fas fa-arrow-right ms-2"></i></button>
                                    </div>
                                </div>

                                <!-- Step 4: SEO & Description -->
                                <div class="step-content d-none" id="step-4">
                                    <div class="row g-4">
                                        <div class="col-12">
                                            <label class="form-label fw-bold">Vehicle Detailed Description</label>
                                            <textarea name="description" id="car_description" class="form-control"></textarea>
                                        </div>
                                        <div class="col-12 mt-5">
                                            <div class="bg-gray-100 p-4 rounded-4 border-2 border-dashed">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h6 class="mb-0 fw-bold text-dark"><i class="fas fa-search-plus me-2 text-primary"></i> Search Engine Optimization (SEO)</h6>
                                                    <button type="button" id="btn-auto-seo" class="btn btn-xs btn-outline-primary rounded-pill px-3">
                                                        <i class="fas fa-magic me-1"></i> Regenerate
                                                    </button>
                                                </div>
                                                <div class="row g-3">
                                                    <div class="col-md-6">
                                                        <label class="small fw-bold">SEO Meta Title</label>
                                                        <input type="text" name="seo_title" id="seo_title" class="form-control form-control-sm">
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="small fw-bold">Meta Keywords</label>
                                                        <input type="text" name="meta_keywords" id="meta_keywords" class="form-control form-control-sm">
                                                    </div>
                                                    <div class="col-md-12">
                                                        <label class="small fw-bold">Meta Description</label>
                                                        <textarea name="seo_description" id="seo_description" class="form-control form-control-sm" rows="3"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-5 d-flex justify-content-between align-items-center">
                                        <button type="button" class="btn btn-light px-5 py-2 rounded-pill prev-step"><i class="fas fa-arrow-left me-2"></i> Back</button>
                                        <button type="submit" class="btn btn-primary px-5 py-3 rounded-pill shadow-lg fw-bold">
                                            <i class="fas fa-save me-2"></i> SAVE MODIFICATIONS
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .wizard-nav { padding: 0 10px; }
    .wizard-step-tab { 
        flex: 1; padding: 20px 10px; text-align: center; cursor: pointer;
        opacity: 0.5; transition: all 0.3s;
        border-bottom: 3px solid transparent;
    }
    .wizard-step-tab.active { 
        opacity: 1; border-bottom: 3px solid var(--primary-green); 
        background: #fff;
    }
    .wizard-step-tab.completed .step-num { background: #28a745; color: white; }
    .step-num {
        display: inline-flex; width: 28px; height: 28px; background: #ddd;
        border-radius: 50%; align-items: center; justify-content: center;
        margin-right: 8px; font-weight: bold; font-size: 0.8rem;
    }
    .step-text { font-weight: 600; font-size: 0.9rem; }
    .dropzone-lite:hover { background: #fff !important; color: var(--primary-green) !important; cursor: pointer; border-color: var(--primary-green) !important; }
</style>

<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>

<script>
$(document).ready(function() {
    // 1. Initialize Components
    CKEDITOR.replace('car_description', { height: 250 });

    // 2. Fetch Dropdown Data & Car Details
    async function initPage() {
        const dropRes = await $.get('api/car_actions.php', { action: 'get_dropdown_data' });
        if (dropRes.success) {
            let brandsHtml = '<option value="">Select Brand</option>';
            dropRes.brands.forEach(b => brandsHtml += `<option value="${b.id}">${b.name}</option>`);
            $('#brand_id').html(brandsHtml);

            let typesHtml = '<option value="">Select Category</option>';
            dropRes.types.forEach(t => typesHtml += `<option value="${t.id}">${t.name}</option>`);
            $('#type_id').html(typesHtml);

            let tripsHtml = '<option value="">Select Trip Type</option>';
            dropRes.trip_types.forEach(tr => tripsHtml += `<option value="${tr.id}">${tr.name}</option>`);
            $('#trip_type_id').html(tripsHtml);
            
            // Now fetch car details
            fetchCarDetails();
        }
    }

    function fetchCarDetails() {
        $.get('api/car_actions.php', { action: 'get', id: <?= $id ?> }, function(res) {
            if (res.success) {
                const car = res.data;
                $('#brand_id').val(car.brand_id);
                $('#type_id').val(car.type_id);
                $('#trip_type_id').val(car.trip_type_id);
                $('#car_name').val(car.name);
                $('#car_model_info').val(car.model);
                $('#base_fare').val(car.base_fare);
                $('#min_km').val(car.min_km);
                $('#extra_km_price').val(car.extra_km_price);
                $('#youtube_url').val(car.youtube_url).trigger('input');
                $('#seo_title').val(car.seo_title);
                $('#seo_description').val(car.seo_description);
                $('#meta_keywords').val(car.meta_keywords);
                CKEDITOR.instances.car_description.setData(car.description);

                // Set inclusion fields
                $('#include_toll').val(car.include_toll);
                $('#include_tax').val(car.include_tax);
                $('#include_driver_allowance').val(car.include_driver_allowance);
                $('#include_night_charges').val(car.include_night_charges);
                $('#include_parking').val(car.include_parking);

                if (car.image) {
                     $('#image-preview').html(`<img src="../../uploads/cars/${car.image}" style="max-height:100px;" class="rounded shadow-sm">`);
                     $('#current-image-info').text('Current file: ' + car.image);
                }
            } else {
                Swal.fire('Error', res.message, 'error').then(() => { window.location.href = 'car-management.php'; });
            }
        });
    }

    initPage();

    // 3. Wizard & Media Handlers (Same as Add Car)
    $('.next-step').click(function() {
        const currentStep = $(this).closest('.step-content');
        const nextStep = currentStep.next('.step-content');
        const stepId = nextStep.attr('id').split('-')[1];
        currentStep.addClass('d-none');
        nextStep.removeClass('d-none');
        $(`.wizard-step-tab`).removeClass('active').filter(`[data-step="${stepId}"]`).addClass('active');
    });

    $('.prev-step').click(function() {
        const currentStep = $(this).closest('.step-content');
        const prevStep = currentStep.prev('.step-content');
        const stepId = prevStep.attr('id').split('-')[1];
        currentStep.addClass('d-none');
        prevStep.removeClass('d-none');
        $(`.wizard-step-tab`).removeClass('active').filter(`[data-step="${stepId}"]`).addClass('active');
    });

    $('#image-dropzone').on('click', function(e) { 
        e.preventDefault();
        $('#car_image').trigger('click'); 
    });
    $('#car_image').change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) { $('#image-preview').html(`<img src="${e.target.result}" style="max-height:100px;" class="rounded shadow-sm">`); }
            reader.readAsDataURL(file);
        }
    });

    $('#youtube_url').on('input', function() {
        const url = $(this).val();
        const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
        const match = url.match(regExp);
        if (match && match[2].length == 11) {
            $('#yt-preview').attr('src', 'https://www.youtube.com/embed/' + match[2]);
            $('#yt-preview-container').removeClass('d-none');
        } else {
            $('#yt-preview-container').addClass('d-none');
        }
    });

    // 4. Auto SEO
    $('#btn-auto-seo').click(function() {
        const name = $('#car_name').val();
        const brand = $('#brand_id option:selected').text();
        if(!name || brand === "Select Brand") {
             Swal.fire('Error', 'Please fill name and brand first', 'warning');
             return;
        }
        $.get('api/car_actions.php', { action: 'generate_seo', name: name, brand_name: brand }, function(res) {
             if(res.success) {
                  $('#seo_title').val(res.data.title);
                  $('#seo_description').val(res.data.description);
                  $('#meta_keywords').val(res.data.keywords);
             }
        });
    });

    // 5. Form Submission
    $('#editCarForm').on('submit', function(e) {
        e.preventDefault();
        for (instance in CKEDITOR.instances) CKEDITOR.instances[instance].updateElement();

        const formData = new FormData(this);
        $.ajax({
            url: 'api/car_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend: function() {
                Swal.fire({ title: 'Updating...', allowOutsideClick: false, didOpen: () => { Swal.showLoading(); } });
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire('Modified!', res.message, 'success').then(() => { window.location.href = 'car-management.php'; });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
 Westchester
 Westchester
 Westchester
