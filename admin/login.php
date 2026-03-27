<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Choose A Taxi</title>
    <!-- Font Awesome for icons -->
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
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }

        .login-card {
            background: #fff;
            width: 100%;
            max-width: 400px;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .logo {
            width: 150px;
            margin-bottom: 20px;
        }

        h2 {
            font-weight: 800;
            margin-bottom: 10px;
            color: var(--dark-blue);
        }

        p {
            color: var(--text-muted);
            margin-bottom: 30px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--dark-blue);
            margin-bottom: 5px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            color: var(--text-muted);
        }

        .input-wrapper input {
            width: 100%;
            padding: 12px 12px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
            font-family: inherit;
            transition: border-color 0.3s;
        }

        .input-wrapper input:focus {
            border-color: var(--primary-green);
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background: var(--primary-green);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.3s;
        }

        .login-btn:hover {
            background: #008f36;
        }

        .forgot-pw {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            color: var(--primary-green);
            text-decoration: none;
        }

        #message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 8px;
            font-size: 14px;
            display: none;
        }

        .error {
            background: #fee2e2;
            color: #b91c1c;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <img src="../assets/logo.png" alt="Logo" class="logo">
        <h2>Admin Login</h2>
        <p>Access our secure admin panel</p>

        <form id="loginForm">
            <div class="form-group">
                <label>Email Address</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="admin@chooseataxi.com" required>
                </div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <button type="submit" class="login-btn">LOGIN NOW</button>
            <a href="#" class="forgot-pw">Forgot your password?</a>
        </form>

        <div id="message"></div>
    </div>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            const msg = document.getElementById('message');
            msg.className = 'error';
            msg.innerHTML = decodeURIComponent(urlParams.get('error'));
            msg.style.display = 'block';
        }

        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const btn = document.querySelector('.login-btn');
            const msg = document.getElementById('message');
            
            btn.disabled = true;
            btn.innerHTML = 'Verifying...';
            msg.style.display = 'none';

            const formData = new FormData(this);

            fetch('api/login_action.php', {
                method: 'POST',
                body: formData
            })
            .then(res => res.json())
            .then(data => {
                if(data.success) {
                    msg.className = 'success';
                    msg.innerHTML = 'Login successful! Redirecting...';
                    msg.style.display = 'block';
                    setTimeout(() => {
                        window.location.href = 'dashboard.php';
                    }, 1500);
                } else {
                    msg.className = 'error';
                    msg.innerHTML = data.message;
                    msg.style.display = 'block';
                    btn.disabled = false;
                    btn.innerHTML = 'LOGIN NOW';
                }
            })
            .catch(err => {
                msg.className = 'error';
                msg.innerHTML = 'An error occurred. Please try again.';
                msg.style.display = 'block';
                btn.disabled = false;
                btn.innerHTML = 'LOGIN NOW';
            });
        });
    </script>
</body>
</html>
