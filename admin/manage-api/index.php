<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch current settings from site_settings table
$stmt = $pdo->query("SELECT setting_key, setting_value FROM site_settings");
$settingsRows = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

$onesignal_app_id = $settingsRows['onesignal_app_id'] ?? '';
$onesignal_rest_api_key = $settingsRows['onesignal_rest_api_key'] ?? '';
?>

<div class="container-fluid py-4">
    <div class="row">
        <!-- Configuration Form -->
        <div class="col-xl-6 col-lg-7 mb-4">
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark"><i class="fas fa-bell me-2 text-primary"></i> OneSignal Notification Channels</h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-info border-0 shadow-sm small mb-4">
                        <i class="fas fa-info-circle me-2"></i> Configure separate Android Notification Channels (Categories) for different notification types.
                        On Android 8+, these channels allow users to customize alerts (sound, importance) for each category.
                    </div>
                    
                    <form id="onesignalConfigForm">
                        <input type="hidden" name="action" value="save_settings">
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="font-weight-bold text-dark mb-2 small">OneSignal App ID</label>
                                <input type="text" name="onesignal_app_id" class="form-control" value="<?= htmlspecialchars($onesignal_app_id) ?>" placeholder="e.g. 8af20809-..." required>
                            </div>
                            <div class="col-md-6">
                                <label class="font-weight-bold text-dark mb-2 small">REST API Key</label>
                                <div class="input-group">
                                    <input type="password" name="onesignal_rest_api_key" id="rest_api_key" class="form-control" value="<?= htmlspecialchars($onesignal_rest_api_key) ?>" placeholder="os_v2_app_..." required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword"><i class="fas fa-eye"></i></button>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4">
                        <h6 class="mb-3 font-weight-bold"><i class="fas fa-th-list me-2 text-warning"></i> Channel (Box) Configuration</h6>

                        <div class="form-group mb-3">
                            <label class="small font-weight-bold text-dark">Box-1: New Booking Channel ID</label>
                            <input type="text" name="onesignal_new_booking_channel" class="form-control" value="<?= htmlspecialchars($settingsRows['onesignal_new_booking_channel'] ?? '') ?>" placeholder="Android Category ID for New Bookings">
                        </div>

                        <div class="form-group mb-3">
                            <label class="small font-weight-bold text-dark">Box-2: Chat Message Channel ID</label>
                            <input type="text" name="onesignal_chat_channel" class="form-control" value="<?= htmlspecialchars($settingsRows['onesignal_chat_channel'] ?? '') ?>" placeholder="Android Category ID for Chats">
                        </div>

                        <div class="form-group mb-3">
                            <label class="small font-weight-bold text-dark">Box-3: Commission Request Channel ID</label>
                            <input type="text" name="onesignal_commission_channel" class="form-control" value="<?= htmlspecialchars($settingsRows['onesignal_commission_channel'] ?? '') ?>" placeholder="Android Category ID for Commission">
                        </div>

                        <div class="form-group mb-3">
                            <label class="small font-weight-bold text-dark">Box-4: Booking Accept Channel ID</label>
                            <input type="text" name="onesignal_accept_channel" class="form-control" value="<?= htmlspecialchars($settingsRows['onesignal_accept_channel'] ?? '') ?>" placeholder="Android Category ID for Booking Accept">
                        </div>

                        <div class="form-group mb-3">
                            <label class="small font-weight-bold text-dark">Box-5: Booking Cancel Channel ID</label>
                            <input type="text" name="onesignal_cancel_channel" class="form-control" value="<?= htmlspecialchars($settingsRows['onesignal_cancel_channel'] ?? '') ?>" placeholder="Android Category ID for Cancel">
                        </div>

                        <div class="form-group mb-4">
                            <label class="small font-weight-bold text-dark">Box-6: Trip Status Channel ID</label>
                            <input type="text" name="onesignal_trip_status_channel" class="form-control" value="<?= htmlspecialchars($settingsRows['onesignal_trip_status_channel'] ?? '') ?>" placeholder="Android Category ID for Trip Start/Complete">
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary shadow-sm rounded-pill py-2">
                                <i class="fas fa-save me-2"></i> Save All Channels & Settings
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Testing & Status -->
        <div class="col-xl-6 col-lg-5">
            <!-- Test Notification Card -->
            <div class="card shadow border-0 mb-4 bg-gradient-light">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 font-weight-bold text-success"><i class="fas fa-paper-plane me-2"></i> Test Channels (Boxes)</h6>
                </div>
                <div class="card-body">
                    <p class="text-muted mb-4 small">Select a box/channel to send a test push notification to all users.</p>
                    
                    <div class="form-group mb-3">
                        <label class="small font-weight-bold">Select Channel to Test</label>
                        <select id="test_box" class="form-control">
                            <option value="1">Box-1: New Booking</option>
                            <option value="2">Box-2: Chat Message</option>
                            <option value="3">Box-3: Commission Request</option>
                            <option value="4">Box-4: Booking Accept</option>
                            <option value="5">Box-5: Booking Cancel</option>
                            <option value="6">Box-6: Trip Status</option>
                        </select>
                    </div>

                    <div class="form-group mb-3 text-start">
                        <input type="text" id="test_title" class="form-control mb-2" placeholder="Test Title" value="Channel Test">
                        <textarea id="test_message" class="form-control" rows="3" placeholder="Test Message">This is a test notification for the selected channel.</textarea>
                    </div>

                    <div class="d-grid">
                        <button id="sendTestBtn" class="btn btn-success shadow-sm rounded-pill py-2">
                            <i class="fas fa-bolt me-1"></i> Send Channel Test Push
                        </button>
                    </div>
                </div>
            </div>

            <!-- Helpful Links -->
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 font-weight-bold text-dark">OneSignal Dashboard Links</h6>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush small">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            How to create Channels?
                            <a href="https://documentation.onesignal.com/docs/android-notification-categories" target="_blank" class="btn btn-xs btn-link text-primary"><i class="fas fa-external-link-alt"></i></a>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            OneSignal Dashboard
                            <a href="https://dashboard.onesignal.com/" target="_blank" class="btn btn-xs btn-link text-primary"><i class="fas fa-external-link-alt"></i></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Password toggle
    $('#togglePassword').on('click', function() {
        const input = $('#rest_api_key');
        const icon = $(this).find('i');
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            icon.removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            icon.removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });

    // 1. Save Settings
    $('#onesignalConfigForm').on('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        $.ajax({
            url: 'api/onesignal_actions.php',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            beforeSend: function() {
                $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i> Saving...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire({ icon: 'success', title: 'Saved!', text: res.message, timer: 1500, showConfirmButton: false });
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            error: function() {
                Swal.fire('Error', 'Failed to communicate with server', 'error');
            },
            complete: function() {
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-save me-2"></i> Save Notification Settings');
            }
        });
    });

    // 2. Send Test Notification
    $('#sendTestBtn').on('click', function() {
        const box = $('#test_box').val();
        const title = $('#test_title').val();
        const message = $('#test_message').val();

        if (!title || !message) {
            Swal.fire('Required', 'Please enter both title and message', 'warning');
            return;
        }

        $.ajax({
            url: 'api/onesignal_actions.php',
            type: 'POST',
            data: { 
                action: 'send_test',
                box: box,
                title: title,
                message: message
            },
            beforeSend: function() {
                $('#sendTestBtn').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Sending...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire('Sent!', 'Test notification sent to Channel (Box ' + box + '). Status: ' + (res.response.id ? 'Success' : 'Pending'), 'success');
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            error: function() {
                Swal.fire('Error', 'Failed to send test notification', 'error');
            },
            complete: function() {
                $('#sendTestBtn').prop('disabled', false).html('<i class="fas fa-bolt me-1"></i> Send Channel Test Push');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
