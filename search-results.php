<?php
/**
 * Trip Search Results Page
 */
require_once 'includes/db.php';
require_once 'includes/header.php';

// 1. Capture Inputs
$trip_type = $_GET['trip_type'] ?? 'One Way';
$pickup = $_GET['pickup'] ?? '';
$drop = $_GET['drop'] ?? '';
$stops = $_GET['stops'] ?? [];
$date = $_GET['date'] ?? '';
$time = $_GET['time'] ?? '';

// 2. Calculate Distance using Google API
$api_key = $_ENV['GOOGLE_MAPS_KEY'] ?? 'AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY';
$total_distance_km = 0;

function getDistanceBetweenPoints($origin, $destination, $key) {
    if (empty($origin) || empty($destination)) return 0;
    $url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=" . urlencode($origin) . "&destinations=" . urlencode($destination) . "&key=" . $key;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $response = curl_exec($ch);
    curl_close($ch);
    $data = json_decode($response, true);
    if (isset($data['rows'][0]['elements'][0]['distance']['value'])) {
        return $data['rows'][0]['elements'][0]['distance']['value'] / 1000; // Return in KM
    }
    return 0;
}

// Sequence: Pickup -> Stop 1 -> Stop 2 -> Drop
$points = array_merge([$pickup], $stops, [$drop]);
for ($i = 0; $i < count($points) - 1; $i++) {
    $total_distance_km += getDistanceBetweenPoints($points[$i], $points[$i+1], $api_key);
}

// Round trip logic: Double the distance
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
// The trip_type from GET is "One Way" or "Round Trip"
// We use LIKE to match "One Way Trip" or "Round Trip" in case of slightly different naming
$cars_stmt->execute(['%' . $trip_type . '%']);
$cars = $cars_stmt->fetchAll();
?>

<!-- Custom Results CSS -->
<link rel="stylesheet" href="assets/css/fleet.css">
<link rel="stylesheet" href="assets/css/footer.css">
<style>
    .results-page { background: #fdfdfd; padding: 25px 0; min-height: 80vh; font-family: 'Inter', sans-serif; }
    .results-header-card { 
        background: #1a1a1a; border-radius: 16px; padding: 18px 30px; margin-bottom: 30px; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.1); color: #fff; position: relative; overflow: hidden;
    }
    .results-header-card::after {
        content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; background: #ffc107;
    }
    .trip-summary-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 25px; }
    .trip-route-info { display: flex; flex: 1; min-width: 350px; gap: 15px; align-items: center; position: relative; }
    
    .route-item { display: flex; flex-direction: column; gap: 4px; position: relative; z-index: 1; }
    .route-label { font-size: 11px; font-weight: 800; color: #ffc107; text-transform: uppercase; letter-spacing: 1px; }
    .route-value { font-size: 15px; font-weight: 600; color: #fff; max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    
    .route-line { flex: 1; height: 1px; border-top: 2px dashed rgba(255,193,7,0.3); margin-top: 15px; position: relative; }
    .route-line::before, .route-line::after { content: ''; position: absolute; top: -4px; width: 8px; height: 8px; border-radius: 50%; background: #ffc107; }
    .route-line::before { left: -4px; } .route-line::after { right: -4px; }

    .trip-details-info { display: flex; gap: 25px; align-items: center; background: rgba(255,255,255,0.05); padding: 10px 20px; border-radius: 12px; }
    .info-box { display: flex; flex-direction: column; gap: 4px; }
    .info-box label { font-size: 10px; font-weight: 700; color: #aaa; text-transform: uppercase; }
    .info-box span { font-size: 14px; font-weight: 700; color: #fff; }
    
    .trip-type-tag { background: #ffc107; color: #000; padding: 4px 12px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase; }
    
    .stop-dot-v2 { width: 10px; height: 10px; background: #fff; border: 2px solid #ffc107; border-radius: 50%; position: absolute; top: 50%; transform: translateY(-50%); z-index: 2; }
</style>

<div class="results-page">
    <div class="container" style="width: 90%; max-width: 1200px; margin: 0 auto;">
        <!-- Header Info -->
        <div class="results-header-card">
            <div class="trip-summary-header">
                <!-- Route Part -->
                <div class="trip-route-info">
                    <div class="route-item">
                        <span class="route-label">Pickup</span>
                        <span class="route-value" title="<?= htmlspecialchars($pickup) ?>"><?= htmlspecialchars($pickup) ?></span>
                    </div>

                    <div class="route-line">
                        <?php 
                        $valid_stops = array_filter($stops);
                        $stop_count = count($valid_stops);
                        if ($stop_count > 0): 
                            foreach ($valid_stops as $i => $stop):
                                $pos = (($i + 1) / ($stop_count + 1)) * 100;
                        ?>
                            <div class="stop-dot-v2" style="left: <?= $pos ?>%;" title="Stop: <?= htmlspecialchars($stop) ?>"></div>
                        <?php endforeach; endif; ?>
                    </div>

                    <div class="route-item text-end">
                        <span class="route-label">Drop</span>
                        <span class="route-value" title="<?= htmlspecialchars($drop) ?>"><?= htmlspecialchars($drop) ?></span>
                    </div>
                </div>

                <!-- Details Part -->
                <div class="trip-details-info">
                    <span class="trip-type-tag"><?= htmlspecialchars($trip_type) ?></span>
                    <div class="info-box">
                        <label>Start Date</label>
                        <span><?= htmlspecialchars($date) ?></span>
                    </div>
                    <div class="info-box border-start ps-3" style="border-color: rgba(255,255,255,0.1) !important;">
                        <label>Start Time</label>
                        <span><?= htmlspecialchars($time) ?></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Fleets (Dynamic Calculation) -->
        <div class="fleet-list">
            <?php foreach ($cars as $car): 
                $dist_float = (float)$total_distance_km;
                $min_km = (float)$car['min_km'];
                $base_fare = (float)$car['base_fare'];
                $extra_km_price = (float)$car['extra_km_price'];

                // Formula: Base + (Extra Distance * Extra Price)
                $final_price = $base_fare;
                if ($dist_float > $min_km) {
                    $extra_km = $dist_float - $min_km;
                    $final_price += ($extra_km * $extra_km_price);
                }

                $final_price = round($final_price);
                $random_off = rand(7, 15);
                $old_price = round($final_price / (1 - ($random_off/100)));
                
                $display_name = strtoupper($car['type_name']);
                
                // Fix: type_image in DB already contains path 'assets/car_types/...'
                // car['image'] in DB is filename only, requires 'uploads/cars/'
                if (!empty($car['type_image'])) {
                    $display_image = $car['type_image'];
                } else if (!empty($car['image'])) {
                    $display_image = 'uploads/cars/' . $car['image'];
                } else {
                    $display_image = 'assets/frontend-images/hero-new-bg.jpeg'; // fallback
                }
            ?>
            <div class="fleet-horizontal-card">
                <div class="fleet-card-left">
                    <img src="<?= $display_image ?>" alt="<?= $display_name ?>">
                </div>
                <div class="fleet-card-middle">
                    <h3 style="font-weight: 800; color: #333; margin-bottom: 15px;"><?= $display_name ?></h3>
                    <div class="details-grid">
                        <div class="detail-row">
                            <label>Package Min. KM:</label>
                            <span style="color: #28a745; font-weight: 800;"><?= $car['min_km'] ?> KMs</span>
                        </div>
                        <div class="detail-row">
                            <label>Total Trip Distance:</label>
                            <span style="color: #007bff; font-weight: 800;"><?= round($total_distance_km) ?> KMs</span>
                        </div>
                        <div class="detail-row">
                            <label>Extra price/ KM:</label>
                            <span style="color: #d33; font-weight: 800;">Rs. <?= $extra_km_price ?></span>
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
                        <a href="#" class="terms-link" style="color: #28a745; text-decoration: none; font-weight: 600;">Terms & Conditons</a>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</div>

<?php require_once 'includes/footer.php'; ?>
