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

<header>
    <!-- Top Bar -->
    <div class="top-header">
        <div class="top-left">
            <span>Taxi Booking Platform for all over india!</span>
        </div>
        <div class="top-right">
            <span>Follow Us:</span>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </div>

    <!-- Main Navigation/Header -->
    <div class="main-navbar">
        <div class="logo-area">
            <a href="index.php">
                <img src="assets/logo.png" alt="Choose A Taxi Logo">
            </a>
            <span class="tagline">Make The Memorable Trip</span>
        </div>

        <!-- Contact Info - Hidden on smaller tablets/mobile -->
        <div class="contact-info">
            <div class="info-item">
                <div class="info-icon">
                    <i class="far fa-envelope"></i>
                </div>
                <div class="info-text">
                    <span>Email Adress:</span>
                    <strong>info@chooseataxi.in</strong>
                </div>
            </div>
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-phone-alt"></i>
                </div>
                <div class="info-text">
                    <span>Phone Number:</span>
                    <strong>8058602516</strong>
                </div>
            </div>
        </div>

        <!-- Actions -->
        <div class="header-actions">
            <a href="login.php" class="login-btn">
                <i class="fas fa-sign-in-alt"></i> LOGIN
            </a>
        </div>
        
        <!-- Mobile Menu Toggle -->
        <div class="mobile-toggle" id="mobile-menu-btn">
            <i class="fas fa-bars"></i>
        </div>
    </div>

    <!-- Mobile Menu Drawer -->
    <div class="overlay" id="overlay"></div>
    <div class="mobile-menu" id="mobile-menu">
        <div class="close-btn" id="close-menu-btn">
            <i class="fas fa-times"></i>
        </div>
        
        <div class="logo-area">
            <img src="assets/logo.png" alt="Logo">
        </div>

        <div class="info-item">
            <div class="info-icon"><i class="far fa-envelope"></i></div>
            <div class="info-text">
                <span>Email:</span>
                <strong>info@chooseataxi.in</strong>
            </div>
        </div>

        <div class="info-item">
            <div class="info-icon"><i class="fas fa-phone-alt"></i></div>
            <div class="info-text">
                <span>Phone:</span>
                <strong>8058602516</strong>
            </div>
        </div>

        <a href="login.php" class="login-btn" style="display: flex; margin-top: 20px;">
            <i class="fas fa-sign-in-alt"></i> LOGIN
        </a>
    </div>
</header>

<script>
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const closeMenuBtn = document.getElementById('close-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    const overlay = document.getElementById('overlay');

    mobileMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.add('active');
        overlay.classList.add('active');
    });

    closeMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.remove('active');
        overlay.classList.remove('active');
    });

    overlay.addEventListener('click', () => {
        mobileMenu.classList.remove('active');
        overlay.classList.remove('active');
    });
</script>
