<!-- Redesigned Footer - Choose A Taxi -->
<footer class="site-footer">
    <!-- 1. Footer Top CTA Strip -->
    <div class="footer-top-cta">
        <div class="footer-cta-container">
            <div class="cta-inner">
                <!-- Left Branding Block -->
                <div class="cta-left">
                    <a href="index.php" class="cta-logo">
                        <img src="assets/logo.png" alt="Choose A Taxi Logo">
                    </a>
                    <p class="cta-tagline">
                        We successfully deliver reliable intercity and local cab booking services across India, providing a professional, safe, and comfortable travel experience with long-term guarantees.
                    </p>
                </div>

                <!-- Right Slanted Hotline Block -->
                <div class="cta-right-slanted">
                    <div class="cta-hotline-inner">
                        <div class="cta-hotline-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <div class="cta-hotline-details">
                            <span class="cta-hotline-label">Call For Taxi</span>
                            <a href="tel:8058602516" class="cta-hotline-value">80586-02516</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 2. Main Footer Body -->
    <div class="footer-main">
        <div class="footer-grid-container">
            <div class="footer-grid">
                <!-- Column 1: Working Hours -->
                <div class="footer-column">
                    <h3 class="footer-title">Working Hours</h3>
                    <div class="working-hours-list">
                        <div class="working-hour-item">
                            <span class="day-label">Monday - Friday:</span>
                            <span class="time-value">9.00Am To 8.00pm</span>
                        </div>
                        <div class="working-hour-item">
                            <span class="day-label">Saturday:</span>
                            <span class="time-value">10.00am To 7.30pm</span>
                        </div>
                        <div class="working-hour-item">
                            <span class="day-label">Sunday:</span>
                            <span class="time-value highlight-closed">Close Day!</span>
                        </div>
                    </div>
                </div>

                <!-- Column 2: Useful Links -->
                <div class="footer-column">
                    <h3 class="footer-title">Useful Links</h3>
                    <ul class="footer-nav-links">
                        <li><a href="index.php"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="index.php#services"><i class="fas fa-chevron-right"></i> Our Services</a></li>
                        <li><a href="index.php#price-list"><i class="fas fa-chevron-right"></i> Price List</a></li>
                        <li><a href="index.php#fleet"><i class="fas fa-chevron-right"></i> Premium Fleet</a></li>
                        <li><a href="partner-registration.php"><i class="fas fa-chevron-right"></i> Partner Registration</a></li>
                    </ul>
                </div>

                <!-- Column 3: Head Office -->
                <div class="footer-column">
                    <h3 class="footer-title">Head Office</h3>
                    <div class="office-info">
                        <div class="info-block">
                            <span class="info-label">Location:</span>
                            <p class="info-value">40, Ashok Vihar Phase-3 Ext. Gurgaon-122001, Haryana, India</p>
                        </div>
                        <div class="info-block">
                            <span class="info-label">Join Us:</span>
                            <a href="mailto:info@chooseataxi.in" class="info-value email-link">info@chooseataxi.in</a>
                        </div>
                    </div>
                </div>

                <!-- Column 4: Newsletter Signup -->
                <div class="footer-column">
                    <h3 class="footer-title">Newsletter Signup</h3>
                    <div class="newsletter-box">
                        <form action="#" method="POST" class="newsletter-form" onsubmit="event.preventDefault(); alert('Subscribed successfully!');">
                            <div class="newsletter-input-wrapper">
                                <input type="email" placeholder="Your email address" class="newsletter-input" required>
                            </div>
                            <button type="submit" class="newsletter-btn">
                                <span>Subscribe Now</span>
                            </button>
                        </form>
                        <p class="newsletter-note">Get the latest updates and offers for business services yearly.</p>
                    </div>
                </div>
            </div>
        </div>



        <!-- Road & Moving Taxi Animation -->
        <div class="footer-road">
            <div class="road-surface">
                <div class="road-lines"></div>
                
                <!-- Taxi 1 (Foreground/Fast Lane) -->
                <div class="taxi-container taxi-1">
                    <svg class="moving-taxi" viewBox="0 0 120 50" xmlns="http://www.w3.org/2000/svg">
                        <ellipse cx="60" cy="42" rx="46" ry="4" fill="rgba(0,0,0,0.35)" />
                        <!-- Car body -->
                        <path d="M15 32 L15 24 Q15 17 25 17 L38 17 Q43 9 53 9 L80 9 Q87 9 92 17 L102 17 Q108 20 108 27 L108 34 Q108 37 103 37 L96 37 Q96 32 86 32 Q76 32 76 37 L40 37 Q40 32 30 32 Q20 32 20 37 L10 37 Q5 37 5 34 Z" fill="#ffb703" />
                        <!-- Glass -->
                        <path d="M36 18 L48 18 L48 24 L21 24 Q23 19 36 18 Z" fill="#111" />
                        <path d="M52 11 L76 11 L76 24 L52 24 Z" fill="#111" />
                        <path d="M80 18 L88 18 Q91 20 93 24 L80 24 Z" fill="#111" />
                        <!-- Wheels -->
                        <circle cx="30" cy="37" r="9" fill="#1e1e24" stroke="#ffb703" stroke-width="1.5" />
                        <circle cx="30" cy="37" r="3" fill="#ffffff" />
                        <circle cx="86" cy="37" r="9" fill="#1e1e24" stroke="#ffb703" stroke-width="1.5" />
                        <circle cx="86" cy="37" r="3" fill="#ffffff" />
                        <!-- Taxi sign -->
                        <path d="M55 9 L57 4 L71 4 L73 9 Z" fill="#111" />
                        <rect x="59" y="5.5" width="10" height="3" fill="#ffb703" rx="0.5" />
                        <text x="64" y="8" font-size="3" font-family="'Arial Black', sans-serif" font-weight="900" fill="#111" text-anchor="middle">TAXI</text>
                        <!-- Checker pattern -->
                        <path d="M17 28 L93 28" stroke="#111" stroke-width="2.5" stroke-dasharray="2.5,2.5" />
                    </svg>
                </div>

                <!-- Taxi 2 (Background/Slow Lane) -->
                <div class="taxi-container taxi-2">
                    <svg class="moving-taxi" viewBox="0 0 120 50" xmlns="http://www.w3.org/2000/svg">
                        <ellipse cx="60" cy="42" rx="46" ry="4" fill="rgba(0,0,0,0.35)" />
                        <!-- Car body -->
                        <path d="M15 32 L15 24 Q15 17 25 17 L38 17 Q43 9 53 9 L80 9 Q87 9 92 17 L102 17 Q108 20 108 27 L108 34 Q108 37 103 37 L96 37 Q96 32 86 32 Q76 32 76 37 L40 37 Q40 32 30 32 Q20 32 20 37 L10 37 Q5 37 5 34 Z" fill="#ffc300" />
                        <!-- Glass -->
                        <path d="M36 18 L48 18 L48 24 L21 24 Q23 19 36 18 Z" fill="#111" />
                        <path d="M52 11 L76 11 L76 24 L52 24 Z" fill="#111" />
                        <path d="M80 18 L88 18 Q91 20 93 24 L80 24 Z" fill="#111" />
                        <!-- Wheels -->
                        <circle cx="30" cy="37" r="9" fill="#1e1e24" stroke="#ffc300" stroke-width="1.5" />
                        <circle cx="30" cy="37" r="3" fill="#ffffff" />
                        <circle cx="86" cy="37" r="9" fill="#1e1e24" stroke="#ffc300" stroke-width="1.5" />
                        <circle cx="86" cy="37" r="3" fill="#ffffff" />
                        <!-- Taxi sign -->
                        <path d="M55 9 L57 4 L71 4 L73 9 Z" fill="#111" />
                        <rect x="59" y="5.5" width="10" height="3" fill="#ffc300" rx="0.5" />
                        <text x="64" y="8" font-size="3" font-family="'Arial Black', sans-serif" font-weight="900" fill="#111" text-anchor="middle">TAXI</text>
                        <!-- Checker pattern -->
                        <path d="M17 28 L93 28" stroke="#111" stroke-width="2.5" stroke-dasharray="2.5,2.5" />
                    </svg>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. Copyright Strip -->
    <div class="footer-bottom-strip">
        <div class="footer-grid-container">
            <div class="bottom-strip-inner">
                <p class="copyright-text">&copy; 2026 Choose A Taxi. All rights reserved.</p>
                <div class="footer-social-links">
                    <a href="#" class="social-link-btn" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link-btn" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link-btn" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-link-btn" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
    </div>

    <!-- Sticky WhatsApp Button -->
    <a href="https://wa.me/918058602516" target="_blank" rel="noopener noreferrer" class="whatsapp-sticky-btn" aria-label="Chat on WhatsApp">
        <i class="fab fa-whatsapp"></i>
    </a>
</footer>
