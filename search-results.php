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
    .results-page { background: #f8fafc; padding: 30px 0; min-height: 80vh; font-family: 'Inter', sans-serif; }
    .results-header-card { 
        background: #fff; border-radius: 12px; padding: 15px 25px; margin-bottom: 25px; 
        box-shadow: 0 4px 12px rgba(0,0,0,0.05); border: 1px solid #edf2f7;
    }
    .trip-summary-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 20px; }
    .trip-route-info { display: flex; flex: 1; min-width: 300px; gap: 15px; align-items: center; }
    .route-item { display: flex; flex-direction: column; gap: 2px; }
    .route-label { font-size: 10px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.5px; }
    .route-value { font-size: 14px; font-weight: 600; color: #1e293b; max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    .route-arrow { color: #cbd5e1; font-size: 14px; margin-top: 15px; }
    
    .trip-details-info { display: flex; gap: 20px; align-items: center; }
    .trip-type-badge { background: #f1f5f9; color: #475569; padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 700; }
    .info-box { display: flex; flex-direction: column; gap: 2px; }
    .info-box label { font-size: 10px; font-weight: 700; color: #94a3b8; text-transform: uppercase; }
    .info-box input { border: 1px solid #e2e8f0; border-radius: 6px; padding: 5px 10px; font-size: 13px; font-weight: 600; width: 110px; background: #f8fafc; }
    
    .stop-dot { width: 8px; height: 8px; background: #ffc107; border-radius: 50%; margin-top: 15px; }
</style>

<div class="results-page">
    <div class="container" style="width: 90%; max-width: 1200px; margin: 0 auto;">
        <!-- Header Info -->
        <div class="results-header-card">
            <div class="trip-summary-header">
                <!-- Route Part -->
                <div class="trip-route-info">
                    <div class="route-item">
                        <span class="route-label text-danger">Pickup</span>
                        <span class="route-value" title="<?= htmlspecialchars($pickup) ?>"><?= htmlspecialchars($pickup) ?></span>
                    </div>

                    <?php foreach ($stops as $stop): if(!empty($stop)): ?>
                        <div class="stop-dot" title="Stop: <?= htmlspecialchars($stop) ?>"></div>
                        <div class="route-item d-none d-lg-flex">
                            <span class="route-label text-warning">Stop</span>
                            <span class="route-value" title="<?= htmlspecialchars($stop) ?>"><?= htmlspecialchars($stop) ?></span>
                        </div>
                    <?php endif; endforeach; ?>

                    <div class="route-arrow"><i class="fas fa-chevron-right"></i></div>

                    <div class="route-item">
                        <span class="route-label text-success">Drop</span>
                        <span class="route-value" title="<?= htmlspecialchars($drop) ?>"><?= htmlspecialchars($drop) ?></span>
                    </div>
                </div>

                <!-- Date/Time Part -->
                <div class="trip-details-info">
                    <span class="trip-type-badge"><?= htmlspecialchars($trip_type) ?></span>
                    <div class="info-box">
                        <label>Date</label>
                        <input type="text" value="<?= htmlspecialchars($date) ?>" readonly>
                    </div>
                    <div class="info-box">
                        <label>Time</label>
                        <input type="text" value="<?= htmlspecialchars($time) ?>" readonly>
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
