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

// 3. Fetch Available Cars
$cars = $pdo->query("SELECT c.*, ct.name as type_name, ct.image as type_image 
                     FROM cars c 
                     JOIN car_types ct ON c.type_id = ct.id 
                     WHERE c.status = 'Active'")->fetchAll();

?>

<!-- Custom Results CSS -->
<link rel="stylesheet" href="assets/css/fleet.css">
<style>
    .results-page { background: #f4f7f9; padding: 40px 0; min-height: 80vh; font-family: 'Inter', sans-serif; }
    .results-header-card { 
        background: #fff; border-radius: 8px; padding: 25px; margin-bottom: 30px; 
        box-shadow: 0 5px 15px rgba(0,0,0,0.05); border-left: 5px solid #28a745;
    }
    .trip-summary-title { font-size: 28px; font-weight: 800; color: #333; margin-bottom: 20px; }
    .loc-badge { 
        display: inline-block; padding: 4px 12px; border-radius: 4px; font-size: 13px; 
        font-weight: 700; margin-right: 10px; color: #fff;
    }
    .loc-pickup { background: #e3342f; }
    .loc-drop { background: #28a745; }
    .trip-info-row { display: flex; flex-wrap: wrap; gap: 30px; margin-bottom: 15px; }
    .trip-info-item label { display: block; font-size: 12px; color: #888; text-transform: uppercase; font-weight: 700; margin-bottom: 5px; }
    .trip-info-item span { font-size: 16px; font-weight: 600; color: #333; }
    .editable-input { border: 1px solid #ddd; padding: 8px 12px; border-radius: 4px; font-weight: 600; width: 100%; }
</style>

<div class="results-page">
    <div class="container" style="width: 90%; max-width: 1200px; margin: 0 auto;">
        <!-- Header Info -->
        <div class="results-header-card">
            <h2 class="trip-summary-title">Trip: <?= htmlspecialchars($trip_type) ?></h2>
            <div style="margin-bottom: 15px;">
                <span class="loc-badge loc-pickup">Pickup:</span>
                <span style="font-size: 16px; font-weight: 600;"><?= htmlspecialchars($pickup) ?></span>
            </div>
            <div style="margin-bottom: 25px;">
                <span class="loc-badge loc-drop">Drop:</span>
                <span style="font-size: 16px; font-weight: 600;"><?= htmlspecialchars($drop) ?></span>
            </div>

            <div class="trip-info-row">
                <div class="trip-info-item">
                    <label>Start date</label>
                    <input type="text" class="editable-input" value="<?= htmlspecialchars($date) ?>">
                </div>
                <div class="trip-info-item">
                    <label>Start time</label>
                    <input type="text" class="editable-input" value="<?= htmlspecialchars($time) ?>">
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
            ?>
            <div class="fleet-horizontal-card">
                <div class="fleet-card-left">
                    <img src="uploads/cars/<?= $car['image'] ?: 'default.png' ?>" alt="<?= $car['type_name'] ?>">
                </div>
                <div class="fleet-card-middle">
                    <h3><?= htmlspecialchars($car['name']) ?> [AC]</h3>
                    <div class="details-grid">
                        <div class="detail-row">
                            <label>Including Distance:</label>
                            <span><?= round($total_distance_km) ?> KMs</span>
                        </div>
                        <div class="detail-row">
                            <label>Extra price/ KM:</label>
                            <span>Rs. <?= $extra_km_price ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Toll:</label>
                            <span><?= $car['include_toll'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Tax:</label>
                            <span><?= $car['include_tax'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Driver allowance:</label>
                            <span><?= $car['include_driver_allowance'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Night charges:</label>
                            <span><?= $car['include_night_charges'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Parking:</label>
                            <span><?= $car['include_parking'] ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Seats:</label>
                            <span class="dark">4</span>
                        </div>
                    </div>
                    <div class="cancellation-note">
                        <i class="fas fa-bolt"></i> Free cancellation until 6 hour before pickup
                    </div>
                </div>
                <div class="fleet-card-right">
                    <div class="price-area">
                        <div class="old-price">Rs. <?= $old_price ?></div>
                        <div class="current-price">Rs. <?= $final_price ?></div>
                        <div class="discount-badge"><?= $random_off ?>% Off</div>
                    </div>
                    <a href="login.php?booking_request=1&car_id=<?= $car['id'] ?>&dist=<?= $total_distance_km ?>" class="btn-book-now">Book Now @ Rs. <?= $final_price ?></a>
                    <a href="#" class="terms-link">Terms & Conditons</a>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</div>

<?php require_once 'includes/footer.php'; ?>
