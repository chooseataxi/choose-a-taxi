<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Trip Tracking | Choose A Taxi</title>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin=""/>
    <style>
        :root {
            --bg-primary: #ffffff;
            --bg-header: #1c1c1c;
            --text-main: #262626;
            --text-header: #ffffff;
            --card-bg: #f8f9fa;
            --card-border: rgba(0,0,0,0.05);
            --card-shadow: rgba(0,0,0,0.1);
        }

        [data-theme="dark"] {
            --bg-primary: #121212;
            --bg-header: #1c1c1c;
            --text-main: #f8f9fa;
            --text-header: #ffffff;
            --card-bg: #262626;
            --card-border: rgba(255,255,255,0.05);
            --card-shadow: rgba(0,0,0,0.5);
        }

        body, html { margin: 0; padding: 0; height: 100%; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: var(--bg-primary); color: var(--text-main); transition: background 0.3s, color 0.3s; }
        #map { height: calc(100vh - 80px); width: 100%; transition: opacity 0.5s; }
        .header { height: 80px; background: var(--bg-header); color: var(--text-header); display: flex; align-items: center; padding: 0 20px; justify-content: space-between; box-shadow: 0 2px 10px rgba(0,0,0,0.3); position: relative; z-index: 1000; }
        .header h1 { margin: 0; font-size: 20px; font-weight: 600; }
        .logo { height: 40px; width: 40px; border-radius: 50%; background: white; padding: 5px; object-fit: contain; }
        
        .theme-toggle { cursor: pointer; background: rgba(255,255,255,0.1); border: none; padding: 8px; border-radius: 10px; color: white; display: flex; align-items: center; justify-content: center; transition: 0.3s; margin-left: 15px; }
        .theme-toggle:hover { background: rgba(255,255,255,0.2); transform: scale(1.05); }
        .theme-toggle svg { width: 20px; height: 20px; }

        .status-container { display: flex; align-items: center; gap: 10px; }
        .status-dot { width: 10px; height: 10px; background: #4CAF50; border-radius: 50%; box-shadow: 0 0 5px #4CAF50; animation: blink 1.5s infinite; }
        @keyframes blink { 0% { opacity: 1; } 50% { opacity: 0.3; } 100% { opacity: 1; } }
        .info-pill { background: rgba(255,255,255,0.1); padding: 5px 15px; border-radius: 20px; font-size: 13px; font-weight: 500; color: white; }
        
        /* Trip Detail Card */
        .trip-detail-card { 
            position: absolute; bottom: 20px; left: 20px; right: 20px; 
            background: var(--card-bg); border-radius: 16px; padding: 20px; 
            color: var(--text-main); z-index: 1000; display: none;
            box-shadow: 0 10px 30px var(--card-shadow); border: 1px solid var(--card-border);
            max-width: 500px; margin: 0 auto; transition: all 0.3s;
        }
        .trip-info-item { display: flex; align-items: flex-start; gap: 12px; margin-bottom: 12px; }
        .trip-info-item:last-child { margin-bottom: 0; }
        .dot-connector { width: 12px; display: flex; flex-direction: column; align-items: center; }
        .outer-dot { width: 10px; height: 10px; border-radius: 50%; border: 2px solid #F4C20D; }
        .inner-line { width: 2px; height: 25px; background: rgba(128,128,128,0.2); }
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
        <div style="display:flex; align-items:center;">
            <img src="../assets/logo.png" alt="Logo" class="logo" id="main-logo">
            <button class="theme-toggle" id="theme-toggle-btn" onclick="toggleTheme()" title="Switch Theme">
                <!-- Sun/Moon SVG will be updated by script -->
                <svg id="theme-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></svg>
            </button>
            <h1 style="margin-left: 15px;">Live Tracking</h1>
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

    <!-- Google Maps API -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY&callback=initMap&libraries=geometry,places" async defer></script>
    <script src="maps.js"></script>
    <script>
        const sunIcon = `<path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42M12 7a5 5 0 1 0 0 10 5 5 0 0 0 0-10z"></path>`;
        const moonIcon = `<path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>`;

        let urlParams = new URLSearchParams(window.location.search);
        let bookingId = urlParams.get('booking_id');
        let tripDetailsLoaded = false;
        
        // Theme Management
        function setTheme(theme) {
            document.body.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);
            document.getElementById('theme-icon').innerHTML = theme === 'dark' ? sunIcon : moonIcon;
            if (window.applyMapTheme) window.applyMapTheme(theme === 'dark');
        }

        function toggleTheme() {
            const current = localStorage.getItem('theme') || 'light';
            setTheme(current === 'light' ? 'dark' : 'light');
        }

        // Initialize theme on load
        const savedTheme = localStorage.getItem('theme') || 'light';
        setTheme(savedTheme);

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
    </script>
</body>
</html>
