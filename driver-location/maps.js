/**
 * Choose A Taxi - Next-Level Google Maps Tracking Script
 * Features: Pure JS, Smooth Marker Interpolation, Directions Polyline, Geocoding.
 */

let map;
let taxiMarker;
let pickupMarker;
let dropMarker;
let directionsService;
let directionsRenderer;
let geocoder;

let currentPosition = null;
let targetPosition = null;
let animationStartTime = null;
const POLLING_INTERVAL = 3000;

// Professional Map Styles
const darkStyle = [
    { "elementType": "geometry", "stylers": [{ "color": "#212121" }] },
    { "elementType": "labels.icon", "stylers": [{ "visibility": "off" }] },
    { "elementType": "labels.text.fill", "stylers": [{ "color": "#757575" }] },
    { "elementType": "labels.text.stroke", "stylers": [{ "color": "#212121" }] },
    { "featureType": "administrative", "elementType": "geometry", "stylers": [{ "color": "#757575" }] },
    { "featureType": "poi", "elementType": "geometry", "stylers": [{ "color": "#181818" }] },
    { "featureType": "road", "elementType": "geometry.fill", "stylers": [{ "color": "#2c2c2c" }] },
    { "featureType": "road", "elementType": "labels.text.fill", "stylers": [{ "color": "#8a8a8a" }] },
    { "featureType": "water", "elementType": "geometry", "stylers": [{ "color": "#000000" }] }
];

const lightStyle = [
    { "featureType": "water", "elementType": "geometry", "stylers": [{ "color": "#e9e9e9" }, { "lightness": 17 }] },
    { "featureType": "landscape", "elementType": "geometry", "stylers": [{ "color": "#f5f5f5" }, { "lightness": 20 }] },
    { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [{ "color": "#ffffff" }, { "lightness": 17 }] },
    { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [{ "color": "#ffffff" }, { "lightness": 29 }, { "weight": 0.2 }] },
    { "featureType": "road.arterial", "elementType": "geometry", "stylers": [{ "color": "#ffffff" }, { "lightness": 18 }] },
    { "featureType": "road.local", "elementType": "geometry", "stylers": [{ "color": "#ffffff" }, { "lightness": 16 }] },
    { "featureType": "poi", "elementType": "geometry", "stylers": [{ "color": "#f5f5f5" }, { "lightness": 21 }] },
    { "elementType": "labels.text.stroke", "stylers": [{ "visibility": "on" }, { "color": "#ffffff" }, { "lightness": 16 }] },
    { "elementType": "labels.text.fill", "stylers": [{ "saturation": 36 }, { "color": "#333333" }, { "lightness": 40 }] },
    { "elementType": "labels.icon", "stylers": [{ "visibility": "off" }] }
];

function initMap() {
    const isDark = (localStorage.getItem('theme') || 'light') === 'dark';

    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 20.5937, lng: 78.9629 },
        zoom: 5,
        styles: isDark ? darkStyle : lightStyle,
        disableDefaultUI: true,
        backgroundColor: isDark ? '#1c1c1c' : '#f5f5f5'
    });

    directionsService = new google.maps.DirectionsService();
    directionsRenderer = new google.maps.DirectionsRenderer({
        map: map,
        suppressMarkers: true,
        polylineOptions: {
            strokeColor: "#2196F3",
            strokeWeight: 6,
            strokeOpacity: 0.8
        }
    });
    geocoder = new google.maps.Geocoder();

    window.applyMapTheme = (isDarkTheme) => {
        map.setOptions({
            styles: isDarkTheme ? darkStyle : lightStyle,
            backgroundColor: isDarkTheme ? '#1c1c1c' : '#f5f5f5'
        });
        if (taxiMarker) {
            taxiMarker.setIcon(getTaxiIcon(isDarkTheme));
        }
    };

    if (bookingId) {
        startTrackingProcess();
    }
}

function getTaxiIcon(isDark) {
    return {
        url: isDark ? '../assets/driver-icon.png' : '../assets/driver-icon.png',
        scaledSize: new google.maps.Size(46, 46),
        anchor: new google.maps.Point(23, 23)
    };
}

async function startTrackingProcess() {
    updateLocation();
    setInterval(updateLocation, POLLING_INTERVAL);
    requestAnimationFrame(animateMarker);
}

async function updateLocation() {
    if (!bookingId) return;
    try {
        const response = await fetch(`driver_location_api.php?action=get_location&booking_id=${bookingId}`);
        const data = await response.json();

        if (data.success && data.data) {
            const lat = parseFloat(data.data.latitude);
            const lng = parseFloat(data.data.longitude);
            const newPos = { lat, lng };

            if (!tripDetailsLoaded) {
                loadTripMetadata(data.data.pickup_location, data.data.drop_location);
            }

            document.getElementById('live-text').innerText = "LIVE";
            document.getElementById('live-indicator-dot').style.background = "#4CAF50";
            document.getElementById('waiting-overlay').style.display = 'none';

            const isDark = document.body.getAttribute('data-theme') === 'dark';

            if (!currentPosition) {
                currentPosition = newPos;
                targetPosition = newPos;
                taxiMarker = new google.maps.Marker({
                    position: newPos,
                    map: map,
                    icon: getTaxiIcon(isDark),
                    optimized: false
                });
                map.setCenter(newPos);
                map.setZoom(16);
            } else {
                targetPosition = newPos;
                animationStartTime = performance.now();
            }
        } else {
            document.getElementById('waiting-overlay').style.display = 'flex';
        }
    } catch (error) {
        console.error("Tracking Error:", error);
    }
}

function animateMarker(timestamp) {
    if (animationStartTime && currentPosition && targetPosition) {
        const elapsed = timestamp - animationStartTime;
        const progress = Math.min(elapsed / POLLING_INTERVAL, 1);

        const lat = currentPosition.lat + (targetPosition.lat - currentPosition.lat) * progress;
        const lng = currentPosition.lng + (targetPosition.lng - currentPosition.lng) * progress;

        const currentStepPos = { lat, lng };
        taxiMarker.setPosition(currentStepPos);

        if (progress >= 1) {
            currentPosition = targetPosition;
            animationStartTime = null;
        }
    }
    requestAnimationFrame(animateMarker);
}

async function loadTripMetadata(pickup, drop) {
    document.getElementById('pickup-text').innerText = pickup;
    document.getElementById('dropoff-text').innerText = drop;
    document.getElementById('trip-detail-card').style.display = 'block';

    const pCoords = await geocode(pickup);
    const dCoords = await geocode(drop);

    if (pCoords) {
        pickupMarker = new google.maps.Marker({
            position: pCoords,
            map: map,
            icon: {
                url: 'https://cdn-icons-png.flaticon.com/512/1673/1673221.png',
                scaledSize: new google.maps.Size(32, 32),
                anchor: new google.maps.Point(16, 32)
            }
        });
    }

    if (dCoords) {
        dropMarker = new google.maps.Marker({
            position: dCoords,
            map: map,
            icon: {
                url: 'https://cdn-icons-png.flaticon.com/512/61/61168.png',
                scaledSize: new google.maps.Size(32, 32),
                anchor: new google.maps.Point(16, 32)
            }
        });
    }

    if (pCoords && dCoords) {
        directionsService.route({
            origin: pCoords,
            destination: dCoords,
            travelMode: google.maps.TravelMode.DRIVING
        }, (response, status) => {
            if (status === "OK") {
                directionsRenderer.setDirections(response);
                const distance = response.routes[0].legs[0].distance.text;
                document.getElementById('trip-distance').innerText = distance;
            }
        });
    }
    tripDetailsLoaded = true;
}

function geocode(address) {
    return new Promise((resolve) => {
        geocoder.geocode({ address: address }, (results, status) => {
            if (status === "OK" && results[0]) {
                resolve({
                    lat: results[0].geometry.location.lat(),
                    lng: results[0].geometry.location.lng()
                });
            } else {
                resolve(null);
            }
        });
    });
}
