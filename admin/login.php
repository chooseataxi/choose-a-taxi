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
            --input-bg: #f3f6f9;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: #fff;
            overflow: hidden;
        }

        .login-wrapper {
            display: flex;
            height: 100vh;
            width: 100vw;
        }

        /* Left side: Lottie Animation */
        .login-visual {
            flex: 1.5;
            background: linear-gradient(135deg, var(--dark-blue) 0%, #0a1324 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .login-visual::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 166, 63, 0.05) 0%, transparent 70%);
            top: -50%;
            left: -50%;
        }

        .lottie-container {
            width: 80%;
            max-width: 600px;
            z-index: 1;
        }

        /* Right side: Login Form */
        .login-form-side {
            flex: 1;
            background: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 0 80px;
            position: relative;
            box-shadow: -10px 0 50px rgba(0, 0, 0, 0.05);
        }

        .login-header {
            margin-bottom: 40px;
        }

        .logo {
            width: 180px;
            margin-bottom: 30px;
        }

        .login-header h1 {
            font-size: 36px;
            font-weight: 800;
            color: var(--dark-blue);
            margin-bottom: 10px;
        }

        .login-header p {
            color: var(--text-muted);
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--dark-blue);
            margin-bottom: 10px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i.field-icon {
            position: absolute;
            left: 20px;
            color: #a0aec0;
            font-size: 18px;
            transition: color 0.3s;
        }

        .input-wrapper input {
            width: 100%;
            padding: 16px 50px 16px 55px;
            background: var(--input-bg);
            border: 2px solid transparent;
            border-radius: 12px;
            font-size: 15px;
            font-family: inherit;
            color: var(--text-main);
            transition: all 0.3s ease;
        }

        .input-wrapper input:focus {
            background: #fff;
            border-color: var(--primary-green);
            box-shadow: 0 0 0 4px rgba(0, 166, 63, 0.05);
            outline: none;
        }

        .input-wrapper input:focus + i.field-icon {
            color: var(--primary-green);
        }

        .toggle-password {
            position: absolute;
            right: 20px;
            color: #a0aec0;
            cursor: pointer;
            font-size: 18px;
            transition: color 0.3s;
        }

        .toggle-password:hover {
            color: var(--primary-green);
        }

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .forgot-pass {
            color: var(--primary-green);
            text-decoration: none;
            font-weight: 600;
        }

        .login-btn {
            width: 100%;
            padding: 18px;
            background: var(--primary-green);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 800;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(0, 166, 63, 0.3);
        }

        .login-btn:hover {
            background: #008f36;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 166, 63, 0.4);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .login-btn:disabled {
            background: #a0aec0;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        #message {
            margin-top: 20px;
            padding: 15px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            display: none;
            text-align: center;
        }

        .error {
            background: #fff5f5;
            color: #c53030;
            border: 1px solid #feb2b2;
        }

        .success {
            background: #f0fff4;
            color: #2f855a;
            border: 1px solid #9ae6b4;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .login-form-side {
                padding: 0 40px;
            }
        }

        @media (max-width: 991px) {
            body {
                overflow: auto;
            }
            .login-wrapper {
                flex-direction: column;
                height: auto;
            }
            .login-visual {
                height: 40vh;
                flex: none;
            }
            .login-form-side {
                flex: none;
                padding: 60px 40px;
                box-shadow: none;
            }
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <!-- Visual Side -->
        <div class="login-visual">
            <div class="lottie-container">
                <lottie-player src="../assets/lottie/Car driving on road.json" background="transparent" speed="1" style="width: 100%; height: 100%;" loop autoplay></lottie-player>
            </div>
        </div>

        <!-- Form Side -->
        <div class="login-form-side">
            <div class="login-header">
                <img src="../assets/logo.png" alt="Logo" class="logo">
                <h1>Welcome Back</h1>
                <p>Please enter your details to access admin panel.</p>
            </div>

            <form id="loginForm">
                <div class="form-group">
                    <label>Email Address</label>
                    <div class="input-wrapper">
                        <i class="fas fa-envelope field-icon"></i>
                        <input type="email" name="email" placeholder="name@company.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock field-icon"></i>
                        <input type="password" name="password" id="password" placeholder="••••••••" required>
                        <i class="fas fa-eye toggle-password" id="togglePassword"></i>
                    </div>
                </div>

                <div class="login-options">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" style="width: 16px; height: 16px; accent-color: var(--primary-green);"> Remember me
                    </label>
                    <a href="#" class="forgot-pass">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn">SIGN IN</button>
            </form>

            <div id="message"></div>
        </div>
    </div>

    <!-- Lottie Player Script -->
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    
    <script>
        // Password Visibility Toggle
        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#password');

        togglePassword.addEventListener('click', function () {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye-slash');
        });

        // Error message handling from URL
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            const msg = document.getElementById('message');
            msg.className = 'error';
            msg.innerHTML = decodeURIComponent(urlParams.get('error'));
            msg.style.display = 'block';
        }

        // Login AJAX Handling
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const btn = document.querySelector('.login-btn');
            const msg = document.getElementById('message');
            
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i> VERIFYING...';
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
                    msg.innerHTML = '<i class="fas fa-check-circle"></i> Login successful! Redirecting...';
                    msg.style.display = 'block';
                    setTimeout(() => {
                        window.location.href = 'index.php';
                    }, 1500);
                } else {
                    msg.className = 'error';
                    msg.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + data.message;
                    msg.style.display = 'block';
                    btn.disabled = false;
                    btn.innerHTML = 'SIGN IN';
                }
            })
            .catch(err => {
                msg.className = 'error';
                msg.innerHTML = '<i class="fas fa-exclamation-triangle"></i> An error occurred. Please try again.';
                msg.style.display = 'block';
                btn.disabled = false;
                btn.innerHTML = 'SIGN IN';
            });
        });
    </script>
</body>
</html>
