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
    <!-- Surepass Digiboost SDK -->
    <script src="https://cdn.jsdelivr.net/gh/surepassio/surepass-digiboost-web-sdk@latest/index.min.js"></script>

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

        /* KYC Card Styles matching SDK Index */
        .kyc-info-card {
            background: #fff;
            border-radius: 15px;
            padding: 20px;
            border: 1px solid #e1e7ec;
            margin-bottom: 20px;
        }
        .kyc-icon-circle {
            width: 60px;
            height: 60px;
            background: #eef2ff;
            color: #4f46e5;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 24px;
        }
        .kyc-feature-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 12px;
            font-size: 14px;
            color: #4b5563;
        }
        .kyc-feature-item i {
            color: var(--primary-color);
            width: 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
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
                            <div class="text-center mb-4">
                                <i class="fas fa-mobile-alt mb-3 text-primary" style="font-size: 40px;"></i>
                                <h4>Step 1: Mobile Verification</h4>
                            </div>
                            
                            <div id="mobile-input-section">
                                <div class="form-group mb-4">
                                    <label class="form-label fw-bold">Enter Mobile Number</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white">+91</span>
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
                                    <p class="mt-3 text-muted">Sent to <span id="display-mobile"></span></p>
                                </div>
                                <button class="btn btn-primary w-100 mb-3" id="verify-mobile-btn">Verify Mobile</button>
                                <div class="text-center">
                                    <button class="btn btn-link p-0 text-decoration-none" id="resend-otp" disabled>Resend OTP</button>
                                    <span id="resend-timer-text" class="text-muted d-block small mt-1">Wait 60s to resend</span>
                                </div>
                            </div>
                        </div>

                        <!-- Step 2: Digilocker eKYC -->
                        <div class="wizard-step" id="step2">
                            <div class="kyc-info-card text-center">
                                <div class="kyc-icon-circle">
                                    <i class="fas fa-shield-halved"></i>
                                </div>
                                <h4 class="fw-bold">Identity Verification</h4>
                                <p class="text-muted small mb-4">Securely access your documents through DigiLocker</p>
                                
                                <div class="text-start mb-4">
                                    <div class="kyc-feature-item">
                                        <i class="fas fa-check-circle"></i>
                                        <span><strong>Instant Access:</strong> Get immediate verification results</span>
                                    </div>
                                    <div class="kyc-feature-item">
                                        <i class="fas fa-landmark"></i>
                                        <span><strong>Secure & Trusted:</strong> Government-backed platform</span>
                                    </div>
                                    <div class="kyc-feature-item">
                                        <i class="fas fa-user-shield"></i>
                                        <span><strong>Data Privacy:</strong> Documents are encrypted and protected</span>
                                    </div>
                                </div>

                                <div class="bg-primary bg-opacity-10 p-3 rounded-3 mb-4">
                                    <p class="mb-0 text-primary small fw-semibold">Click the button below to connect with DigiLocker</p>
                                </div>

                                <div id="digilocker-sdk-button" class="mb-3">
                                    <div class="spinner-border text-primary" role="status" id="kyc-loader">
                                        <span class="visually-hidden">Loading SDK...</span>
                                    </div>
                                </div>

                                <p class="text-muted" style="font-size: 11px;">
                                    By proceeding, you will be redirected to the official DigiLocker portal to authorize access.
                                </p>
                            </div>
                        </div>

                        <!-- Step 3: Account Setup -->
                        <div class="wizard-step" id="step3">
                            <h4 class="mb-4">Step 3: Final Account Details</h4>
                            <form id="finalize-form">
                                <input type="hidden" name="action" value="finalize_registration">
                                <div class="form-group mb-3">
                                    <label class="form-label fw-bold">Full Name (Auto-fetched from Aadhaar)</label>
                                    <input type="text" name="name" id="kyc_fetched_name" class="form-control" readonly required>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label fw-bold">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="For alerts & bookings" required>
                                </div>
                                <div class="form-group mb-4">
                                    <label class="form-label fw-bold">Set Login Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Minimum 8 characters" required>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 mt-2">Complete My Registration</button>
                            </form>
                        </div>

                    </div>
                </div>

                <div class="text-center text-muted mb-5">
                    Already registered? <a href="#" class="text-primary fw-bold text-decoration-none">Login Here</a>
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

            // OTP Timer
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

            // STEP 1: MOBILE Verification
            $('#send-otp-btn').click(function() {
                const mobile = $('#mobile').val();
                if (mobile.length !== 10) {
                    Swal.fire('Error', 'Please enter a 10-digit mobile number', 'error');
                    return;
                }
                $(this).prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Sending...');
                
                $.post('api/partner_actions.php', { action: 'send_mobile_otp', mobile: mobile }, (res) => {
                    $(this).prop('disabled', false).text('Send OTP');
                    if (res.success) {
                        $('#display-mobile').text(mobile);
                        $('#mobile-input-section').hide();
                        $('#otp-verify-section').fadeIn();
                        startResendTimer();
                        Swal.fire('OTP Sent', 'A verification code has been sent.', 'success');
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            $('#verify-mobile-btn').click(function() {
                const otp = $('#otp1').val() + $('#otp2').val() + $('#otp3').val() + $('#otp4').val();
                $.post('api/partner_actions.php', { action: 'verify_mobile_otp', otp: otp }, (res) => {
                    if (res.success) {
                        initKycStep();
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });

            // STEP 2: DIGIBOOST KYC
            function initKycStep() {
                $('#step1-circle').addClass('completed').removeClass('active');
                $('#step2-circle').addClass('active');
                $('#step1').hide();
                $('#step2').fadeIn().addClass('active');

                // Initialize Digiboost SDK
                $.get('api/partner_actions.php', { action: 'initialize_digiboost' }, (res) => {
                    if (res.success) {
                        $('#kyc-loader').hide();
                        window.DigiboostSdk({
                            gateway: "production", // Or pulls from config
                            token: res.data.token,
                            selector: "#digilocker-sdk-button",
                            style: {
                                width: "100%",
                                backgroundColor: "#00a63f",
                                color: "white",
                                borderRadius: "10px",
                                padding: "12px",
                                fontWeight: "600",
                                border: "none"
                            },
                            onSuccess: function(data) {
                                Swal.fire({
                                    title: 'Verifying Status...',
                                    allowOutsideClick: false,
                                    didOpen: () => { Swal.showLoading(); }
                                });
                                // Notify server of success
                                $.post('api/partner_actions.php', { action: 'finalize_kyc', client_id: res.data.client_id }, (kycRes) => {
                                    Swal.close();
                                    if (kycRes.success) {
                                        $('#kyc_fetched_name').val(kycRes.full_name || '');
                                        moveStep3();
                                    } else {
                                        Swal.fire('Error', kycRes.message, 'error');
                                    }
                                });
                            },
                            onFailure: function(err) {
                                Swal.fire('Verification Cancelled', 'Please complete the DigiLocker verification to proceed.', 'warning');
                            }
                        });
                    } else {
                        Swal.fire('SDK Error', res.message, 'error');
                    }
                });
            }

            function moveStep3() {
                $('#step2-circle').addClass('completed').removeClass('active');
                $('#step3-circle').addClass('active');
                $('#step2').hide();
                $('#step3').fadeIn().addClass('active');
                Swal.fire('Identity Verified!', 'Finalize your account details to finish.', 'success');
            }

            // STEP 3: FINALIZE
            $('#finalize-form').submit(function(e) {
                e.preventDefault();
                $.post('api/partner_actions.php', $(this).serialize(), (res) => {
                    if (res.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Your registration is complete. Welcome to Choose A Taxi!',
                            confirmButtonText: 'Go to Login'
                        }).then(() => { window.location.href = 'partner-login.php'; });
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            });
        });
    </script>

</body>
</html>
