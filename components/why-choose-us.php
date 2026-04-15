<?php
/**
 * Workflow Component - Choose A Taxi
 * Replaces the old Why Choose Us with a dynamic step-by-step design.
 */
?>
<section class="workflow-section">
    <div class="workflow-container">
        <div class="section-header-modern">
            <h2>Easy. Convenient <span>Quick.</span></h2>
            <p>The simple & Quick steps to your booking.</p>
        </div>

        <div class="workflow-steps-wrapper">
            <!-- Connector Line (SVG) -->
            <svg class="workflow-connector-svg" viewBox="0 0 1000 600" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M350 50 H650 C800 50 800 250 650 250 H350 C200 250 200 450 350 450 H650" stroke="#eee" stroke-width="6" stroke-linecap="round" />
                <path class="path-active" d="M350 50 H650 C800 50 800 250 650 250 H350 C200 250 200 450 350 450 H650" stroke="url(#gradient-green)" stroke-width="6" stroke-linecap="round" />
                <defs>
                    <linearGradient id="gradient-green" x1="0%" y1="0%" x2="100%" y2="0%">
                        <stop offset="0%" stop-color="#28a745" />
                        <stop offset="100%" stop-color="#20c997" />
                    </linearGradient>
                </defs>
            </svg>

            <!-- Step 1 -->
            <div class="workflow-step step-1">
                <div class="step-content">
                    <span class="step-num">01</span>
                    <h3>Searching</h3>
                    <p>Enter your pickup and drop location with date and time.</p>
                </div>
                <div class="step-icon-box">
                    <i class="fas fa-search-location"></i>
                </div>
            </div>

            <!-- Step 2 -->
            <div class="workflow-step step-2">
                <div class="step-icon-box">
                    <i class="fas fa-car-side"></i>
                </div>
                <div class="step-content">
                    <span class="step-num">02</span>
                    <h3>Comparison</h3>
                    <p>AI matches the best cab at lowest price for your route.</p>
                </div>
            </div>

            <!-- Step 3 -->
            <div class="workflow-step step-3">
                <div class="step-content">
                    <span class="step-num">03</span>
                    <h3>Booking</h3>
                    <p>Confirm booking with instant assigning your driver.</p>
                </div>
                <div class="step-icon-box">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>

            <!-- Step 4 -->
            <div class="workflow-step step-4">
                <div class="step-icon-box">
                    <i class="fas fa-smile"></i>
                </div>
                <div class="step-content">
                    <span class="step-num">04</span>
                    <h3>Celebrate</h3>
                    <p>Sit back and enjoy your comfortable and safe journey.</p>
                </div>
            </div>
        </div>

        <div class="workflow-footer">
            <a href="login.php" class="btn-get-started">Get Started <i class="fas fa-chevron-right"></i></a>
        </div>
    </div>
</section>
