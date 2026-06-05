<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose A Taxi - Make The Memorable Trip</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="assets/logo.png">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom Header CSS -->
    <link rel="stylesheet" href="assets/css/header.css">
</head>
<body>

<header class="site-header">
    <!-- 1. Top Bar -->
    <div class="top-bar">
        <div class="header-container">
            <div class="top-bar-inner">
                <div class="top-bar-left">
                    <i class="fas fa-bullhorn icon-alert"></i>
                    <span>India's Premier Taxi Booking Platform! Book safe & reliable cabs.</span>
                </div>
                <div class="top-bar-right">
                    <a href="faq.php" class="top-link">FAQ</a>
                    <a href="support.php" class="top-link">Support</a>
                    <a href="contact.php" class="top-link">Help</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 2. Middle Bar -->
    <div class="middle-bar">
        <div class="header-container">
            <div class="middle-bar-inner">
                <!-- Logo -->
                <div class="logo-area">
                    <a href="index.php" class="logo-link">
                        <img src="assets/logo.png" alt="Choose A Taxi Logo">
                    </a>
                </div>

                <!-- Info Cards -->
                <div class="contact-info-cards">
                    <!-- Phone -->
                    <div class="info-card">
                        <div class="info-card-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <div class="info-card-details">
                            <span class="info-card-label">Call Us Now</span>
                            <a href="tel:8058602516" class="info-card-value">80586 02516</a>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="info-card">
                        <div class="info-card-icon">
                            <i class="far fa-envelope"></i>
                        </div>
                        <div class="info-card-details">
                            <span class="info-card-label">Email Now</span>
                            <a href="mailto:info@chooseataxi.in" class="info-card-value">info@chooseataxi.in</a>
                        </div>
                    </div>

                    <!-- Location -->
                    <div class="info-card">
                        <div class="info-card-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="info-card-details">
                            <span class="info-card-label">Main Office</span>
                            <span class="info-card-value">Gurgaon, HR - 122001</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. Navigation Bar (Orange block and dark button) -->
    <div class="nav-bar">
        <div class="header-container">
            <div class="nav-bar-inner">
                <!-- Slanted Orange Nav Container -->
                <div class="nav-main-wrapper">
                    <nav class="nav-menu">
                        <a href="index.php" class="nav-item active">Home</a>
                        <a href="index.php#services" class="nav-item">Our Services</a>
                        <a href="index.php#price-list" class="nav-item">Price List</a>
                        <a href="index.php#fleet" class="nav-item">Premium Fleet</a>
                        <a href="partner-registration.php" class="nav-item">Partner Registration</a>
                    </nav>

                    <!-- Interactive controls inside orange bar -->
                    <div class="nav-controls">
                        <!-- Search Icon -->
                        <button type="button" class="nav-control-btn" id="search-toggle-btn" aria-label="Search">
                            <i class="fas fa-search"></i>
                        </button>
                        
                        <!-- Hamburger button (for mobile only) -->
                        <button type="button" class="nav-control-btn hamburger-btn" id="mobile-menu-toggle-btn" aria-label="Toggle Menu">
                            <i class="fas fa-bars"></i>
                        </button>
                    </div>
                </div>

                <!-- Book Taxi Dark Button -->
                <div class="nav-actions">
                    <a href="login.php" class="book-btn">
                        <span class="btn-text">Book a Taxi</span>
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Overlay Box (slides down from header) -->
    <div class="search-overlay-bar" id="search-overlay-bar">
        <div class="header-container">
            <form action="search-results.php" method="GET" class="header-search-form">
                <input type="text" name="pickup" placeholder="Enter pickup location to search cabs..." class="search-input" required>
                <button type="submit" class="search-submit-btn">Search</button>
                <button type="button" class="search-close-btn" id="search-close-btn">
                    <i class="fas fa-times"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- Mobile Drawer Overlay -->
    <div class="drawer-overlay" id="drawer-overlay"></div>

    <!-- Mobile Drawer Menu -->
    <div class="drawer-menu" id="drawer-menu">
        <div class="drawer-header">
            <img src="assets/logo.png" alt="Logo" class="drawer-logo">
            <button type="button" class="drawer-close-btn" id="drawer-close-btn" aria-label="Close Menu">
                <i class="fas fa-times"></i>
            </button>
        </div>
        
        <div class="drawer-body">
            <nav class="drawer-nav">
                <a href="index.php" class="drawer-item active"><i class="fas fa-home"></i> Home</a>
                <a href="index.php#services" class="drawer-item"><i class="fas fa-concierge-bell"></i> Our Services</a>
                <a href="index.php#price-list" class="drawer-item"><i class="fas fa-tags"></i> Price List</a>
                <a href="index.php#fleet" class="drawer-item"><i class="fas fa-car"></i> Premium Fleet</a>
                <a href="partner-registration.php" class="drawer-item"><i class="fas fa-handshake"></i> Partner Registration</a>
            </nav>

            <div class="drawer-divider"></div>

            <div class="drawer-contact-info">
                <a href="tel:8058602516" class="drawer-contact-item">
                    <i class="fas fa-phone-alt"></i>
                    <span>+91 80586 02516</span>
                </a>
                <a href="mailto:info@chooseataxi.in" class="drawer-contact-item">
                    <i class="far fa-envelope"></i>
                    <span>info@chooseataxi.in</span>
                </a>
                <div class="drawer-contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span>Gurgaon, Haryana - 122001</span>
                </div>
            </div>
        </div>

        <div class="drawer-footer">
            <a href="login.php" class="drawer-book-btn">Book a Taxi</a>
        </div>
    </div>
</header>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const mobileMenuToggleBtn = document.getElementById('mobile-menu-toggle-btn');
        const drawerCloseBtn = document.getElementById('drawer-close-btn');
        const drawerMenu = document.getElementById('drawer-menu');
        const drawerOverlay = document.getElementById('drawer-overlay');

        // Toggle mobile drawer
        if (mobileMenuToggleBtn && drawerMenu && drawerOverlay) {
            mobileMenuToggleBtn.addEventListener('click', () => {
                drawerMenu.classList.add('active');
                drawerOverlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            });
        }

        const closeDrawer = () => {
            if (drawerMenu && drawerOverlay) {
                drawerMenu.classList.remove('active');
                drawerOverlay.classList.remove('active');
                document.body.style.overflow = '';
            }
        };

        if (drawerCloseBtn) drawerCloseBtn.addEventListener('click', closeDrawer);
        if (drawerOverlay) drawerOverlay.addEventListener('click', closeDrawer);

        // Handle mobile menu clicks for anchor navigation to close drawer
        const drawerItems = document.querySelectorAll('.drawer-item');
        drawerItems.forEach(item => {
            item.addEventListener('click', () => {
                closeDrawer();
            });
        });

        // Search Bar Toggle
        const searchToggleBtn = document.getElementById('search-toggle-btn');
        const searchCloseBtn = document.getElementById('search-close-btn');
        const searchOverlayBar = document.getElementById('search-overlay-bar');

        if (searchToggleBtn && searchOverlayBar) {
            searchToggleBtn.addEventListener('click', () => {
                searchOverlayBar.classList.add('active');
                const searchInput = searchOverlayBar.querySelector('.search-input');
                if (searchInput) searchInput.focus();
            });
        }

        if (searchCloseBtn && searchOverlayBar) {
            searchCloseBtn.addEventListener('click', () => {
                searchOverlayBar.classList.remove('active');
            });
        }

        // Highlight active link depending on current section
        const navItems = document.querySelectorAll('.nav-item');
        const currentPath = window.location.pathname.split('/').pop() || 'index.php';

        navItems.forEach(item => {
            const href = item.getAttribute('href');
            if (href === currentPath) {
                navItems.forEach(nav => nav.classList.remove('active'));
                item.classList.add('active');
            }
        });

        // Smooth scroll to sections and highlight
        const handleAnchorLink = (e, items) => {
            const href = e.currentTarget.getAttribute('href');
            if (href.includes('#')) {
                const targetId = href.split('#')[1];
                const targetElement = document.getElementById(targetId);
                const isCurrentPage = window.location.pathname.endsWith('index.php') || window.location.pathname === '/' || window.location.pathname === '' || !window.location.pathname.includes('.php');
                if (targetElement && isCurrentPage) {
                    e.preventDefault();
                    targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    items.forEach(nav => nav.classList.remove('active'));
                    e.currentTarget.classList.add('active');
                }
            }
        };

        navItems.forEach(item => {
            item.addEventListener('click', (e) => handleAnchorLink(e, navItems));
        });

        drawerItems.forEach(item => {
            item.addEventListener('click', (e) => handleAnchorLink(e, drawerItems));
        });

        // Redirect/Scroll "Book a Taxi" dark button to the booking form
        const bookBtn = document.querySelector('.book-btn');
        if (bookBtn) {
            bookBtn.addEventListener('click', function(e) {
                const bookingSection = document.querySelector('.booking-card');
                if (bookingSection) {
                    e.preventDefault();
                    bookingSection.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    const firstInput = document.getElementById('pickup_address');
                    if (firstInput) {
                        setTimeout(() => firstInput.focus(), 800);
                    }
                }
            });
        }
    });
</script>

