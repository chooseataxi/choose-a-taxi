<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | Choose A Taxi</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Lottie Player -->
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    
    <style>
        :root {
            --primary-color: #00a63f;
            --dark-color: #050b18;
        }
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f8f9fa;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .error-container {
            text-align: center;
            padding: 2rem;
            max-width: 600px;
            width: 100%;
        }
        lottie-player {
            margin: 0 auto;
            max-width: 400px;
        }
        .error-code {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-top: -20px;
            margin-bottom: 0.5rem;
        }
        .error-msg {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        .btn-home {
            background-color: var(--primary-color);
            color: white;
            padding: 12px 35px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 166, 63, 0.3);
            display: inline-block;
        }
        .btn-home:hover {
            background-color: #008f36;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 166, 63, 0.4);
        }
    </style>
</head>
<body>

    <?php
    // Determine the redirection link based on the context
    $requestUri = $_SERVER['REQUEST_URI'];
    $is_admin = strpos($requestUri, '/admin') !== false;
    $back_link = $is_admin ? '/admin/index.php' : '/index.php';
    $back_text = $is_admin ? 'Back to Dashboard' : 'Return to Home';
    ?>

    <div class="error-container animate__animated animate__fadeIn">
        <lottie-player 
            src="/assets/lottie/404 Error.json" 
            background="transparent" 
            speed="1" 
            style="width: 100%; height: 100%;" 
            loop 
            autoplay>
        </lottie-player>

        <h1 class="error-code">Oops! Page Not Found</h1>
        <p class="error-msg">The page you're looking for might have been moved, deleted, or never existed in the first place.</p>
        
        <a href="<?= $back_link ?>" class="btn-home">
            <?= $back_text ?>
        </a>
    </div>

</body>
</html>
