<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Partner Registration | Choose A Taxi</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        :root {
            --primary-color: #00a63f;
            --secondary-color: #050b18;
            --accent-color: #ffc107;
            --bg-light: #f8f9fa;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--secondary-color);
        }

        .registration-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        .step-indicator {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }

        .step-indicator::before {
            content: '';
            position: absolute;
            top: 15px;
            left: 0;
            right: 0;
            height: 2px;
            background: #dee2e6;
            z-index: 1;
        }

        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid #dee2e6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .step.active {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: #fff;
            box-shadow: 0 0 10px rgba(0,166,63,0.3);
        }

        .step.completed {
            background: var(--accent-color);
            border-color: var(--accent-color);
            color: #fff;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            border-radius: 10px;
            padding: 12px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #008f36;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,166,63,0.3);
        }

        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ced4da;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(0,166,63,0.1);
            border-color: var(--primary-color);
        }

        .brand-logo {
            max-width: 180px;
            margin-bottom: 20px;
        }

        .hero-section {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #1a2a4a 100%);
            color: #fff;
            padding: 100px 0;
            text-align: center;
        }

        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 24px;
            margin: 0 5px;
            border-radius: 10px;
            border: 2px solid #dee2e6;
        }

        .wizard-step {
            display: none;
        }

        .wizard-step.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .registration-card {
                margin-top: 20px;
                border-radius: 15px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">
                
                <div class="text-center mt-5">
                    <img src="assets/logo.png" alt="Choose A Taxi" class="brand-logo">
                </div>

                <div class="card registration-card">
                    <div class="card-body p-4 p-md-5">
                        
                        <h2 class="text-center fw-bold mb-4">Partner Registration</h2>

                        <div class="step-indicator">
                            <div class="step active" id="step1-circle">1</div>
                            <div class="step" id="step2-circle">2</div>
                            <div class="step" id="step3-circle">3</div>
                        </div>

                        <!-- Step 1: Mobile OTP -->
                        <div class="wizard-step active" id="step1">
                            <h4 class="mb-4">Step 1: Mobile Verification</h4>
                            <div id="mobile-input-section">
                                <div class="form-group mb-4">
                                    <label class="form-label fw-bold">Enter Mobile Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text">+91</span>
                                        <input type="text" id="mobile" class="form-control" placeholder="10-digit mobile number">
                                    </div>
                                </div>
                                <button class="btn btn-primary w-100" id="send-otp-btn">Send OTP</button>
                            </div>

                            <div id="otp-verify-section" style="display:none;">
                                <div class="form-group mb-4 text-center">
                                    <label class="form-label fw-bold d-block mb-3">Enter Verification Code</label>
                                    <div class="d-flex justify-content-center">
                                        <input type="text" maxlength="1" class="otp-input" id="otp1">
                                        <input type="text" maxlength="1" class="otp-input" id="otp2">
                                        <input type="text" maxlength="1" class="otp-input" id="otp3">
                                        <input type="text" maxlength="1" class="otp-input" id="otp4">
                                    </div>
                                    <p class="mt-3 text-muted">A 4-digit code has been sent to <span id="display-mobile"></span></p>
                                </div>
                                <button class="btn btn-primary w-100 mb-3" id="verify-mobile-btn">Verify Mobile</button>
                                <div class="text-center mt-2">
                                    <button class="btn btn-link p-0 text-decoration-none" id="resend-otp" disabled>Resend OTP</button>
                                    <span id="resend-timer-text" class="text-muted d-block small mt-1">Wait 60s to resend</span>
                                </div>
                            </div>
                        </div>

                        <!-- Step 2: Aadhaar KYC -->
                        <div class="wizard-step" id="step2">
                            <h4 class="mb-4">Step 2: Aadhaar eKYC Verification</h4>
                            <div id="aadhaar-input-section">
                                <div class="form-group mb-4">
                                    <label class="form-label fw-bold font-weight-bold">Aadhaar Number</label>
                                    <input type="text" id="aadhaar_number" class="form-control" placeholder="Enter 12-digit Aadhaar number">
                                    <small class="text-muted"><i class="fas fa-shield-alt me-1"></i> Data is encrypted and secure with SurePass eKYC.</small>
                                </div>
                                <button class="btn btn-primary w-100" id="generate-aadhaar-otp-btn">Generate Aadhaar OTP</button>
                            </div>

                            <div id="aadhaar-verify-section" style="display:none;">
                                <div class="form-group mb-4 text-center">
                                    <label class="form-label fw-bold d-block mb-3">Enter Aadhaar OTP</label>
                                    <input type="text" id="aadhaar_otp" class="form-control text-center mx-auto" style="max-width: 200px; font-size: 24px; letter-spacing: 5px;" maxlength="6">
                                    <p class="mt-3 text-muted">OTP sent to the mobile paired with your Aadhaar.</p>
                                </div>
                                <button class="btn btn-primary w-100" id="submit-aadhaar-otp-btn">Verify eKYC</button>
                            </div>
                        </div>

                        <!-- Step 3: Account Setup -->
                        <div class="wizard-step" id="step3">
                            <h4 class="mb-4">Step 3: Final Account Details</h4>
                            <form id="finalize-form">
                                <input type="hidden" name="action" value="finalize_registration">
                                <div class="form-group mb-3">
                                    <label class="form-label fw-bold">Full Name (As per Aadhaar)</label>
                                    <input type="text" name="name" class="form-control" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label fw-bold">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="Verify booking alerts" required>
                                </div>
                                <div class="form-group mb-4">
                                    <label class="form-label fw-bold">Set Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Min. 8 characters" required>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 mt-2">Complete Registration</button>
                            </form>
                        </div>

                    </div>
                </div>

                <div class="text-center text-muted mb-5">
                    Already a partner? <a href="#" class="text-primary fw-bold text-decoration-none">Login Here</a>
                </div>

            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // OTP Auto-focus
            $('.otp-input').on('keyup', function() {
                if (this.value.length === this.maxLength) {
                    $(this).next('.otp-input').focus();
                }
            });

            // OTP Timer Logic
            let resendTimer;
            function startResendTimer() {
                let timeLeft = 60;
                $('#resend-otp').prop('disabled', true);
                $('#resend-timer-text').show();
                
                clearInterval(resendTimer);
                resendTimer = setInterval(function() {
                    timeLeft--;
                    $('#resend-timer-text').text('Wait ' + timeLeft + 's to resend');
                    if (timeLeft <= 0) {
                        clearInterval(resendTimer);
                        $('#resend-otp').prop('disabled', false);
                        $('#resend-timer-text').hide();
                    }
                }, 1000);
            }

            // STEP 1: Mobile Verification
            $('#send-otp-btn').click(function() {
                const mobile = $('#mobile').val();
                if (mobile.length !== 10) {
                    Swal.fire('Error', 'Please enter a valid 10-digit mobile number', 'error');
                    return;
                }

                $.post('api/partner_actions.php', { action: 'send_mobile_otp', mobile: mobile }, function(res) {
                    if (res.success) {
                        $('#display-mobile').text(mobile);
                        $('#mobile-input-section').hide();
                        $('#otp-verify-section').fadeIn();
                        startResendTimer();
                        Swal.fire('OTP Sent', 'A verification code has been sent to your mobile.', 'success');
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            $('#resend-otp').click(function() {
                const mobile = $('#mobile').val();
                $.post('api/partner_actions.php', { action: 'send_mobile_otp', mobile: mobile }, function(res) {
                    if (res.success) {
                        startResendTimer();
                        Swal.fire('OTP Resent', 'New verification code has been sent.', 'success');
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            $('#verify-mobile-btn').click(function() {
                const otp = $('#otp1').val() + $('#otp2').val() + $('#otp3').val() + $('#otp4').val();
                $.post('api/partner_actions.php', { action: 'verify_mobile_otp', otp: otp }, function(res) {
                    if (res.success) {
                        $('#step1-circle').addClass('completed').removeClass('active');
                        $('#step2-circle').addClass('active');
                        $('#step1').hide();
                        $('#step2').fadeIn().addClass('active');
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            // STEP 2: Aadhaar eKYC
            $('#generate-aadhaar-otp-btn').click(function() {
                const aadhaar = $('#aadhaar_number').val();
                if (aadhaar.length !== 12) {
                    Swal.fire('Error', 'Invalid Aadhaar Number', 'error');
                    return;
                }

                $.post('api/partner_actions.php', { action: 'generate_aadhaar_otp', aadhaar_number: aadhaar }, function(res) {
                    if (res.success) {
                        $('#aadhaar-input-section').hide();
                        $('#aadhaar-verify-section').fadeIn();
                        Swal.fire('OTP Sent', 'Aadhaar OTP has been sent through UIDAI.', 'success');
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            $('#submit-aadhaar-otp-btn').click(function() {
                const otp = $('#aadhaar_otp').val();
                $.post('api/partner_actions.php', { action: 'submit_aadhaar_otp', otp: otp }, function(res) {
                    if (res.success) {
                        $('#step2-circle').addClass('completed').removeClass('active');
                        $('#step3-circle').addClass('active');
                        $('#step2').hide();
                        $('#step3').fadeIn().addClass('active');
                        Swal.fire('Verified', 'Identity verified successfully!', 'success');
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            // STEP 3: Finalize
            $('#finalize-form').submit(function(e) {
                e.preventDefault();
                $.post('api/partner_actions.php', $(this).serialize(), function(res) {
                    if (res.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: res.message,
                            confirmButtonText: 'Login Now'
                        }).then(() => {
                            window.location.href = 'partner-login.php';
                        });
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });
        });
    </script>

</body>
</html>
