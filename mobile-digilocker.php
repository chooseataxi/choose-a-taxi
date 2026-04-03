<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Instant Verification</title>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Surepass Digiboost SDK -->
    <script src="https://cdn.jsdelivr.net/gh/surepassio/surepass-digiboost-web-sdk@latest/index.min.js"></script>
    <style>
        body { 
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; 
            background: #f8f9fa; 
            padding: 20px; 
            margin: 0;
            color: #333;
        }
        .header { text-align: center; margin-bottom: 20px; }
        .header h3 { font-size: 22px; margin: 10px 0; color: #111; }
        .header p { font-size: 14px; color: #666; margin: 0; }
        .success-box { text-align: center; margin-top: 40px; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .success-box svg { color: #00a63f; width: 70px; margin-bottom: 15px; }
        .success-box h2 { margin: 0 0 10px; color: #111; font-size: 20px; }
        .success-box p { color: #666; font-size: 15px; }
        #sdk-container { padding: 10px; background: #fff; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
    </style>
</head>
<body>
    <div id="digilocker-wrap">
        <div class="header">
            <h3>Identity Verification</h3>
            <p>Connect your Aadhaar using DigiLocker to instantly approve your partner profile.</p>
        </div>
        
        <div id="sdk-container">
            <div style="text-align:center; padding:30px;">
                <p>Loading Secure Gateway...</p>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            const urlParams = new URLSearchParams(window.location.search);
            const partnerId = urlParams.get('partner_id');

            if (!partnerId) {
                Swal.fire('Error', 'Invalid Mobile Session. Partner ID missing.', 'error');
                return;
            }

            // 1. Fetch Surepass SDK dynamic tokens explicitly from backend
            $.get('api/partner_actions.php', { action: 'initialize_digiboost' }, (res) => {
                if (res.success) {
                    $('#sdk-container').empty();
                    
                    // 2. Hydrate the Javascript Web Toolkit visually matching App Styles
                    window.DigiboostSdk({
                        gateway: "production",
                        token: res.data.token,
                        selector: "#sdk-container",
                        style: {
                            width: "100%",
                            backgroundColor: "#00a63f",
                            color: "white",
                            borderRadius: "10px",
                            padding: "16px",
                            fontWeight: "bold",
                            border: "none",
                            fontSize: "17px"
                        },
                        onSuccess: function(data) {
                            Swal.fire({ title: 'Securing Profile...', allowOutsideClick: false, didOpen: () => { Swal.showLoading(); }});
                            
                            // 3. Immediately relay success natively dropping right into the App's API
                            $.post('app/api/partner_auth.php', { action: 'digilocker_verify', partner_id: partnerId }, (approveRes) => {
                                Swal.close();
                                if(approveRes.success) {
                                    $('#digilocker-wrap').html(`
                                        <div class="success-box">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                                                <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12zm13.36-1.814a.75.75 0 10-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 00-1.06 1.06l2.25 2.25a.75.75 0 001.14-.094l3.75-5.25z" clip-rule="evenodd" />
                                            </svg>
                                            <h2>Verification Complete!</h2>
                                            <p style="margin-bottom: 20px;">Your Aadhaar identity has been flawlessly approved by the Government gateway.</p>
                                            <p style="font-weight:bold; color:#00a63f;">Please close this browser window at the top to return to the app.</p>
                                        </div>
                                    `);
                                } else {
                                    Swal.fire('API Lock', approveRes.message || 'Auto-approval sync failed', 'error');
                                }
                            }).fail(function() {
                                 Swal.close();
                                 Swal.fire('Network Issue', 'Failed to hit the approval database securely.', 'error');
                            });
                        },
                        onFailure: function(err) {
                            // Driver backed out of Aadhaar verification voluntarily
                        }
                    });
                } else {
                    $('#sdk-container').html('<p style="color:red; text-align:center;">Failed to initialize Govt API. Reload.</p>');
                }
            }).fail(function() {
                $('#sdk-container').html('<p style="color:red; text-align:center;">Server error contacting Digilocker.</p>');
            });
        });
    </script>
</body>
</html>
