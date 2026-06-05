<section class="hero-section">
    <div class="hero-container">
        <!-- Hero Left Content -->
        <div class="hero-content">
            <div class="hero-text-area">
                <h1>All india cab booking services</h1>
                <p class="subtitle">booking services</p>
            </div>
            <div class="hero-image-wrapper">
                <img src="assets/frontend-images/slider-car.png" alt="Hero Car" class="hero-car-img">
            </div>
        </div>

        <!-- Hero Right Booking Card -->
        <div class="booking-card">
            <div class="card-header">
                All india cab services
            </div>
            
            <div class="booking-tabs">
                <button type="button" class="tab-btn main-tab-btn active" data-target="outstation-section">Out Station</button>
                <button type="button" class="tab-btn main-tab-btn" data-target="local-airport-section">Local / Airport</button>
            </div>

            <div class="form-body">
                <form action="search-results.php" method="GET" id="searchCabForm">
                    <input type="hidden" name="main_tab" id="main_tab" value="Out Station">

                    <!-- OUT STATION SECTION -->
                    <div id="outstation-section">
                        <!-- Trip Type Toggle -->
                        <div class="trip-type">
                            <input type="hidden" name="trip_type" id="trip_type" value="One Way">
                            <div class="trip-option outstation-trip-option active" data-type="One Way">
                                <i class="fas fa-dot-circle"></i> One Way Trip
                            </div>
                            <div class="trip-option outstation-trip-option" data-type="Round Trip">
                                <i class="far fa-circle"></i> Round Trip
                            </div>
                        </div>

                        <!-- Pickup Address -->
                        <div class="form-group">
                            <label>PICK-UP ADDRESS</label>
                            <div class="form-input-wrapper">
                                <input type="text" name="pickup" id="pickup_address" placeholder="City, Airport, Station, etc." required>
                            </div>
                        </div>

                        <!-- Drop Address -->
                        <div class="form-group">
                            <label>DROP ADDRESS</label>
                            <div class="form-input-wrapper">
                                <input type="text" name="drop" id="drop_address" placeholder="DESTINATION CITY" required>
                            </div>
                        </div>

                        <!-- Stop Records Container -->
                        <div id="stops-container"></div>

                        <!-- Add Stop Button -->
                        <div class="form-group">
                            <button type="button" class="add-stop-btn" id="btn-add-stop">+ Add Stop Address</button>
                        </div>

                        <!-- Contact No -->
                        <div class="form-group" style="clear: both;">
                            <label>CONTACT NO.</label>
                            <div class="form-input-wrapper">
                                <span style="font-size: 14px; margin-right: 10px; display: flex; align-items: center; gap: 5px;">
                                    <img src="https://flagcdn.com/w20/in.png" srcset="https://flagcdn.com/w40/in.png 2x" width="20" alt="India">
                                    +91 <i class="fas fa-chevron-down" style="font-size: 10px;"></i>
                                </span>
                                <input type="tel" name="phone" id="outstation_phone" placeholder="CONTACT NO." required>
                            </div>
                        </div>

                        <!-- Date and Time Row -->
                        <div class="form-row">
                            <div class="form-group">
                                <label>Start date</label>
                                <div class="form-input-wrapper">
                                    <input type="date" name="date" id="start-date" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Start time</label>
                                <div class="form-input-wrapper">
                                    <input type="time" name="time" id="start-time" required>
                                </div>
                            </div>
                        </div>

                        <!-- Return Date and Time Row (Round Trip Only) -->
                        <div class="form-row" id="return-date-row" style="display: none;">
                            <div class="form-group">
                                <label>Return date</label>
                                <div class="form-input-wrapper">
                                    <input type="date" name="return_date" id="return-date">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Return time</label>
                                <div class="form-input-wrapper">
                                    <input type="time" name="return_time" id="return-time">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- LOCAL / AIRPORT SECTION -->
                    <div id="local-airport-section" style="display: none;">
                        <div class="trip-type">
                            <input type="hidden" name="local_trip_type" id="local_trip_type" value="Local / Rental">
                            <div class="trip-option local-trip-option active" data-type="Local / Rental">
                                <i class="fas fa-dot-circle"></i> Local / Rental
                            </div>
                            <div class="trip-option local-trip-option" data-type="Airport Transfer">
                                <i class="far fa-circle"></i> Airport Transfer
                            </div>
                        </div>

                        <!-- Pickup Address -->
                        <div class="form-group">
                            <label>PICK-UP ADDRESS</label>
                            <div class="form-input-wrapper">
                                <input type="text" name="local_pickup" id="local_pickup_address" placeholder="City, Airport, Station, etc.">
                            </div>
                        </div>

                        <!-- Local / Rental Specific Fields -->
                        <div id="local-rental-fields">
                            <div class="form-group">
                                <label>City</label>
                                <div class="form-input-wrapper" style="padding: 0; border: none; background: #f1f3f5;">
                                    <select name="city" id="local_city" style="width: 100%; border: 1px solid #e5e7eb; border-radius: 5px; padding: 12px; font-size: 14px; background: transparent; color: #555; outline: none; cursor: pointer;">
                                        <option value="">--- Select City ---</option>
                                        <option value="Delhi">Delhi</option>
                                        <option value="Mumbai">Mumbai</option>
                                        <option value="Bangalore">Bangalore</option>
                                        <option value="Chennai">Chennai</option>
                                        <option value="Kolkata">Kolkata</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Package</label>
                                <div class="form-input-wrapper" style="padding: 0; border: none; background: #f1f3f5;">
                                    <select name="package" id="local_package" style="width: 100%; border: 1px solid #e5e7eb; border-radius: 5px; padding: 12px; font-size: 14px; background: transparent; color: #555; outline: none; cursor: pointer;">
                                        <option value="">--- Select Package ---</option>
                                        <option value="8 Hours / 80 Kms">8 Hours / 80 Kms</option>
                                        <option value="12 Hours / 120 Kms">12 Hours / 120 Kms</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Airport Transfer Specific Fields -->
                        <div id="airport-transfer-fields" style="display: none;">
                            <div class="form-group">
                                <label>STOP ADDRESS</label>
                                <div class="form-input-wrapper">
                                    <input type="text" name="airport_drop" id="airport_drop_address" placeholder="NEXT STOP ADDRESS">
                                </div>
                            </div>
                        </div>

                        <!-- Shared Contact No & Date/Time for Local Section -->
                        <div class="form-group" style="clear: both;">
                            <label>CONTACT NO.</label>
                            <div class="form-input-wrapper">
                                <span style="font-size: 14px; margin-right: 10px; display: flex; align-items: center; gap: 5px;">
                                    <img src="https://flagcdn.com/w20/in.png" srcset="https://flagcdn.com/w40/in.png 2x" width="20" alt="India">
                                    +91 <i class="fas fa-chevron-down" style="font-size: 10px;"></i>
                                </span>
                                <input type="tel" name="local_phone" id="local_phone" placeholder="CONTACT NO.">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Start date</label>
                                <div class="form-input-wrapper">
                                    <input type="date" name="local_date" id="local-start-date">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Start time</label>
                                <div class="form-input-wrapper">
                                    <input type="time" name="local_time" id="local-start-time">
                                </div>
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
    let autocompleteOptions = {
        componentRestrictions: { country: "in" },
        fields: ["formatted_address", "geometry"],
    };

    function initAutocomplete() {
        if (typeof google === 'undefined') return;

        const pickupInput = document.getElementById("pickup_address");
        const dropInput = document.getElementById("drop_address");
        const localPickupInput = document.getElementById("local_pickup_address");
        const airportDropInput = document.getElementById("airport_drop_address");

        if (pickupInput) new google.maps.places.Autocomplete(pickupInput, autocompleteOptions);
        if (dropInput) new google.maps.places.Autocomplete(dropInput, autocompleteOptions);
        if (localPickupInput) new google.maps.places.Autocomplete(localPickupInput, autocompleteOptions);
        if (airportDropInput) new google.maps.places.Autocomplete(airportDropInput, autocompleteOptions);
    }

    // Handle Main Tabs
    document.querySelectorAll('.main-tab-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.main-tab-btn').forEach(x => x.classList.remove('active'));
            this.classList.add('active');
            
            const target = this.dataset.target;
            document.getElementById('main_tab').value = this.innerText.trim();
            
            document.getElementById('outstation-section').style.display = target === 'outstation-section' ? 'block' : 'none';
            document.getElementById('local-airport-section').style.display = target === 'local-airport-section' ? 'block' : 'none';

            // Manage required fields based on active section
            const isOutstation = target === 'outstation-section';
            document.getElementById('pickup_address').required = isOutstation;
            document.getElementById('drop_address').required = isOutstation;
            document.getElementById('outstation_phone').required = isOutstation;
            document.getElementById('start-date').required = isOutstation;
            document.getElementById('start-time').required = isOutstation;

            document.getElementById('local_pickup_address').required = !isOutstation;
            document.getElementById('local_phone').required = !isOutstation;
            document.getElementById('local-start-date').required = !isOutstation;
            document.getElementById('local-start-time').required = !isOutstation;
            
            // Manage inner local fields requirement
            if (!isOutstation) {
                const localTripType = document.getElementById('local_trip_type').value;
                document.getElementById('local_city').required = localTripType === 'Local / Rental';
                document.getElementById('local_package').required = localTripType === 'Local / Rental';
                document.getElementById('airport_drop_address').required = localTripType === 'Airport Transfer';
            } else {
                document.getElementById('local_city').required = false;
                document.getElementById('local_package').required = false;
                document.getElementById('airport_drop_address').required = false;
            }
        });
    });

    // Handle Outstation Trip Type Selection
    document.querySelectorAll('.outstation-trip-option').forEach(opt => {
        opt.addEventListener('click', function() {
            document.querySelectorAll('.outstation-trip-option').forEach(x => {
                x.classList.remove('active');
                x.querySelector('i').className = 'far fa-circle';
            });
            this.classList.add('active');
            this.querySelector('i').className = 'fas fa-dot-circle';
            
            const tripType = this.dataset.type;
            document.getElementById('trip_type').value = tripType;
            
            // Toggle Return Date fields
            const returnRow = document.getElementById('return-date-row');
            if (tripType === 'Round Trip') {
                returnRow.style.display = 'flex';
                document.getElementById('return-date').required = true;
                document.getElementById('return-time').required = true;
            } else {
                returnRow.style.display = 'none';
                document.getElementById('return-date').required = false;
                document.getElementById('return-time').required = false;
            }
        });
    });

    // Handle Local/Airport Trip Type Selection
    document.querySelectorAll('.local-trip-option').forEach(opt => {
        opt.addEventListener('click', function() {
            document.querySelectorAll('.local-trip-option').forEach(x => {
                x.classList.remove('active');
                x.querySelector('i').className = 'far fa-circle';
            });
            this.classList.add('active');
            this.querySelector('i').className = 'fas fa-dot-circle';
            
            const tripType = this.dataset.type;
            document.getElementById('local_trip_type').value = tripType;
            
            if (tripType === 'Local / Rental') {
                document.getElementById('local-rental-fields').style.display = 'block';
                document.getElementById('airport-transfer-fields').style.display = 'none';
                document.getElementById('local_city').required = true;
                document.getElementById('local_package').required = true;
                document.getElementById('airport_drop_address').required = false;
            } else {
                document.getElementById('local-rental-fields').style.display = 'none';
                document.getElementById('airport-transfer-fields').style.display = 'block';
                document.getElementById('local_city').required = false;
                document.getElementById('local_package').required = false;
                document.getElementById('airport_drop_address').required = true;
            }
        });
    });

    // Add Stop Functionality
    const stopsContainer = document.getElementById('stops-container');
    const addStopBtn = document.getElementById('btn-add-stop');
    let stopCount = 0;

    addStopBtn.addEventListener('click', () => {
        if (stopCount >= 3) {
            alert("Maximum 3 stops allowed");
            return;
        }
        stopCount++;
        const stopId = `stop_${stopCount}`;
        const div = document.createElement('div');
        div.className = 'form-group mb-3';
        div.id = `wrapper_${stopId}`;
        div.innerHTML = `
            <label class="d-flex justify-content-between">
                STOP ${stopCount}
                <span class="text-danger" style="cursor:pointer" onclick="removeStop('${stopId}')">Remove</span>
            </label>
            <div class="form-input-wrapper">
                <input type="text" name="stops[]" id="${stopId}" placeholder="Stop Address" required>
            </div>
        `;
        stopsContainer.appendChild(div);
        new google.maps.places.Autocomplete(document.getElementById(stopId), autocompleteOptions);
    });

    function removeStop(id) {
        document.getElementById(`wrapper_${id}`).remove();
        stopCount--;
    }

    // Set Default Date/Time
    window.onload = () => {
        const now = new Date();
        const dateStr = now.toISOString().split('T')[0];
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const timeStr = `${hours}:${minutes}`;

        document.getElementById('start-date').value = dateStr;
        document.getElementById('start-time').value = timeStr;
        document.getElementById('local-start-date').value = dateStr;
        document.getElementById('local-start-time').value = timeStr;
        
        initAutocomplete();
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY&libraries=places&callback=initAutocomplete" async defer></script>
