<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch Partners
$stmt = $pdo->query("SELECT id, full_name, mobile FROM partners WHERE status = 'Active' ORDER BY full_name ASC");
$partners = $stmt->fetchAll();

// Fetch Trip Types
$stmt = $pdo->query("SELECT * FROM trip_types WHERE status = 'Active' ORDER BY name ASC");
$trip_types = $stmt->fetchAll();

// Fetch Car Types
$stmt = $pdo->query("SELECT * FROM car_types WHERE status = 'Active' ORDER BY name ASC");
$car_types = $stmt->fetchAll();

$page_title = "Create New Booking";
?>

<style>
    .form-label { font-size: 0.85rem; font-weight: 700; color: #555; text-transform: uppercase; letter-spacing: 0.5px; }
    .card { border: none; }
    .section-title { font-size: 1.1rem; font-weight: 800; color: #1e3c72; border-left: 4px solid #1e3c72; padding-left: 12px; margin-bottom: 20px; }
    .input-group-text { background-color: #f8f9fa; color: #adb5bd; }
    .form-control:focus, .form-select:focus { border-color: #1e3c72; box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.1); }
    .btn-primary { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); border: none; box-shadow: 0 4px 15px rgba(30, 60, 114, 0.3); }
    .btn-primary:hover { background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%); transform: translateY(-1px); }
    .stop-item { background: #f8f9fa; border-radius: 8px; padding: 10px; margin-bottom: 10px; border: 1px solid #eee; }
</style>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-plus-circle me-2"></i>Create New Booking</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="partner-bookings.php" class="btn btn-outline-secondary btn-sm rounded-pill px-3"><i class="fas fa-arrow-left me-1"></i> Back to List</a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid pb-5">
        <form id="bookingForm" class="row">
            <input type="hidden" name="action" value="create_booking">
            
            <div class="col-lg-8">
                <!-- Trip Information -->
                <div class="card shadow-sm rounded-4 mb-4">
                    <div class="card-body p-4">
                        <h5 class="section-title">Trip Information</h5>
                        
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label">Select Partner (Poster)</label>
                                <select name="partner_id" class="form-select select2" required>
                                    <option value="">Choose a partner...</option>
                                    <?php foreach ($partners as $p): ?>
                                        <option value="<?= $p['id'] ?>"><?= htmlspecialchars($p['full_name']) ?> (<?= $p['mobile'] ?>)</option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Trip Type</label>
                                <select name="booking_type" class="form-select" id="booking_type" required>
                                    <option value="">Select type...</option>
                                    <?php foreach ($trip_types as $tt): ?>
                                        <option value="<?= $tt['name'] ?>"><?= $tt['name'] ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Pickup Location</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt text-success"></i></span>
                                    <input type="text" name="pickup_location" class="form-control" placeholder="Enter pickup address" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Drop Location</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt text-danger"></i></span>
                                    <input type="text" name="drop_location" class="form-control" placeholder="Enter destination address" required>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <label class="form-label mb-0">Route Stops (Optional)</label>
                                    <button type="button" class="btn btn-xs btn-outline-primary rounded-pill px-3" onclick="addStop()"><i class="fas fa-plus me-1"></i> Add Stop</button>
                                </div>
                                <div id="stopsContainer">
                                    <!-- Dynamic stops will appear here -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Schedule Information -->
                <div class="card shadow-sm rounded-4 mb-4">
                    <div class="card-body p-4">
                        <h5 class="section-title">Schedule Information</h5>
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label">Start Date</label>
                                <input type="date" name="start_date" class="form-control" min="<?= date('Y-m-d') ?>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Start Time</label>
                                <input type="time" name="start_time" class="form-control" required>
                            </div>
                            <div id="returnSchedule" class="row g-4 m-0 p-0 d-none">
                                <div class="col-md-6">
                                    <label class="form-label">End Date (Return)</label>
                                    <input type="date" name="end_date" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">End Time (Return)</label>
                                    <input type="time" name="end_time" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Extras & Notes -->
                <div class="card shadow-sm rounded-4 mb-4">
                    <div class="card-body p-4">
                        <h5 class="section-title">Additional Details</h5>
                        <div class="row g-4">
                            <div class="col-12">
                                <label class="form-label">Special Preferences</label>
                                <div class="d-flex flex-wrap gap-3 p-3 bg-light rounded-3 border border-dashed">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="preferences[]" value="AC" id="prefAC" checked>
                                        <label class="form-check-label" for="prefAC">AC</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="preferences[]" value="Carrier" id="prefCarrier">
                                        <label class="form-check-label" for="prefCarrier">Luggage Carrier</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="preferences[]" value="Pet Friendly" id="prefPet">
                                        <label class="form-check-label" for="prefPet">Pet Friendly</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="preferences[]" value="Clean Car" id="prefClean" checked>
                                        <label class="form-check-label" for="prefClean">Clean & Sanitized</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="preferences[]" value="Fastag" id="prefFastag" checked>
                                        <label class="form-check-label" for="prefFastag">Fastag Available</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Internal Admin Note / Trip Instructions</label>
                                <textarea name="note" class="form-control" rows="4" placeholder="Mention any specific requirements for the driver or partner..."></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Vehicle & Pricing Card -->
                <div class="card shadow-sm rounded-4 mb-4 sticky-top" style="top: 20px;">
                    <div class="card-body p-4">
                        <h5 class="section-title">Vehicle & Pricing</h5>
                        
                        <div class="mb-4">
                            <label class="form-label">Vehicle Type Required</label>
                            <select name="car_type" class="form-select" required>
                                <option value="">Select car type...</option>
                                <?php foreach ($car_types as $ct): ?>
                                    <option value="<?= $ct['id'] ?>"><?= $ct['name'] ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Pricing Model</label>
                            <div class="btn-group w-100 mb-3" role="group">
                                <input type="radio" class="btn-check" name="pricing_option" id="priceFixed" value="fixed" checked>
                                <label class="btn btn-outline-primary" for="priceFixed">Fixed Price</label>
                                
                                <input type="radio" class="btn-check" name="pricing_option" id="priceQuote" value="quote">
                                <label class="btn btn-outline-primary" for="priceQuote">Quote Based</label>
                            </div>
                        </div>

                        <div id="pricingFields">
                            <div class="mb-4">
                                <label class="form-label">Total Fare (₹)</label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" name="total_amount" class="form-control fw-bold" placeholder="0.00">
                                </div>
                                <small class="text-muted mt-1 d-block"><i class="fas fa-info-circle me-1"></i> Customer will pay this amount.</small>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Admin Commission (₹)</label>
                                <div class="input-group">
                                    <span class="input-group-text">₹</span>
                                    <input type="number" name="commission" class="form-control" placeholder="0.00">
                                </div>
                                <small class="text-muted mt-1 d-block"><i class="fas fa-percentage me-1"></i> Partner markup / service fee.</small>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-6">
                                <label class="form-label">Toll Tax</label>
                                <select name="toll_tax" class="form-select form-select-sm">
                                    <option value="Included">Included</option>
                                    <option value="Excluded">Excluded</option>
                                    <option value="As per actual">As per actual</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Parking</label>
                                <select name="parking" class="form-select form-select-sm">
                                    <option value="Included">Included</option>
                                    <option value="Excluded">Excluded</option>
                                    <option value="As per actual">As per actual</option>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4">

                        <button type="submit" class="btn btn-primary btn-lg w-100 py-3 rounded-3 shadow" id="submitBtn">
                            <i class="fas fa-paper-plane me-2"></i> POST BOOKING NOW
                        </button>
                        <p class="text-center text-muted small mt-3 mb-0">This trip will be visible in the marketplace immediately.</p>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
let stopCount = 0;

function addStop() {
    stopCount++;
    const html = `
        <div class="stop-item d-flex align-items-center gap-2" id="stop_${stopCount}">
            <div class="flex-fill">
                <input type="text" name="stops[]" class="form-control form-control-sm border-0 bg-transparent" placeholder="Enter stop point location..." required>
            </div>
            <button type="button" class="btn btn-link text-danger p-0 px-2" onclick="removeStop(${stopCount})"><i class="fas fa-times"></i></button>
        </div>
    `;
    $('#stopsContainer').append(html);
}

function removeStop(id) {
    $(`#stop_${id}`).remove();
}

$(document).ready(function() {
    // Select2 Initialization
    $('.select2').select2({
        theme: 'bootstrap-5',
        placeholder: 'Search and select a partner...'
    });

    // Handle Trip Type Changes
    $('#booking_type').change(function() {
        const type = $(this).val();
        if (type === 'Round Trip') {
            $('#returnSchedule').removeClass('d-none');
            $('#returnSchedule input').prop('required', true);
        } else {
            $('#returnSchedule').addClass('d-none');
            $('#returnSchedule input').prop('required', false);
        }
    });

    // Handle Pricing Option Changes
    $('input[name="pricing_option"]').change(function() {
        if ($(this).val() === 'quote') {
            $('#pricingFields').fadeOut(200);
            $('#pricingFields input').prop('required', false);
        } else {
            $('#pricingFields').fadeIn(200);
            $('#pricingFields input').prop('required', true);
        }
    });

    // Form Submission
    $('#bookingForm').submit(function(e) {
        e.preventDefault();
        const btn = $('#submitBtn');
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i> PROCESSING...');

        $.ajax({
            url: 'api/booking_actions.php',
            type: 'POST',
            data: $(this).serialize(),
            success: function(res) {
                if (res.success) {
                    Swal.fire({
                        title: 'Booking Created!',
                        text: res.message,
                        icon: 'success',
                        confirmButtonText: 'View All Bookings'
                    }).then(() => {
                        window.location.href = 'partner-bookings.php';
                    });
                } else {
                    Swal.fire('Error', res.message, 'error');
                    btn.prop('disabled', false).html('<i class="fas fa-paper-plane me-2"></i> POST BOOKING NOW');
                }
            },
            error: function() {
                Swal.fire('System Error', 'Something went wrong. Please try again.', 'error');
                btn.prop('disabled', false).html('<i class="fas fa-paper-plane me-2"></i> POST BOOKING NOW');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
