<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch current settings from site_settings table
$stmt = $pdo->query("SELECT setting_key, setting_value FROM site_settings");
$settingsRows = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

$onesignal_app_id = $settingsRows['onesignal_app_id'] ?? '';
$onesignal_rest_api_key = $settingsRows['onesignal_rest_api_key'] ?? '';
$onesignal_channel_id = $settingsRows['onesignal_channel_id'] ?? '';
?>

<div class="container-fluid py-4">
    <div class="row">
        <!-- Configuration Form -->
        <div class="col-xl-6 col-lg-7 mb-4">
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark"><i class="fas fa-bell me-2 text-primary"></i> OneSignal Notification Configuration</h5>
                </div>
                <div class="card-body">
                    <div class="alert alert-info border-0 shadow-sm small mb-4">
                        <i class="fas fa-info-circle me-2"></i> Configure your OneSignal settings here. 
                        <br><strong>Note:</strong> For custom sounds to work, the sound file (without extension) must be bundled inside the mobile app's assets.
                        On Android 8+, you must also create a <strong>Notification Channel</strong> in OneSignal dashboard and enter its ID below.
                    </div>
                    
                    <form id="onesignalConfigForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="save_settings">
                        
                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">OneSignal App ID</label>
                            <input type="text" name="onesignal_app_id" class="form-control" value="<?= htmlspecialchars($onesignal_app_id) ?>" placeholder="e.g. 8af20809-09e9-4ce1-..." required>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">REST API Key</label>
                            <div class="input-group">
                                <input type="password" name="onesignal_rest_api_key" id="rest_api_key" class="form-control" value="<?= htmlspecialchars($onesignal_rest_api_key) ?>" placeholder="os_v2_app_..." required>
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Android Channel ID</label>
                            <input type="text" name="onesignal_channel_id" class="form-control" value="<?= htmlspecialchars($onesignal_channel_id) ?>" placeholder="e.g. fcm_default_channel">
                            <small class="text-muted">Required for custom sounds on Android 8+. <strong>Leave empty</strong> if you haven't created a channel in OneSignal dashboard.</small>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Notification Sound Name</label>
                            <input type="text" name="notification_sound" class="form-control" value="<?= htmlspecialchars($settingsRows['notification_sound'] ?? 'chat_notification_sound') ?>" placeholder="e.g. chat_notification_sound">
                            <small class="text-muted">The name of the sound file bundled in the mobile app (without extension). Default is <code>chat_notification_sound</code>.</small>
                        </div>

                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Upload Sound File (.wav / .mp3)</label>
                            <input type="file" name="sound_file" class="form-control" accept=".wav,.mp3">
                            <small class="text-muted">
                                Upload for server-side reference. (Optional)
                                <?php if (!empty($settingsRows['notification_sound_file'])): ?>
                                    <br><span class="text-success"><i class="fas fa-check-circle"></i> Current file: <?= htmlspecialchars($settingsRows['notification_sound_file']) ?></span>
                                <?php endif; ?>
                            </small>
                        </div>

                        <div class="d-grid mt-5">
                            <button type="submit" class="btn btn-primary shadow-sm rounded-pill py-2">
                                <i class="fas fa-save me-2"></i> Save Notification Settings
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
                    <h6 class="mb-0 font-weight-bold text-success"><i class="fas fa-paper-plane me-2"></i> Send Test Notification</h6>
                </div>
                <div class="card-body text-center py-5">
                    <div class="mb-4">
                        <i class="fas fa-broadcast-tower fa-3x text-success opacity-75"></i>
                    </div>
                    <h5>Broadcast Test</h5>
                    <p class="text-muted mb-4 small">Send a test push notification to all subscribed users to verify your OneSignal configuration.</p>
                    
                    <div class="form-group mb-3 text-start">
                        <input type="text" id="test_title" class="form-control mb-2" placeholder="Test Title" value="ChooseATaxi Admin Test">
                        <input type="text" id="test_message" class="form-control" placeholder="Test Message" value="If you see this, OneSignal is working properly!">
                    </div>

                    <button id="sendTestBtn" class="btn btn-yellow-black px-5 shadow-sm rounded-pill">
                        <i class="fas fa-bolt me-1"></i> Send Test Push
                    </button>
                </div>
            </div>

            <!-- Helpful Links -->
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 font-weight-bold text-dark">Quick Documentation</h6>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush small">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            How to get App ID?
                            <a href="https://documentation.onesignal.com/docs/accounts-and-keys" target="_blank" class="btn btn-xs btn-link text-primary"><i class="fas fa-external-link-alt"></i></a>
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
                title: title,
                message: message
            },
            beforeSend: function() {
                $('#sendTestBtn').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Sending...');
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire('Sent!', 'Test notification request sent to OneSignal. Status: ' + (res.response.id ? 'Success' : 'Pending'), 'success');
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            },
            error: function() {
                Swal.fire('Error', 'Failed to send test notification', 'error');
            },
            complete: function() {
                $('#sendTestBtn').prop('disabled', false).html('<i class="fas fa-bolt me-1"></i> Send Test Push');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
