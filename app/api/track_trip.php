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
    </style>
</head>
<body>
    <div class="header">
        <div style="display:flex; align-items:center; gap:15px;">
            <img src="../../assets/logo/logo.png" alt="Logo" class="logo" onerror="this.src='https://chooseataxi.com/assets/logo/logo.png'">
            <h1>Live Tracking</h1>
        </div>
        <div class="status-container">
            <div class="info-pill" id="booking-id-display">Loading...</div>
            <div class="status-dot"></div>
            <span style="font-size: 14px; color: #4CAF50; font-weight: bold;">LIVE</span>
        </div>
    </div>

    <div id="map"></div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const bookingId = urlParams.get('booking_id');
        
        if (!bookingId) {
            alert("Booking ID is missing in URL");
            document.getElementById('booking-id-display').innerText = "ERROR";
        } else {
            document.getElementById('booking-id-display').innerText = "Trip #" + bookingId;
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

        async function updateLocation() {
            if (!bookingId) return;
            try {
                const response = await fetch(`driver_location_api.php?action=get_location&booking_id=${bookingId}`);
                const data = await response.json();

                if (data.success && data.data) {
                    const lat = parseFloat(data.data.latitude);
                    const lng = parseFloat(data.data.longitude);
                    const newPos = [lat, lng];

                    if (!marker) {
                        marker = L.marker(newPos, {icon: taxiIcon}).addTo(map);
                        map.setView(newPos, 16);
                    } else {
                        // Smoothly move marker
                        marker.setLatLng(newPos);
                    }
                    
                    polyline.addLatLng(newPos);
                    
                    // Auto-follow if marker moves out of bounds (optional)
                    if (!map.getBounds().contains(newPos)) {
                        map.panTo(newPos);
                    }
                }
            } catch (error) {
                console.error("Tracking Error:", error);
            }
        }

        // Initial fetch and start polling
        updateLocation();
        setInterval(updateLocation, 3000); // Poll every 3 seconds as requested
    </script>
</body>
</html>
