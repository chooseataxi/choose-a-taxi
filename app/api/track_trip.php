<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Trip Tracking | Choose A Taxi</title>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <style>
        body, html { margin: 0; padding: 0; height: 100%; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        #map { height: calc(100vh - 80px); width: 100%; }
        .header { height: 80px; background: #1c1c1c; color: white; display: flex; align-items: center; padding: 0 20px; justify-content: space-between; box-shadow: 0 2px 10px rgba(0,0,0,0.3); position: relative; z-index: 1000; }
        .header h1 { margin: 0; font-size: 20px; font-weight: 600; }
        .logo { height: 40px; width: 40px; border-radius: 50%; background: white; padding: 5px; object-fit: contain; }
        .status-container { display: flex; align-items: center; gap: 10px; }
        .status-dot { width: 10px; height: 10px; background: #4CAF50; border-radius: 50%; box-shadow: 0 0 5px #4CAF50; animation: blink 1.5s infinite; }
        @keyframes blink { 0% { opacity: 1; } 50% { opacity: 0.3; } 100% { opacity: 1; } }
        .info-pill { background: rgba(255,255,255,0.1); padding: 5px 15px; border-radius: 20px; font-size: 13px; font-weight: 500; }
        .taxi-marker { filter: drop-shadow(0 2px 5px rgba(0,0,0,0.5)); transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1); }
        
        /* Trip Detail Card */
        .trip-detail-card { 
            position: absolute; bottom: 20px; left: 20px; right: 20px; 
            background: #262626; border-radius: 16px; padding: 20px; 
            color: white; z-index: 1000; display: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5); border: 1px solid rgba(255,255,255,0.05);
            max-width: 500px; margin: 0 auto;
        }
        .trip-info-item { display: flex; align-items: flex-start; gap: 12px; margin-bottom: 12px; }
        .trip-info-item:last-child { margin-bottom: 0; }
        .dot-connector { width: 12px; display: flex; flex-direction: column; align-items: center; }
        .outer-dot { width: 10px; height: 10px; border-radius: 50%; border: 2px solid #F4C20D; }
        .inner-line { width: 2px; height: 25px; background: rgba(255,255,255,0.2); }
        .location-text { font-size: 14px; font-weight: 500; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .distance-badge { background: #333; color: #F4C20D; padding: 4px 12px; border-radius: 8px; font-size: 12px; font-weight: bold; }

        /* New Prompt Overlay */
        #prompt-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); backdrop-filter: blur(8px); z-index: 2000; display: none; align-items: center; justify-content: center; color: white; }
        .prompt-card { background: #262626; padding: 40px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.1); text-align: center; max-width: 400px; width: 90%; box-shadow: 0 20px 40px rgba(0,0,0,0.5); }
        .prompt-card h2 { margin-bottom: 20px; color: #F4C20D; font-size: 24px; }
        .prompt-card input { width: 100%; padding: 15px; border-radius: 12px; border: 1px solid #444; background: #1a1a1a; color: white; font-size: 18px; text-align: center; box-sizing: border-box; outline: none; transition: 0.3s; }
        .prompt-card input:focus { border-color: #F4C20D; box-shadow: 0 0 10px rgba(244, 194, 13, 0.2); }
        .prompt-card button { margin-top: 20px; width: 100%; padding: 15px; border-radius: 12px; border: none; background: #F4C20D; color: black; font-weight: bold; font-size: 16px; cursor: pointer; transition: 0.3s; }
        .prompt-card button:hover { background: #ffd700; transform: translateY(-2px); }

        /* Waiting Overlay */
        #waiting-overlay { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); background: #1c1c1c; color: white; padding: 12px 25px; border-radius: 30px; border: 1px solid #F4C20D; z-index: 1000; font-size: 14px; font-weight: 600; display: none; align-items: center; gap: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .loading-dot { width: 8px; height: 8px; background: #F4C20D; border-radius: 50%; animation: pulse 1s infinite; }
        @keyframes pulse { 0% { opacity: 1; transform: scale(1); } 50% { opacity: 0.5; transform: scale(0.8); } 100% { opacity: 1; transform: scale(1); } }
    </style>
</head>
<body>
    <div id="prompt-overlay">
        <div class="prompt-card">
            <h2>Track Your Trip</h2>
            <p style="color: #888; margin-bottom: 25px;">Please enter your Booking ID to start live tracking.</p>
            <input type="text" id="id-input" placeholder="e.g. 123456" onkeyup="if(event.key==='Enter') startTracking()">
            <button onclick="startTracking()">START TRACKING</button>
        </div>
    </div>

    <div id="waiting-overlay">
        <div class="loading-dot"></div>
        Searching for trip details...
    </div>

    <div class="header">
        <div style="display:flex; align-items:center; gap:15px;">
            <img src="../../assets/logo.png" alt="Logo" class="logo" id="main-logo">
            <h1>Live Tracking</h1>
        </div>
        <div class="status-container">
            <div class="info-pill" id="booking-id-display">Loading...</div>
            <div class="status-dot" id="live-indicator-dot"></div>
            <span id="live-text" style="font-size: 14px; color: #4CAF50; font-weight: bold;">OFFLINE</span>
        </div>
    </div>

    <div id="map"></div>

    <div class="trip-detail-card" id="trip-detail-card">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px;">
            <span style="color: #888; font-size: 12px; text-transform: uppercase; letter-spacing: 1px;">Trip Summary</span>
            <div class="distance-badge" id="trip-distance">-- KM</div>
        </div>
        
        <div class="trip-info-item">
            <div class="dot-connector">
                <div class="outer-dot" style="border-color: #4CAF50;"></div>
                <div class="inner-line"></div>
            </div>
            <div style="flex: 1;">
                <div style="color: #888; font-size: 10px; margin-bottom: 2px;">PICKUP</div>
                <div class="location-text" id="pickup-text">--</div>
            </div>
        </div>

        <div class="trip-info-item">
            <div class="dot-connector">
                <div class="outer-dot" style="border-color: #F4C20D;"></div>
            </div>
            <div style="flex: 1;">
                <div style="color: #888; font-size: 10px; margin-bottom: 2px;">DROPOFF</div>
                <div class="location-text" id="dropoff-text">--</div>
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script>
        let urlParams = new URLSearchParams(window.location.search);
        let bookingId = urlParams.get('booking_id');
        
        if (!bookingId) {
            document.getElementById('prompt-overlay').style.display = 'flex';
            document.getElementById('booking-id-display').innerText = "WAITING...";
        } else {
            document.getElementById('booking-id-display').innerText = "Trip #" + bookingId;
        }

        function startTracking() {
            const val = document.getElementById('id-input').value.trim();
            if (val) {
                window.location.href = `track_trip.php?booking_id=${val}`;
            } else {
                alert("Please enter a valid Booking ID");
            }
        }

        // Initialize Map
        const map = L.map('map', { zoomControl: false, attributionControl: false }).setView([20.5937, 78.9629], 5); // India center

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap drivers'
        }).addTo(map);

        // Custom Taxi Icon
        const taxiIcon = L.icon({
            iconUrl: 'https://cdn-icons-png.flaticon.com/512/3448/3448339.png', // Taxi top-view icon
            iconSize: [40, 40],
            iconAnchor: [20, 20],
            className: 'taxi-marker'
        });

        const ORS_KEY = 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImUxMjZkZTRiZjFkYzQwNWE4YzQ5ZDgzYmZmMjZkYTQ1IiwiaCI6Im11cm11cjY0In0=';
        
        const pickupIcon = L.icon({
            iconUrl: 'https://cdn-icons-png.flaticon.com/512/1673/1673221.png',
            iconSize: [36, 36], iconAnchor: [18, 36], className: 'pickup-marker'
        });

        const dropIcon = L.icon({
            iconUrl: 'https://cdn-icons-png.flaticon.com/512/61/61168.png',
            iconSize: [36, 36], iconAnchor: [18, 36], className: 'drop-marker'
        });

        let marker = null;
        let pickupMarker = null;
        let dropMarker = null;
        let routeLayer = null;
        let polyline = L.polyline([], {color: '#F4C20D', weight: 4}).addTo(map);
        let firstLoad = true;
        let tripDetailsLoaded = false;

        async function geocodeAddress(address) {
            try {
                const url = `https://api.openrouteservice.org/geocode/search?api_key=${ORS_KEY}&text=${encodeURIComponent(address)}&size=1`;
                const resp = await fetch(url);
                const data = await resp.json();
                if (data.features && data.features.length > 0) {
                    const coords = data.features[0].geometry.coordinates; // [lng, lat]
                    return [coords[1], coords[0]]; // [lat, lng]
                }
            } catch (e) { console.error("Geocode Error:", e); }
            return null;
        }

        async function drawRoute(startRaw, endRaw) {
            try {
                // startRaw is [lat, lng]
                const url = `https://api.openrouteservice.org/v2/directions/driving-car?api_key=${ORS_KEY}&start=${startRaw[1]},${startRaw[0]}&end=${endRaw[1]},${endRaw[0]}`;
                const resp = await fetch(url);
                const data = await resp.json();
                
                if (data.features && data.features.length > 0) {
                    const feature = data.features[0];
                    const coords = feature.geometry.coordinates.map(c => [c[1], c[0]]);
                    const distanceKm = (feature.properties.summary.distance / 1000).toFixed(1);
                    
                    if (routeLayer) map.removeLayer(routeLayer);
                    routeLayer = L.polyline(coords, {color: '#2196F3', weight: 5, opacity: 0.8, dashArray: '1, 10'}).addTo(map);
                    document.getElementById('trip-distance').innerText = `${distanceKm} KM`;
                }
            } catch (e) { console.error("Routing Error:", e); }
        }

        async function updateLocation() {
            if (!bookingId) return;
            try {
                const response = await fetch(`driver_location_api.php?action=get_location&booking_id=${bookingId}`);
                const data = await response.json();

                if (data.success && data.data) {
                    const lat = parseFloat(data.data.latitude);
                    const lng = parseFloat(data.data.longitude);
                    const newPos = [lat, lng];

                    // Process metadata once
                    if (!tripDetailsLoaded) {
                        const pickupAddr = data.data.pickup_location;
                        const dropAddr = data.data.drop_location;
                        document.getElementById('pickup-text').innerText = pickupAddr;
                        document.getElementById('dropoff-text').innerText = dropAddr;
                        document.getElementById('trip-detail-card').style.display = 'block';

                        const pCoords = await geocodeAddress(pickupAddr);
                        const dCoords = await geocodeAddress(dropAddr);

                        if (pCoords) {
                            pickupMarker = L.marker(pCoords, {icon: pickupIcon}).addTo(map).bindPopup("<b>Pickup:</b> " + pickupAddr);
                        }
                        if (dCoords) {
                            dropMarker = L.marker(dCoords, {icon: dropIcon}).addTo(map).bindPopup("<b>Goal:</b> " + dropAddr);
                        }
                        if (pCoords && dCoords) {
                            drawRoute(pCoords, dCoords);
                        }
                        tripDetailsLoaded = true;
                    }

                    // Update UI status
                    document.getElementById('live-text').innerText = "LIVE";
                    document.getElementById('live-indicator-dot').style.background = "#4CAF50";
                    document.getElementById('live-indicator-dot').style.boxShadow = "0 0 5px #4CAF50";
                    document.getElementById('waiting-overlay').style.display = 'none';

                    if (!marker) {
                        marker = L.marker(newPos, {icon: taxiIcon}).addTo(map);
                        map.setView(newPos, 16);
                    } else {
                        marker.setLatLng(newPos);
                    }
                    
                    polyline.addLatLng(newPos);
                    
                    if (firstLoad) {
                        map.setView(newPos, 16);
                        firstLoad = false;
                    } else if (!map.getBounds().contains(newPos)) {
                        map.panTo(newPos);
                    }
                } else {
                    document.getElementById('waiting-overlay').style.display = 'flex';
                }
            } catch (error) {
                console.error("Tracking Error:", error);
                document.getElementById('waiting-overlay').style.display = 'flex';
            }
        }

        // Initial fetch then start polling
        if (bookingId) {
            updateLocation();
            setInterval(updateLocation, 3000); // Poll every 3 seconds as requested
        }
    </script>
</body>
</html>
