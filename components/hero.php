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
                <form action="search-results.php" method="GET" id="searchCabForm">
                    <!-- Trip Type Toggle -->
                    <div class="trip-type">
                        <input type="hidden" name="trip_type" id="trip_type" value="One Way">
                        <div class="trip-option active" data-type="One Way">
                            <i class="fas fa-dot-circle"></i> One Way Trip
                        </div>
                        <div class="trip-option" data-type="Round Trip">
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
                            <input type="tel" name="phone" placeholder="CONTACT NO." required>
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

        if (pickupInput) new google.maps.places.Autocomplete(pickupInput, autocompleteOptions);
        if (dropInput) new google.maps.places.Autocomplete(dropInput, autocompleteOptions);
    }

    // Handle Trip Type Selection
    document.querySelectorAll('.trip-option').forEach(opt => {
        opt.addEventListener('click', function() {
            document.querySelectorAll('.trip-option').forEach(x => {
                x.classList.remove('active');
                x.querySelector('i').className = 'far fa-circle';
            });
            this.classList.add('active');
            this.querySelector('i').className = 'fas fa-dot-circle';
            document.getElementById('trip_type').value = this.dataset.type;
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
        document.getElementById('start-date').value = now.toISOString().split('T')[0];
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        document.getElementById('start-time').value = `${hours}:${minutes}`;
        initAutocomplete();
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCT5jMYUaHtsT2Z2IzkQgl-8TsIw_946VY&libraries=places&callback=initAutocomplete" async defer></script>
