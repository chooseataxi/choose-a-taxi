<?php
/**
 * Trip Search Results Page
 */
require_once 'includes/db.php';
require_once 'includes/header.php';

// 1. Capture Inputs
$trip_type = $_GET['trip_type'] ?? 'One Way';
$pickup    = $_GET['pickup'] ?? '';
$drop      = $_GET['drop'] ?? '';
$stops     = $_GET['stops'] ?? [];
$date      = $_GET['date'] ?? '';
$time      = $_GET['time'] ?? '';

// 2. Calculate Distance using Google Directions API (more accurate than Distance Matrix)
$api_key = $_ENV['GOOGLE_MAPS_KEY'] ?? 'AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY';
$total_distance_km = 0;

/**
 * Get driving distance (km) between two points using Google Directions API.
 * Returns the distance of the first returned route leg — this matches what
 * Google Maps shows because it uses the same routing engine.
 */
function getDistanceBetweenPoints($origin, $destination, $key) {
    if (empty($origin) || empty($destination)) return 0;

    $url = "https://maps.googleapis.com/maps/api/directions/json?"
         . "origin=" . urlencode($origin)
         . "&destination=" . urlencode($destination)
         . "&mode=driving"
         . "&key=" . $key;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);
    $response = curl_exec($ch);
    curl_close($ch);

    $data = json_decode($response, true);

    // Sum all legs (handles waypoints) — value is in metres
    $metres = 0;
    if (!empty($data['routes'][0]['legs'])) {
        foreach ($data['routes'][0]['legs'] as $leg) {
            $metres += $leg['distance']['value'] ?? 0;
        }
    }
    return $metres > 0 ? $metres / 1000 : 0;
}

// Sequence: Pickup -> Stop 1 -> Stop 2 -> Drop
$points = array_merge([$pickup], (array)$stops, [$drop]);
for ($i = 0; $i < count($points) - 1; $i++) {
    $total_distance_km += getDistanceBetweenPoints($points[$i], $points[$i + 1], $api_key);
}

// Add a 15% real-world route margin. 
// Google API city-to-city is often shorter than actual door-to-door driving distance.
$total_distance_km = ceil($total_distance_km * 1.18);

// Round trip: double the distance
if ($trip_type === 'Round Trip') {
    $total_distance_km = $total_distance_km * 2;
}

// Final sanity check
if ($total_distance_km < 1) $total_distance_km = 1;

// 3. Fetch Available Cars matching the trip type
$cars_stmt = $pdo->prepare("SELECT c.*, ct.name as type_name, ct.image as type_image, ct.passengers as max_seats 
                            FROM cars c 
                            JOIN car_types ct ON c.type_id = ct.id 
                            JOIN trip_types tt ON c.trip_type_id = tt.id 
                            WHERE c.status = 'Active' AND tt.name LIKE ?");
$cars_stmt->execute(['%' . $trip_type . '%']);
$cars = $cars_stmt->fetchAll();
?>

<!-- Custom Results CSS -->
<link rel="stylesheet" href="assets/css/fleet.css">
<link rel="stylesheet" href="assets/css/footer.css">
<style>
    .results-page { background: #fdfdfd; padding: 25px 0; min-height: 80vh; font-family: 'Inter', sans-serif; }
    .ts-header-card { 
        background: #1a1a1a; border-radius: 20px; padding: 25px 35px; margin-bottom: 30px; 
        box-shadow: 0 10px 40px rgba(0,0,0,0.15); color: #fff; position: relative;
    }
    .ts-summary-wrapper { display: flex; align-items: stretch; justify-content: space-between; flex-wrap: wrap; gap: 30px; }
    
    .ts-route-vertical { display: flex; flex-direction: column; gap: 12px; flex: 1; min-width: 300px; position: relative; padding-left: 25px; }
    .ts-route-vertical::before {
        content: ''; position: absolute; left: 4px; top: 10px; bottom: 10px; width: 2px; 
        background: rgba(255,255,255,0.1); border-left: 2px dashed rgba(255,193,7,0.4);
    }
    
    .ts-route-step { display: flex; flex-direction: column; position: relative; }
    .ts-route-step::before {
        content: ''; position: absolute; left: -25px; top: 6px; width: 10px; height: 10px; 
        border-radius: 50%; background: #ffc107; border: 2px solid #1a1a1a; z-index: 2;
    }
    .ts-step-pickup::before { background: #ff4757; box-shadow: 0 0 10px rgba(255,71,87,0.5); }
    .ts-step-drop::before { background: #2ed573; box-shadow: 0 0 10px rgba(46,213,115,0.5); }
    .ts-step-stop::before { background: #ffa502; }
    
    .ts-step-label { font-size: 10px; font-weight: 800; color: #ffc107; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 2px; }
    .ts-step-value { font-size: 14px; font-weight: 600; color: #fff; line-height: 1.4; }

    .ts-side-info { display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end; gap: 15px; }
    .ts-badge-area { display: flex; gap: 10px; align-items: center; }
    .ts-tag { background: #ffc107; color: #000; padding: 5px 15px; border-radius: 8px; font-size: 12px; font-weight: 800; text-transform: uppercase; }
    
    .ts-time-card { background: rgba(255,255,255,0.05); padding: 15px 20px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.1); display: flex; gap: 25px; }
    .ts-info-item { display: flex; flex-direction: column; gap: 4px; }
    .ts-info-item label { font-size: 10px; font-weight: 700; color: #aaa; text-transform: uppercase; }
    .ts-info-item span { font-size: 15px; font-weight: 700; color: #fff; white-space: nowrap; }

    /* T&C Modal */
    .tnc-modal-overlay {
        display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6);
        z-index: 9999; align-items: center; justify-content: center;
        backdrop-filter: blur(4px);
    }
    .tnc-modal-overlay.active { display: flex; }
    .tnc-modal {
        background: #fff; border-radius: 16px; width: 92%; max-width: 680px;
        max-height: 85vh; display: flex; flex-direction: column;
        box-shadow: 0 24px 60px rgba(0,0,0,0.25);
        animation: modalIn 0.25s ease;
    }
    @keyframes modalIn {
        from { opacity: 0; transform: translateY(30px) scale(0.97); }
        to   { opacity: 1; transform: translateY(0) scale(1); }
    }
    .tnc-modal-header {
        display: flex; align-items: center; justify-content: space-between;
        padding: 20px 28px; border-bottom: 1px solid #f0f0f0;
    }
    .tnc-modal-header h4 { margin: 0; font-size: 18px; font-weight: 800; color: #1a1a1a; }
    .tnc-modal-header h4 i { color: #28a745; margin-right: 8px; }
    .tnc-close-btn {
        width: 34px; height: 34px; border-radius: 50%; border: none;
        background: #f5f5f5; cursor: pointer; font-size: 18px; color: #555;
        display: flex; align-items: center; justify-content: center; transition: 0.2s;
    }
    .tnc-close-btn:hover { background: #e0e0e0; color: #000; }
    .tnc-modal-body {
        padding: 24px 28px; overflow-y: auto; flex: 1;
        font-size: 14px; line-height: 1.75; color: #444;
    }
    .tnc-modal-body h1, .tnc-modal-body h2, .tnc-modal-body h3 { color: #1a1a1a; margin-top: 16px; }
    .tnc-modal-body ul, .tnc-modal-body ol { padding-left: 20px; }
    .tnc-modal-body li { margin-bottom: 6px; }
    .tnc-modal-footer {
        padding: 16px 28px; border-top: 1px solid #f0f0f0; text-align: right;
    }
    .tnc-modal-footer button {
        background: #1a1a1a; color: #fff; border: none; padding: 10px 28px;
        border-radius: 8px; font-weight: 700; cursor: pointer; font-size: 14px;
        transition: 0.2s;
    }
    .tnc-modal-footer button:hover { background: #333; }

    .terms-link {
        color: #28a745; text-decoration: none; font-weight: 600; font-size: 13px;
        display: inline-flex; align-items: center; gap: 5px; cursor: pointer;
        transition: color 0.2s;
    }
    .terms-link:hover { color: #1a7c35; text-decoration: underline; }
    .terms-link i { font-size: 12px; }
</style>

<!-- T&C Modal -->
<div class="tnc-modal-overlay" id="tncModalOverlay" onclick="closeTncModal(event)">
    <div class="tnc-modal">
        <div class="tnc-modal-header">
            <h4><i class="fas fa-file-contract"></i> Terms &amp; Conditions</h4>
            <button class="tnc-close-btn" onclick="closeTncModalDirect()">&times;</button>
        </div>
        <div class="tnc-modal-body" id="tncModalBody">
            <p style="color:#999; text-align:center; padding: 40px 0;">No terms &amp; conditions available for this package.</p>
        </div>
        <div class="tnc-modal-footer">
            <button onclick="closeTncModalDirect()">I Understand</button>
        </div>
    </div>
</div>

<div class="results-page">
    <div class="container" style="width: 90%; max-width: 1200px; margin: 0 auto;">
        <!-- Header Info -->
        <div class="ts-header-card">
            <div class="ts-summary-wrapper">
                <!-- Vertical Route Info -->
                <div class="ts-route-vertical">
                    <div class="ts-route-step ts-step-pickup">
                        <span class="ts-step-label">Pickup Location</span>
                        <span class="ts-step-value"><?= htmlspecialchars($pickup) ?></span>
                    </div>

                    <?php 
                    $valid_stops = array_filter((array)$stops);
                    foreach ($valid_stops as $stop): 
                    ?>
                        <div class="ts-route-step ts-step-stop">
                            <span class="ts-step-label">Stop</span>
                            <span class="ts-step-value"><?= htmlspecialchars($stop) ?></span>
                        </div>
                    <?php endforeach; ?>

                    <div class="ts-route-step ts-step-drop">
                        <span class="ts-step-label">Drop Location</span>
                        <span class="ts-step-value"><?= htmlspecialchars($drop) ?></span>
                    </div>
                </div>

                <!-- Side Info -->
                <div class="ts-side-info">
                    <div class="ts-badge-area">
                        <span class="ts-tag"><?= htmlspecialchars($trip_type) ?></span>
                    </div>
                    
                    <div class="ts-time-card">
                        <div class="ts-info-item">
                            <label>Departure Date</label>
                            <span><?= htmlspecialchars($date) ?></span>
                        </div>
                        <div class="ts-info-item" style="border-left: 1px solid rgba(255,255,255,0.1); padding-left: 20px;">
                            <label>Pickup Time</label>
                            <span><?= htmlspecialchars($time) ?></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Fleets (Dynamic Calculation) -->
        <div class="fleet-list">
            <?php foreach ($cars as $car): 
                $dist_float      = (float)$total_distance_km;
                $min_km          = (float)$car['min_km'];
                $base_fare       = (float)$car['base_fare'];
                $extra_km_price  = (float)$car['extra_km_price'];

                // Formula: Base + (Extra Distance * Extra Price)
                $final_price = $base_fare;
                if ($dist_float > $min_km) {
                    $extra_km     = $dist_float - $min_km;
                    $final_price += ($extra_km * $extra_km_price);
                }

                $final_price = round($final_price);
                $random_off  = rand(7, 15);
                $old_price   = round($final_price / (1 - ($random_off / 100)));

                $display_name = strtoupper($car['type_name']);

                if (!empty($car['type_image'])) {
                    $display_image = $car['type_image'];
                } elseif (!empty($car['image'])) {
                    $display_image = 'uploads/cars/' . $car['image'];
                } else {
                    $display_image = 'assets/frontend-images/hero-new-bg.jpeg';
                }

                // Extra km display: admin-defined label or fallback to actual price
                $display_extra_raw = trim($car['display_extra_km_price'] ?? '');
                if (!empty($display_extra_raw)) {
                    $display_extra = htmlspecialchars($display_extra_raw);
                    // If it's purely numeric (e.g. "12"), format it nicely
                    if (is_numeric($display_extra_raw)) {
                        $display_extra = 'Rs. ' . $display_extra_raw . ' /km';
                    } else {
                        // If they didn't include '/km', let's append it so it doesn't look like a flat fee
                        if (stripos($display_extra, 'km') === false) {
                            $display_extra .= ' /km';
                        }
                    }
                } else {
                    $display_extra = 'Rs. ' . $extra_km_price . '/km';
                }

                // T&C content (safe for data attribute)
                $tnc_html = !empty($car['terms_conditions'])
                    ? htmlspecialchars($car['terms_conditions'], ENT_QUOTES, 'UTF-8')
                    : '';
            ?>
            <div class="fleet-horizontal-card">
                <div class="fleet-card-left">
                    <img src="<?= $display_image ?>" alt="<?= $display_name ?>">
                </div>
                <div class="fleet-card-middle">
                    <h3 style="font-weight: 800; color: #333; margin-bottom: 15px;"><?= $display_name ?></h3>
                    <div class="details-grid">
                        <div class="detail-row">
                            <label>Total Trip Distance:</label>
                            <span style="color: #007bff; font-weight: 800;"><?= round($total_distance_km) ?> KMs</span>
                        </div>
                        <div class="detail-row">
                            <label>Extra price / KM:</label>
                            <span style="color: #d33; font-weight: 800;"><?= $display_extra ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Toll:</label>
                            <span style="color: #28a745; font-weight: 800;"><?= $car['include_toll'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Tax:</label>
                            <span style="color: #28a745; font-weight: 800;"><?= $car['include_tax'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Driver allowance:</label>
                            <span style="color: #28a745; font-weight: 800;"><?= $car['include_driver_allowance'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Night charges:</label>
                            <span style="color: #28a745; font-weight: 800;"><?= $car['include_night_charges'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Parking:</label>
                            <span style="color: #d9534f; font-weight: 800;"><?= $car['include_parking'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Seats:</label>
                            <span style="color: #28a745; font-weight: 800;"><?= $car['max_seats'] ?></span>
                        </div>
                    </div>
                    <div class="cancellation-note" style="color: #28a745; font-weight: 600; font-size: 14px; margin-top: 10px;">
                        <i class="fas fa-bolt"></i> Free cancellation until 6 hour before pickup
                    </div>
                </div>
                <div class="fleet-card-right">
                    <div class="price-area" style="text-align: right; margin-bottom: 20px;">
                        <div class="old-price" style="text-decoration: line-through; color: #28a745; font-size: 18px; display: inline-block; margin-right: 10px;">Rs. <?= $old_price ?></div>
                        <div class="current-price" style="color: #28a745; font-size: 32px; font-weight: 900; display: inline-block; vertical-align: middle;">Rs. <?= $final_price ?></div>
                        <div class="discount-badge" style="background: #006b52; color: #fff; padding: 2px 8px; border-radius: 4px; font-size: 14px; font-weight: 700; display: inline-block; margin-left: 10px;"><?= $random_off ?>% Off</div>
                    </div>
                    <a href="login.php?booking_request=1&car_id=<?= $car['id'] ?>&dist=<?= $total_distance_km ?>" class="btn-book-now" style="background: #e3342f; color: #fff; padding: 12px; border-radius: 4px; text-decoration: none; display: block; text-align: center; font-weight: 700; font-size: 18px; margin-bottom: 15px;">Book Now @ Rs. <?= $final_price ?></a>
                    <div style="text-align: center;">
                        <?php if (!empty($car['terms_conditions'])): ?>
                            <a href="#" class="terms-link" onclick="openTncModal(this); return false;" data-tnc="<?= $tnc_html ?>">
                                <i class="fas fa-file-contract"></i> Terms &amp; Conditions
                            </a>
                        <?php else: ?>
                            <span class="terms-link" style="color: #aaa; cursor: default;">
                                <i class="fas fa-file-contract"></i> Terms &amp; Conditions
                            </span>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</div>

<script>
function openTncModal(el) {
    const encoded = el.getAttribute('data-tnc');
    // Decode HTML entities back to HTML string for rendering
    const textarea = document.createElement('textarea');
    textarea.innerHTML = encoded;
    const html = textarea.value;

    document.getElementById('tncModalBody').innerHTML = html || '<p style="color:#999;text-align:center;padding:40px 0;">No terms available.</p>';
    document.getElementById('tncModalOverlay').classList.add('active');
    document.body.style.overflow = 'hidden';
}

function closeTncModal(e) {
    // Only close when clicking the backdrop itself
    if (e.target === document.getElementById('tncModalOverlay')) {
        closeTncModalDirect();
    }
}

function closeTncModalDirect() {
    document.getElementById('tncModalOverlay').classList.remove('active');
    document.body.style.overflow = '';
}

// Close on Escape key
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeTncModalDirect();
});
</script>

<?php require_once 'includes/footer.php'; ?>
