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
        .logo { height: 40px; }
        .status-container { display: flex; align-items: center; gap: 10px; }
        .status-dot { width: 10px; height: 10px; background: #4CAF50; border-radius: 50%; box-shadow: 0 0 5px #4CAF50; animation: blink 1.5s infinite; }
        @keyframes blink { 0% { opacity: 1; } 50% { opacity: 0.3; } 100% { opacity: 1; } }
        .info-pill { background: rgba(255,255,255,0.1); padding: 5px 15px; border-radius: 20px; font-size: 13px; font-weight: 500; }
        .taxi-marker { filter: drop-shadow(0 2px 5px rgba(0,0,0,0.5)); transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1); }
        
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
        Waiting for driver's signal...
    </div>

    <div class="header">
        <div style="display:flex; align-items:center; gap:15px;">
            <img src="../assets/logo.png" alt="Logo" class="logo" id="main-logo">
            <h1>Live Tracking</h1>
        </div>
        <div class="status-container">
            <div class="info-pill" id="booking-id-display">Loading...</div>
            <div class="status-dot" id="live-indicator-dot"></div>
            <span id="live-text" style="font-size: 14px; color: #4CAF50; font-weight: bold;">OFFLINE</span>
        </div>
    </div>

    <div id="map"></div>

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
        const map = L.map('map').setView([20.5937, 78.9629], 5); // India center

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

        let marker = null;
        let polyline = L.polyline([], {color: '#F4C20D', weight: 4}).addTo(map);
        let firstLoad = true;

        async function updateLocation() {
            if (!bookingId) return;
            try {
                const response = await fetch(`driver_location_api.php?action=get_location&booking_id=${bookingId}`);
                const data = await response.json();

                if (data.success && data.data) {
                    const lat = parseFloat(data.data.latitude);
                    const lng = parseFloat(data.data.longitude);
                    const newPos = [lat, lng];

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
