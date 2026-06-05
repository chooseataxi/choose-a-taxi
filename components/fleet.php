<?php
/**
 * Redesigned Fleet Slider Component - Choose A Taxi
 * Features 7 slanted vehicle cards in a horizontal scrolling track with nav buttons.
 */
?>
<section class="fleet-section" id="fleet">
    <div class="fleet-container">
        <!-- Header with navigation arrows -->
        <div class="fleet-header">
            <h2>Our <span>Premium Fleet</span></h2>
            <div class="fleet-slider-nav">
                <button class="fleet-nav-btn prev-btn" id="fleetPrevBtn" aria-label="Previous Vehicles">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="fleet-nav-btn next-btn" id="fleetNextBtn" aria-label="Next Vehicles">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>

        <!-- Slider container and track -->
        <div class="fleet-slider-container">
            <div class="fleet-slider-track" id="fleetSliderTrack">
                
                <!-- 1. WagonR, Celerio (Hatchback) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">Hatchback Class</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1774870556.png" alt="WagonR, Celerio Hatchback">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>4+1 Seats</span>
                        </div>
                        <h3>WagonR, Celerio [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 2750</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book Hatchback</a>
                    </div>
                </div>

                <!-- 2. Swift Dzire, Etios (Sedan) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">Sedan Class</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1775239319.png" alt="Dzire, Etios Sedan">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>4+1 Seats</span>
                        </div>
                        <h3>Swift Dzire, Etios [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 3250</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book Sedan</a>
                    </div>
                </div>

                <!-- 3. Ertiga (SUV) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">SUV Class</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1775239429.png" alt="Ertiga SUV">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>6+1 Seats</span>
                        </div>
                        <h3>Ertiga [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 4000</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book SUV</a>
                    </div>
                </div>

                <!-- 4. Innova Crysta (Premium SUV) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">Premium SUV</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1775239887.png" alt="Innova Crysta SUV">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>6+1 Seats</span>
                        </div>
                        <h3>Innova Crysta [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 4500</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book Crysta</a>
                    </div>
                </div>

                <!-- 5. Toyota Fortuner (Luxury SUV) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">Luxury SUV</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1775240719.png" alt="Toyota Fortuner Luxury SUV">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>6+1 Seats</span>
                        </div>
                        <h3>Toyota Fortuner [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 8500</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book Fortuner</a>
                    </div>
                </div>

                <!-- 6. Tempo Traveler (Van Class) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">Van Class</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1775322458.png" alt="Tempo Traveler Minivan">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>12+1 Seats</span>
                        </div>
                        <h3>Tempo Traveler [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 6500</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book Van</a>
                    </div>
                </div>

                <!-- 7. Honda City, Ciaz (Premium Sedan) -->
                <div class="fleet-slider-card">
                    <span class="fleet-class-name">Premium Sedan</span>
                    <div class="fleet-img-wrapper">
                        <img src="assets/car_types/car_type_1776258519.png" alt="Honda City, Ciaz Premium Sedan">
                    </div>
                    <div class="fleet-yellow-bar"></div>
                    <div class="fleet-card-info">
                        <div class="fleet-card-seats">
                            <i class="fas fa-users"></i> <span>4+1 Seats</span>
                        </div>
                        <h3>Honda City, Ciaz [AC]</h3>
                        <div class="fleet-card-price">
                            Starting from <span class="price-val">Rs. 3800</span>
                        </div>
                        <a href="login.php" class="fleet-book-btn">Book Premium</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<!-- Smooth slider horizontal navigation script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const track = document.getElementById('fleetSliderTrack');
    const prevBtn = document.getElementById('fleetPrevBtn');
    const nextBtn = document.getElementById('fleetNextBtn');
    
    if (track && prevBtn && nextBtn) {
        // Scroll right action
        nextBtn.addEventListener('click', function() {
            const firstCard = track.querySelector('.fleet-slider-card');
            if (firstCard) {
                const scrollOffset = firstCard.offsetWidth + 25; // card width + grid gap
                track.scrollBy({ left: scrollOffset, behavior: 'smooth' });
            }
        });

        // Scroll left action
        prevBtn.addEventListener('click', function() {
            const firstCard = track.querySelector('.fleet-slider-card');
            if (firstCard) {
                const scrollOffset = firstCard.offsetWidth + 25; // card width + grid gap
                track.scrollBy({ left: -scrollOffset, behavior: 'smooth' });
            }
        });
    }
});
</script>