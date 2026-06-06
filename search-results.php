<?php
/**
 * Trip Search Results Page
 */
require_once 'includes/db.php';
require_once 'includes/header.php';

// 1. Capture Inputs
$main_tab = $_GET['main_tab'] ?? '';

// Check if we are searching for a local trip type
$is_local_trip = ($main_tab === 'Local / Airport') || isset($_GET['local_trip_type']) || (isset($_GET['trip_type']) && stripos($_GET['trip_type'], 'Local') !== false);

if ($is_local_trip) {
    $trip_type = $_GET['local_trip_type'] ?? $_GET['trip_type'] ?? 'Local / Rental';
    $pickup    = $_GET['local_pickup'] ?? $_GET['pickup'] ?? '';
    $drop      = $_GET['airport_drop'] ?? $_GET['drop'] ?? '';
    $stops     = [];
    $date      = $_GET['local_date'] ?? $_GET['date'] ?? '';
    $time      = $_GET['local_time'] ?? $_GET['time'] ?? '';
    $return_date = '';
    $return_time = '';
    
    // City selected from dropdown
    $selected_city_id = !empty($_GET['city']) ? (int)$_GET['city'] : null;
    $selected_package_name = $_GET['package'] ?? '';
} else {
    $trip_type   = $_GET['trip_type'] ?? 'One Way';
    $pickup      = $_GET['pickup'] ?? '';
    $drop        = $_GET['drop'] ?? '';
    $stops       = $_GET['stops'] ?? [];
    $date        = $_GET['date'] ?? '';
    $time        = $_GET['time'] ?? '';
    $return_date = $_GET['return_date'] ?? '';
    $return_time = $_GET['return_time'] ?? '';
    $selected_city_id = null;
    $selected_package_name = '';
}

// Fetch active cities and local packages for search edit
$stmtLocal = $pdo->prepare("SELECT id FROM trip_types WHERE name = 'Local / Rental' LIMIT 1");
$stmtLocal->execute();
$localId = $stmtLocal->fetchColumn();

$local_cities = [];
$local_packages = []; // keyed by city_id

if ($localId) {
    // Fetch active cities that have at least one local package configured
    $citiesStmt = $pdo->prepare("
        SELECT DISTINCT c.city_id, ci.name 
        FROM cars c 
        JOIN cities ci ON c.city_id = ci.id 
        WHERE c.trip_type_id = ? AND c.status = 'Active' AND ci.status = 'Active'
        ORDER BY ci.name ASC
    ");
    $citiesStmt->execute([$localId]);
    $local_cities = $citiesStmt->fetchAll();

    // Fetch packages grouped by city_id
    $pkgsStmt = $pdo->prepare("
        SELECT DISTINCT city_id, name 
        FROM cars 
        WHERE trip_type_id = ? AND status = 'Active' AND city_id IS NOT NULL
        ORDER BY name ASC
    ");
    $pkgsStmt->execute([$localId]);
    $pkgs = $pkgsStmt->fetchAll();
    foreach ($pkgs as $pkg) {
        $local_packages[$pkg['city_id']][] = $pkg['name'];
    }
}

// Calculate Trip Days (Minimum 1)
$trip_days = 1;
if ($trip_type === 'Round Trip' && !empty($date) && !empty($return_date)) {
    $start_dt = strtotime("$date $time");
    // If no return time provided, default to end of day to be safe, though UI makes it required
    $rt_time = !empty($return_time) ? $return_time : '23:59:59';
    $end_dt   = strtotime("$return_date $rt_time");
    
    if ($end_dt > $start_dt) {
        // Calculate based on calendar days
        // A trip from 1st Jan to 2nd Jan is 2 days.
        $start_day = strtotime($date);
        $end_day = strtotime($return_date);
        $trip_days = round(($end_day - $start_day) / 86400) + 1;
        if ($trip_days < 1) $trip_days = 1;
    }
}

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

if (!$is_local_trip) {
    // Sequence: Pickup -> Stop 1 -> Stop 2 -> Drop
    $points = array_merge([$pickup], (array)$stops, [$drop]);
    for ($i = 0; $i < count($points) - 1; $i++) {
        $total_distance_km += getDistanceBetweenPoints($points[$i], $points[$i + 1], $api_key);
    }

    // Add a 15% real-world route margin. 
    // Google API city-to-city is often shorter than actual door-to-door driving distance.
    $total_distance_km = ceil($total_distance_km * 1.15);

    // Round trip: double the distance
    if ($trip_type === 'Round Trip') {
        $total_distance_km = $total_distance_km * 2;
    }

    // Final sanity check
    if ($total_distance_km < 1) $total_distance_km = 1;
} else {
    $total_distance_km = 0;
}

// 2.5 Identify Cities from Google Places
// Fetch all active cities to match against pickup/drop strings
$all_cities = $pdo->query("SELECT id, name FROM cities WHERE status = 'Active'")->fetchAll();
$detected_pickup_city_id = null;
$detected_drop_city_id = null;

if ($is_local_trip && !empty($selected_city_id)) {
    $detected_pickup_city_id = (int)$selected_city_id;
} else {
    foreach ($all_cities as $city) {
        if (!$detected_pickup_city_id && stripos($pickup, $city['name']) !== false) {
            $detected_pickup_city_id = $city['id'];
        }
        if (!$detected_drop_city_id && stripos($drop, $city['name']) !== false) {
            $detected_drop_city_id = $city['id'];
        }
    }
}

// 3. Fetch Available Cars matching the trip type and specific route/city
$trip_query_param = '%' . $trip_type . '%';

// Base query
$query = "SELECT c.*, ct.name as type_name, ct.image as type_image, ct.passengers as max_seats 
          FROM cars c 
          JOIN car_types ct ON c.type_id = ct.id 
          JOIN trip_types tt ON c.trip_type_id = tt.id 
          WHERE c.status = 'Active' AND tt.name LIKE :trip_type";

// Apply location-based filters
if ($trip_type === 'One Way') {
    // If we detected both cities, fetch custom route packages OR generic one-way packages
    if ($detected_pickup_city_id && $detected_drop_city_id) {
        $query .= " AND ((c.city_id IS NULL AND (c.drop_city_id IS NULL OR c.drop_city_id = 0)) 
                         OR (c.city_id = :p_city AND c.drop_city_id = :d_city))";
    } else {
        // Fallback to generic only
        $query .= " AND c.city_id IS NULL AND (c.drop_city_id IS NULL OR c.drop_city_id = 0)";
    }
} elseif (stripos($trip_type, 'Local') !== false) {
    if ($detected_pickup_city_id) {
        $query .= " AND c.city_id = :p_city AND (c.drop_city_id IS NULL OR c.drop_city_id = 0)";
        if (!empty($selected_package_name)) {
            $query .= " AND c.name = :package_name";
        }
    } else {
        $query .= " AND c.city_id IS NULL AND (c.drop_city_id IS NULL OR c.drop_city_id = 0)";
    }
} else {
    // Default for Round Trip or others (Generic only)
    $query .= " AND c.city_id IS NULL AND (c.drop_city_id IS NULL OR c.drop_city_id = 0)";
}

// Order by city_id DESC so specific routes/city packages appear first, overriding generics when we deduplicate
$query .= " ORDER BY c.city_id DESC, c.drop_city_id DESC, ct.name ASC";

$cars_stmt = $pdo->prepare($query);
$cars_stmt->bindValue(':trip_type', $trip_query_param);

if ($trip_type === 'One Way' && $detected_pickup_city_id && $detected_drop_city_id) {
    $cars_stmt->bindValue(':p_city', $detected_pickup_city_id);
    $cars_stmt->bindValue(':d_city', $detected_drop_city_id);
} elseif (stripos($trip_type, 'Local') !== false && $detected_pickup_city_id) {
    $cars_stmt->bindValue(':p_city', $detected_pickup_city_id);
    if (!empty($selected_package_name)) {
        $cars_stmt->bindValue(':package_name', $selected_package_name);
    }
}

$cars_stmt->execute();
$raw_cars = $cars_stmt->fetchAll();

// Deduplicate: Keep only the most specific package per car type
$unique_cars = [];
foreach ($raw_cars as $car) {
    if (!isset($unique_cars[$car['type_id']])) {
        $unique_cars[$car['type_id']] = $car;
    }
}
$cars = array_values($unique_cars);
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
    
    .ts-route-vertical { display: flex; flex-direction: column; gap: 15px; flex: 1; min-width: 300px; position: relative; padding-left: 30px; }
    
    .ts-route-step { display: flex; flex-direction: column; position: relative; }
    .ts-route-step::before {
        content: ''; position: absolute; left: -27px; top: 8px; width: 12px; height: 12px; 
        border-radius: 50%; background: #ffc107; border: 3px solid #1a1a1a; z-index: 2;
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
    .ts-edit-input {
        background: transparent; border: none; border-bottom: 1px dashed rgba(255,255,255,0.3);
        color: #fff; font-size: 14px; font-weight: 600; width: 100%; outline: none; padding: 2px 0;
        transition: 0.3s;
    }
    .ts-edit-input:focus { border-bottom-color: #ffc107; }
    .ts-edit-date { width: auto; font-size: 13px; color: #fff; background: transparent; border: none; border-bottom: 1px dashed rgba(255,255,255,0.3); outline: none; }
    /* Fix date/time picker icon color on dark background */
    .ts-edit-date::-webkit-calendar-picker-indicator { filter: invert(1); cursor: pointer; }

    .btn-update-search {
        background: #ffc107; color: #000; border: none; padding: 8px 16px; border-radius: 8px;
        font-weight: 800; text-transform: uppercase; font-size: 12px; cursor: pointer;
        transition: 0.3s; margin-top: 15px; width: 100%;
    }
    .btn-update-search:hover { background: #e0ac08; transform: translateY(-2px); }

    /* Search Result Fleet Card Styling */
    .fleet-horizontal-card {
        display: flex;
        background: #ffffff;
        border-radius: 16px;
        border: 1px solid rgba(0, 0, 0, 0.08);
        box-shadow: 0 8px 30px rgba(0,0,0,0.03), 0 1px 3px rgba(0,0,0,0.01);
        margin-bottom: 25px;
        overflow: hidden;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
    }
    .fleet-horizontal-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 16px 40px rgba(0,0,0,0.07), 0 1px 4px rgba(0,0,0,0.02);
        border-color: rgba(255, 158, 21, 0.3);
    }
    
    /* Left Section: Image */
    .fleet-card-left {
        flex: 0 0 280px;
        background: #f8fafc;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
        border-right: 1px solid rgba(0, 0, 0, 0.04);
    }
    .fleet-card-left img {
        width: 100%;
        height: auto;
        max-height: 160px;
        object-fit: contain;
        transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .fleet-horizontal-card:hover .fleet-card-left img {
        transform: scale(1.06);
    }
    
    /* Middle Section: Details */
    .fleet-card-middle {
        flex: 1;
        padding: 24px 30px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .fleet-card-middle h3 {
        font-size: 20px;
        font-weight: 800;
        color: #0f172a;
        margin: 0 0 15px 0;
        letter-spacing: -0.5px;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .fleet-card-middle h3 .badge-car-type {
        font-size: 11px;
        font-weight: 700;
        background: rgba(255, 193, 7, 0.15);
        color: #c49000;
        padding: 3px 10px;
        border-radius: 20px;
        text-transform: uppercase;
    }

    /* Details Grid */
    .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
        gap: 16px 20px;
        margin-bottom: 15px;
    }
    .detail-row {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    .detail-row label {
        font-size: 10.5px;
        font-weight: 700;
        color: #94a3b8;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin: 0;
    }
    .detail-row span, .detail-row div {
        font-size: 13.5px;
        font-weight: 700;
        color: #334155;
    }
    
    /* Inclusion Pill Badges */
    .inclusion-badge {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px 8px;
        border-radius: 6px;
        font-size: 11.5px !important;
        font-weight: 700 !important;
        width: fit-content;
    }
    .inclusion-badge-included {
        background-color: #ecfdf5;
        color: #059669 !important;
    }
    .inclusion-badge-excluded {
        background-color: #fef2f2;
        color: #dc2626 !important;
    }
    .inclusion-badge i {
        font-size: 10px;
    }

    /* Cancellation & Trust Markers */
    .cancellation-note {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 12.5px;
        font-weight: 600;
        color: #059669;
        background: #f0fdf4;
        padding: 6px 12px;
        border-radius: 8px;
        width: fit-content;
        margin-top: 10px;
    }

    /* Right Section: Price & Action */
    .fleet-card-right {
        flex: 0 0 260px;
        padding: 30px 24px;
        background: #fafafa;
        border-left: 1px dashed rgba(0, 0, 0, 0.08);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: stretch;
        position: relative;
    }
    
    .price-area {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 5px;
        margin-bottom: 20px;
    }
    .price-area-top {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
        justify-content: flex-end;
    }
    .old-price {
        font-size: 14.5px;
        color: #94a3b8;
        text-decoration: line-through;
        font-weight: 600;
    }
    .discount-badge {
        font-size: 11px;
        font-weight: 800;
        background: #e11d48;
        color: #ffffff;
        padding: 2px 6px;
        border-radius: 4px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .current-price {
        font-size: 32px;
        font-weight: 900;
        color: #0f172a;
        line-height: 1;
        letter-spacing: -1px;
    }
    .price-subtext {
        font-size: 10.5px;
        color: #64748b;
        font-weight: 500;
        margin-top: 2px;
    }

    /* Book Button styling */
    .btn-book-now {
        background: #ffcc00;
        color: #0f172a !important;
        padding: 12px 18px;
        border-radius: 10px;
        text-decoration: none;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        font-weight: 800;
        font-size: 15px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        box-shadow: 0 4px 12px rgba(255, 204, 0, 0.2);
        border: none;
    }
    .btn-book-now:hover {
        background: #e0b400;
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(255, 204, 0, 0.35);
    }
    .btn-book-now:active {
        transform: translateY(0);
    }

    /* Responsive Breakpoints */
    @media (max-width: 991px) {
        .fleet-horizontal-card {
            flex-direction: column;
        }
        .fleet-card-left {
            flex: 0 0 200px;
            border-right: none;
            border-bottom: 1px solid rgba(0, 0, 0, 0.04);
            padding: 30px;
        }
        .fleet-card-left img {
            max-height: 180px;
            width: auto;
        }
        .fleet-card-right {
            flex: unset;
            border-left: none;
            border-top: 1px dashed rgba(0, 0, 0, 0.08);
            padding: 24px;
            background: #ffffff;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
        }
        .price-area {
            align-items: flex-start;
            margin-bottom: 0;
        }
        .price-area-top {
            justify-content: flex-start;
            flex-direction: row-reverse;
        }
        .btn-book-now {
            padding: 12px 30px;
            width: auto;
        }
    }

    @media (max-width: 767px) {
        .fleet-card-middle {
            padding: 20px;
        }
        .details-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 12px 15px;
        }
        .fleet-card-right {
            flex-direction: column;
            align-items: stretch;
            gap: 15px;
        }
        .price-area {
            align-items: center;
        }
        .price-area-top {
            justify-content: center;
        }
        .btn-book-now {
            width: 100%;
        }
    }
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
        <!-- Header Info (Editable) -->
        <div class="ts-header-card">
            <form action="search-results.php" method="GET" id="editTripForm">
                <input type="hidden" name="trip_type" value="<?= htmlspecialchars($trip_type) ?>">
                <?php if ($is_local_trip): ?>
                    <input type="hidden" name="main_tab" value="Local / Airport">
                    <input type="hidden" name="local_trip_type" value="<?= htmlspecialchars($trip_type) ?>">
                <?php endif; ?>
                <div class="ts-summary-wrapper">
                    <!-- Vertical Route Info -->
                    <div class="ts-route-vertical">
                        <?php if ($trip_type === 'Local / Rental'): ?>
                            <div class="ts-route-step ts-step-pickup">
                                <span class="ts-step-label">Pickup Location</span>
                                <input type="text" name="local_pickup" id="edit_pickup" class="ts-edit-input" value="<?= htmlspecialchars($pickup) ?>" required>
                            </div>
                            
                            <div class="ts-route-step">
                                <span class="ts-step-label">City</span>
                                <div style="margin-top: 5px;">
                                    <select name="city" id="edit_local_city" style="background: #222; color: #fff; border: 1px solid rgba(255,255,255,0.2); border-radius: 6px; padding: 6px 12px; font-size: 13px; font-family: inherit; width: 100%; outline: none; cursor: pointer;" required>
                                        <option value="">--- Select City ---</option>
                                        <?php foreach ($local_cities as $city): ?>
                                            <option value="<?= $city['city_id'] ?>" <?= ($selected_city_id == $city['city_id']) ? 'selected' : '' ?>><?= htmlspecialchars($city['name']) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>

                            <div class="ts-route-step">
                                <span class="ts-step-label">Package</span>
                                <div style="margin-top: 5px;">
                                    <select name="package" id="edit_local_package" style="background: #222; color: #fff; border: 1px solid rgba(255,255,255,0.2); border-radius: 6px; padding: 6px 12px; font-size: 13px; font-family: inherit; width: 100%; outline: none; cursor: pointer;" required>
                                        <option value="">--- Select Package ---</option>
                                        <?php 
                                        if (!empty($selected_city_id) && isset($local_packages[$selected_city_id])) {
                                            foreach ($local_packages[$selected_city_id] as $pkg) {
                                                $sel = ($selected_package_name === $pkg) ? 'selected' : '';
                                                echo "<option value=\"" . htmlspecialchars($pkg) . "\" $sel>" . htmlspecialchars($pkg) . "</option>";
                                            }
                                        }
                                        ?>
                                    </select>
                                </div>
                            </div>
                        <?php elseif ($trip_type === 'Airport Transfer'): ?>
                            <div class="ts-route-step ts-step-pickup">
                                <span class="ts-step-label">Pickup Location</span>
                                <input type="text" name="local_pickup" id="edit_pickup" class="ts-edit-input" value="<?= htmlspecialchars($pickup) ?>" required>
                            </div>
                            
                            <div class="ts-route-step ts-step-drop" id="ts-step-drop-container">
                                <span class="ts-step-label">Drop Location</span>
                                <input type="text" name="airport_drop" id="edit_drop" class="ts-edit-input" value="<?= htmlspecialchars($drop) ?>" required>
                            </div>
                        <?php else: ?>
                            <!-- Outstation / One Way / Round Trip -->
                            <div class="ts-route-step ts-step-pickup">
                                <span class="ts-step-label">Pickup Location</span>
                                <input type="text" name="pickup" id="edit_pickup" class="ts-edit-input" value="<?= htmlspecialchars($pickup) ?>" required>
                            </div>

                            <?php 
                            $valid_stops = array_filter((array)$stops);
                            foreach ($valid_stops as $index => $stop): 
                            ?>
                                <div class="ts-route-step ts-step-stop">
                                    <span class="ts-step-label">Stop <?= $index + 1 ?></span>
                                    <input type="text" name="stops[]" class="ts-edit-input edit-stop-input" value="<?= htmlspecialchars($stop) ?>">
                                </div>
                            <?php endforeach; ?>

                            <div style="padding-left: 0; margin-top: -5px;">
                                <button type="button" id="ts-btn-add-stop" style="background:transparent; border:none; color:#ffc107; font-size:11px; cursor:pointer; font-weight:800; text-transform:uppercase;"><i class="fas fa-plus-circle"></i> Add Stop</button>
                            </div>

                            <div class="ts-route-step ts-step-drop" id="ts-step-drop-container">
                                <span class="ts-step-label">Drop Location</span>
                                <input type="text" name="drop" id="edit_drop" class="ts-edit-input" value="<?= htmlspecialchars($drop) ?>" required>
                            </div>
                        <?php endif; ?>
                    </div>

                    <!-- Side Info -->
                    <div class="ts-side-info">
                        <div class="ts-badge-area" style="width: 100%; justify-content: flex-end;">
                            <span class="ts-tag"><?= htmlspecialchars($trip_type) ?></span>
                            <?php if ($trip_type === 'Round Trip'): ?>
                                <span class="ts-tag" style="background: #e3342f; color: #fff;"><?= $trip_days ?> Day(s)</span>
                            <?php endif; ?>
                        </div>
                        
                        <div class="ts-time-card">
                            <div class="ts-info-item">
                                <label>Departure</label>
                                <div style="display:flex; gap:10px;">
                                    <input type="date" name="<?= $is_local_trip ? 'local_date' : 'date' ?>" class="ts-edit-date" value="<?= htmlspecialchars($date) ?>" required>
                                    <input type="time" name="<?= $is_local_trip ? 'local_time' : 'time' ?>" class="ts-edit-date" value="<?= htmlspecialchars($time) ?>" required>
                                </div>
                            </div>
                            
                            <?php if ($trip_type === 'Round Trip'): ?>
                            <div class="ts-info-item" style="border-left: 1px solid rgba(255,255,255,0.1); padding-left: 20px;">
                                <label>Return</label>
                                <div style="display:flex; gap:10px;">
                                    <input type="date" name="return_date" class="ts-edit-date" value="<?= htmlspecialchars($return_date) ?>" required>
                                    <input type="time" name="return_time" class="ts-edit-date" value="<?= htmlspecialchars($return_time) ?>" required>
                                </div>
                            </div>
                            <?php endif; ?>
                        </div>
                        
                        <button type="submit" class="btn-update-search"><i class="fas fa-sync-alt"></i> Update Search</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Available Fleets (Dynamic Calculation) -->
        <div class="fleet-list">
            <?php foreach ($cars as $car): 
                $dist_float      = (float)$total_distance_km;
                $min_km          = (float)$car['min_km'];
                $base_fare       = (float)$car['base_fare'];
                $extra_km_price  = (float)$car['extra_km_price'];

                $display_distance_km = round($total_distance_km);

                if ($trip_type === 'Local / Rental') {
                    $final_price = $base_fare;
                    $display_distance_note = "";
                } elseif ($trip_type === 'Round Trip') {
                    // Round trip is calculated per day
                    $total_min_km = $min_km * $trip_days;
                    $final_base_fare = $base_fare * $trip_days;
                    
                    $final_price = $final_base_fare;
                    if ($dist_float > $total_min_km) {
                        $extra_km     = $dist_float - $total_min_km;
                        $final_price += ($extra_km * $extra_km_price);
                    } else {
                        // Override display distance if original is less than minimum
                        $display_distance_km = $total_min_km;
                    }
                    $display_distance_note = "";
                } else {
                    // One Way uses flat minimum
                    $final_price = $base_fare;
                    if ($dist_float > $min_km) {
                        $extra_km     = $dist_float - $min_km;
                        $final_price += ($extra_km * $extra_km_price);
                    }
                    $display_distance_note = "";
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
                    <h3>
                        <?= $display_name ?>
                        <span class="badge-car-type"><i class="fas fa-taxi me-1"></i> Cab</span>
                    </h3>
                    <div class="details-grid">
                        <div class="detail-row">
                            <?php if ($trip_type === 'Local / Rental'): ?>
                                <label>Selected Package</label>
                                <div>
                                    <span style="color: #ff9e15; font-weight: 800; font-size: 15px;"><i class="fas fa-clock me-1"></i> <?= htmlspecialchars($car['name']) ?></span>
                                </div>
                            <?php else: ?>
                                <label>Trip Distance</label>
                                <div>
                                    <span style="color: #ff9e15; font-weight: 800; font-size: 15px;"><i class="fas fa-road me-1"></i> <?= $display_distance_km ?> KMs</span>
                                    <?php if (!empty($display_distance_note)): ?>
                                        <br><span style="font-size: 11px; color: #64748b;"><?= htmlspecialchars($display_distance_note) ?></span>
                                    <?php endif; ?>
                                </div>
                            <?php endif; ?>
                        </div>
                        <div class="detail-row">
                            <label>Extra KM Fare</label>
                            <span style="color: #ef4444; font-weight: 800; font-size: 15px;"><i class="fas fa-tags me-1"></i> <?= $display_extra ?></span>
                        </div>
                        <div class="detail-row">
                            <label>Capacity</label>
                            <span style="color: #0f172a; font-weight: 800; font-size: 15px;"><i class="fas fa-user-friends me-1"></i> <?= $car['max_seats'] ?> Seats</span>
                        </div>
                        <div class="detail-row">
                            <label>Toll Charges</label>
                            <?= (stripos($car['include_toll'], 'include') !== false) 
                                ? '<span class="inclusion-badge inclusion-badge-included"><i class="fas fa-check-circle"></i> Included</span>' 
                                : '<span class="inclusion-badge inclusion-badge-excluded"><i class="fas fa-times-circle"></i> Excluded</span>' ?>
                        </div>
                        <div class="detail-row">
                            <label>State Tax</label>
                            <?= (stripos($car['include_tax'], 'include') !== false) 
                                ? '<span class="inclusion-badge inclusion-badge-included"><i class="fas fa-check-circle"></i> Included</span>' 
                                : '<span class="inclusion-badge inclusion-badge-excluded"><i class="fas fa-times-circle"></i> Excluded</span>' ?>
                        </div>
                        <div class="detail-row">
                            <label>Driver Allowance</label>
                            <?= (stripos($car['include_driver_allowance'], 'include') !== false) 
                                ? '<span class="inclusion-badge inclusion-badge-included"><i class="fas fa-check-circle"></i> Included</span>' 
                                : '<span class="inclusion-badge inclusion-badge-excluded"><i class="fas fa-times-circle"></i> Excluded</span>' ?>
                        </div>
                        <div class="detail-row">
                            <label>Night Charges</label>
                            <?= (stripos($car['include_night_charges'], 'include') !== false) 
                                ? '<span class="inclusion-badge inclusion-badge-included"><i class="fas fa-check-circle"></i> Included</span>' 
                                : '<span class="inclusion-badge inclusion-badge-excluded"><i class="fas fa-times-circle"></i> Excluded</span>' ?>
                        </div>
                        <div class="detail-row">
                            <label>Parking Fees</label>
                            <?= (stripos($car['include_parking'], 'include') !== false) 
                                ? '<span class="inclusion-badge inclusion-badge-included"><i class="fas fa-check-circle"></i> Included</span>' 
                                : '<span class="inclusion-badge inclusion-badge-excluded"><i class="fas fa-times-circle"></i> Excluded</span>' ?>
                        </div>
                    </div>
                    <div class="cancellation-note">
                        <i class="fas fa-shield-alt"></i> Free cancellation until 6 hours before pickup
                    </div>
                </div>
                <div class="fleet-card-right">
                    <div class="price-area">
                        <div class="price-area-top">
                            <span class="old-price">Rs. <?= $old_price ?></span>
                            <span class="discount-badge"><?= $random_off ?>% Off</span>
                        </div>
                        <div class="current-price">Rs. <?= $final_price ?></div>
                        <div class="price-subtext">Estimated total fare</div>
                    </div>
                    <a href="login.php?booking_request=1&car_id=<?= $car['id'] ?>&dist=<?= $total_distance_km ?>" class="btn-book-now">
                        Book Cab <i class="fas fa-chevron-right" style="font-size: 12px;"></i>
                    </a>
                    <div style="text-align: center; margin-top: 15px;">
                        <?php if (!empty($car['terms_conditions'])): ?>
                            <a href="#" class="terms-link" onclick="openTncModal(this); return false;" data-tnc="<?= $tnc_html ?>">
                                <i class="fas fa-file-contract"></i> T&amp;C Apply
                            </a>
                        <?php else: ?>
                            <span class="terms-link" style="color: #cbd5e1; cursor: default;">
                                <i class="fas fa-file-contract"></i> T&amp;C Apply
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

// Autocomplete for editable search header
let autocompleteOptions = {
    componentRestrictions: { country: "in" },
    fields: ["formatted_address", "geometry"],
};

function initAutocomplete() {
    if (typeof google === 'undefined') return;

    const pickupInput = document.getElementById("edit_pickup");
    const dropInput = document.getElementById("edit_drop");

    if (pickupInput) new google.maps.places.Autocomplete(pickupInput, autocompleteOptions);
    if (dropInput) new google.maps.places.Autocomplete(dropInput, autocompleteOptions);

    document.querySelectorAll('.edit-stop-input').forEach(input => {
        new google.maps.places.Autocomplete(input, autocompleteOptions);
    });
}

// Add Stop Functionality in Search Header
const tsAddStopBtn = document.getElementById('ts-btn-add-stop');
let tsStopCount = document.querySelectorAll('.edit-stop-input').length;

if (tsAddStopBtn) {
    if (tsStopCount >= 4) {
        tsAddStopBtn.style.display = 'none';
    }
    tsAddStopBtn.addEventListener('click', () => {
        if (tsStopCount >= 4) {
            alert('Maximum 4 stops allowed');
            return;
        }

        const stopDiv = document.createElement('div');
        stopDiv.className = 'ts-route-step ts-step-stop';
        stopDiv.innerHTML = `
            <span class="ts-step-label">Stop ${tsStopCount + 1}</span>
            <input type="text" name="stops[]" class="ts-edit-input edit-stop-input" placeholder="Enter stop location" required>
        `;
        
        const dropContainer = document.getElementById('ts-step-drop-container');
        dropContainer.parentNode.insertBefore(stopDiv, tsAddStopBtn.parentNode);

        // Attach autocomplete to new input
        const newInput = stopDiv.querySelector('input');
        if (typeof google !== 'undefined') {
            new google.maps.places.Autocomplete(newInput, autocompleteOptions);
        }

        tsStopCount++;
        if (tsStopCount >= 4) {
            tsAddStopBtn.style.display = 'none';
        }
    });
}

// Dynamic Packages Loader for editable search header
const localPackagesData = <?= json_encode($local_packages) ?>;
const localCitySelect = document.getElementById('edit_local_city');
if (localCitySelect) {
    localCitySelect.addEventListener('change', function() {
        const cityId = this.value;
        const packageSelect = document.getElementById('edit_local_package');
        if (packageSelect) {
            packageSelect.innerHTML = '<option value="">--- Select Package ---</option>';
            if (cityId && localPackagesData[cityId]) {
                localPackagesData[cityId].forEach(pkgName => {
                    const opt = document.createElement('option');
                    opt.value = pkgName;
                    opt.textContent = pkgName;
                    packageSelect.appendChild(opt);
                });
            }
        }
    });
}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY&libraries=places&callback=initAutocomplete" async defer></script>

<?php require_once 'includes/footer.php'; ?>
