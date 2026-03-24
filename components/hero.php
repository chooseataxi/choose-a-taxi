<section class="hero-section">
    <div class="hero-container">
        <!-- Hero Left Content -->
        <div class="hero-content">
            <div class="hero-text-area">
                <h1>All india cab booking services</h1>
                <p class="subtitle">booking services</p>
            </div>
            <div class="hero-image-wrapper">
                <img src="assets/frontend-images/hero-new-bg.jpeg" alt="Hero Car" class="hero-car-img">
            </div>
        </div>

        <!-- Hero Right Booking Card -->
        <div class="booking-card">
            <div class="card-header">
                All india cab services
            </div>
            
            <div class="booking-tabs">
                <button class="tab-btn active">Out Station</button>
                <button class="tab-btn">Local / Airport</button>
            </div>

            <div class="form-body">
                <form action="#" method="POST">
                    <!-- Trip Type Toggle -->
                    <div class="trip-type">
                        <div class="trip-option active">
                            <i class="fas fa-dot-circle"></i> One Way Trip
                        </div>
                        <div class="trip-option">
                            <i class="far fa-circle"></i> Round Trip
                        </div>
                    </div>

                    <!-- Pickup Address -->
                    <div class="form-group">
                        <label>PICK-UP ADDRESS</label>
                        <div class="form-input-wrapper">
                            <input type="text" id="pickup_address" placeholder="City, Airport, Station, etc." required>
                        </div>
                    </div>

                    <!-- Stop Address -->
                    <div class="form-group">
                        <label>STOP ADDRESS</label>
                        <div class="form-input-wrapper">
                            <input type="text" id="stop_address" placeholder="NEXT STOP ADDRESS">
                        </div>
                        <button type="button" class="add-stop-btn">+ Add Stop Address</button>
                    </div>

                    <!-- Contact No -->
                    <div class="form-group" style="clear: both;">
                        <label>CONTACT NO.</label>
                        <div class="form-input-wrapper">
                            <span style="font-size: 14px; margin-right: 10px; display: flex; align-items: center; gap: 5px;">
                                <img src="https://flagcdn.com/w20/in.png" srcset="https://flagcdn.com/w40/in.png 2x" width="20" alt="India">
                                +91 <i class="fas fa-chevron-down" style="font-size: 10px;"></i>
                            </span>
                            <input type="tel" placeholder="CONTACT NO." required>
                        </div>
                    </div>

                    <!-- Date and Time Row -->
                    <div class="form-row">
                        <div class="form-group">
                            <label>Start date</label>
                            <div class="form-input-wrapper">
                                <input type="text" value="24-03-2026" id="start-date" required>
                                <i class="far fa-calendar-alt" style="color: #666;"></i>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Start time</label>
                            <div class="form-input-wrapper">
                                <input type="text" value="23:17" id="start-time" required>
                                <i class="far fa-clock" style="color: #666;"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="search-btn">SEARCH CAB</button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Google Places API Integration -->
<script>
    function initAutocomplete() {
        if (!google || !google.maps || !google.maps.places) return;

        const options = {
            componentRestrictions: { country: "in" },
            fields: ["address_components", "geometry", "icon", "name"],
            strictBounds: false,
        };

        const pickupInput = document.getElementById("pickup_address");
        const stopInput = document.getElementById("stop_address");

        if (pickupInput) {
            new google.maps.places.Autocomplete(pickupInput, options);
        }
        if (stopInput) {
            new google.maps.places.Autocomplete(stopInput, options);
        }
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY&libraries=places&callback=initAutocomplete" async defer></script>
