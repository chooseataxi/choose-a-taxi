<?php
require_once __DIR__ . '/auth_check.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Choose A Taxi</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-green: #00a63f;
            --dark-blue: #050b18;
            --text-main: #1a1a1a;
            --text-muted: #666;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f7faff;
            margin: 0;
            display: flex;
        }

        .sidebar {
            width: 250px;
            background: var(--dark-blue);
            color: #fff;
            min-height: 100vh;
            padding: 20px;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #ddd;
        }

        .logout-btn {
            color: #ff4d4d;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h3>Admin Panel</h3>
        <p>Choose A Taxi</p>
        <hr>
        <!-- Add more sidebar links here -->
    </div>

    <div class="main-content">
        <div class="header">
            <h2>Welcome, <?php echo htmlspecialchars($adminData['name']); ?>!</h2>
            <div class="user-profile">
                <span><?php echo htmlspecialchars($adminData['email']); ?></span>
                <a href="logout.php" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <div class="card">
            <p>This is your protected admin dashboard.</p>
        </div>
    </div>
</body>
</html>
