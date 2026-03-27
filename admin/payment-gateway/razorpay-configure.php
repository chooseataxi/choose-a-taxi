<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Fetch current settings
$stmt = $pdo->query("SELECT setting_key, setting_value FROM payment_settings");
$settingsRows = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

$razorpay_key_id = $settingsRows['razorpay_key_id'] ?? '';
$razorpay_key_secret = $settingsRows['razorpay_key_secret'] ?? '';
$razorpay_mode = $settingsRows['razorpay_mode'] ?? 'test';
$razorpay_status = $settingsRows['razorpay_status'] ?? 'Inactive';
?>

<div class="container-fluid py-4">
    <div class="row">
        <!-- Configuration Form -->
        <div class="col-xl-6 col-lg-7 mb-4">
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex align-items-center">
                    <h5 class="mb-0 font-weight-bold text-dark"><i class="fas fa-credit-card me-2 text-primary"></i> Razorpay Professional Configuration</h5>
                </div>
                <div class="card-body">
                    <form id="razorpayConfigForm">
                        <input type="hidden" name="action" value="save_settings">
                        
                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Key ID</label>
                            <input type="text" name="key_id" class="form-control" value="<?= htmlspecialchars($razorpay_key_id) ?>" placeholder="rzp_test_..." required>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="font-weight-bold text-dark mb-2">Key Secret</label>
                            <input type="password" name="key_secret" class="form-control" value="<?= htmlspecialchars($razorpay_key_secret) ?>" placeholder="Your Key Secret" required>
                        </div>

                        <div class="row mb-4">
                            <div class="col-6">
                                <label class="font-weight-bold text-dark mb-2">Environment Mode</label>
                                <select name="mode" class="form-select">
                                    <option value="test" <?= $razorpay_mode === 'test' ? 'selected' : '' ?>>Test (Sandbox)</option>
                                    <option value="live" <?= $razorpay_mode === 'live' ? 'selected' : '' ?>>Live (Production)</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="font-weight-bold text-dark mb-2">System Status</label>
                                <select name="status" class="form-select">
                                    <option value="Active" <?= $razorpay_status === 'Active' ? 'selected' : '' ?>>Active</option>
                                    <option value="Inactive" <?= $razorpay_status === 'Inactive' ? 'selected' : '' ?>>Inactive</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-grid mt-5">
                            <button type="submit" class="btn btn-primary shadow-sm rounded-pill py-2">
                                <i class="fas fa-save me-2"></i> Save Razorpay Configuration
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Live Test Utility -->
        <div class="col-xl-6 col-lg-5">
            <!-- Test Transaction Card -->
            <div class="card shadow border-0 mb-4 bg-gradient-light">
                <div class="card-header bg-white py-3">
                    <h6 class="mb-0 font-weight-bold text-success"><i class="fas fa-vial me-2"></i> Real-time Connection Test</h6>
                </div>
                <div class="card-body text-center py-5">
                    <div class="mb-4">
                        <i class="fas fa-shield-alt fa-3x text-success opacity-75"></i>
                    </div>
                    <h5>Live Test Payment</h5>
                    <p class="text-muted mb-4 small">Trigger a 1.00 INR transaction to verify your API credentials and order creation logic.</p>
                    <button id="testPaymentBtn" class="btn btn-yellow-black px-5 shadow-sm rounded-pill">
                        <i class="fas fa-bolt me-1"></i> Make Test Transaction
                    </button>
                </div>
            </div>

            <!-- Recent Logs -->
            <div class="card shadow border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h6 class="mb-0 font-weight-bold text-dark">Recent Test Logs</h6>
                    <button class="btn btn-sm btn-outline-secondary refresh-logs"><i class="fas fa-redo fa-sm"></i></button>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 font-small" style="font-size: 0.85rem;">
                            <thead class="bg-light">
                                <tr>
                                    <th>Ref ID</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody id="logs-container">
                                <tr><td colspan="4" class="text-center py-3">Loading logs...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Razorpay Checkout SDK -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
$(document).ready(function() {
    // 1. Save Settings
    $('#razorpayConfigForm').on('submit', function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        $.ajax({
            url: 'api/payment_actions.php',
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
            complete: function() {
                $('button[type="submit"]').prop('disabled', false).html('<i class="fas fa-save me-2"></i> Save Razorpay Configuration');
            }
        });
    });

    // 2. Make Test Transaction
    $('#testPaymentBtn').on('click', function() {
        $.ajax({
            url: 'api/payment_actions.php',
            type: 'GET',
            data: { action: 'create_test_order' },
            beforeSend: function() {
                $('#testPaymentBtn').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Preparing Order...');
            },
            success: function(res) {
                if (res.success) {
                    const options = {
                        key: res.key,
                        amount: res.amount,
                        currency: "INR",
                        name: res.name,
                        description: res.description,
                        order_id: res.order_id,
                        handler: function (response) {
                            verifyPayment(response);
                        },
                        modal: {
                            ondismiss: function() {
                                $('#testPaymentBtn').prop('disabled', false).html('<i class="fas fa-bolt me-1"></i> Make Test Transaction');
                            }
                        }
                    };
                    const rzp = new Razorpay(options);
                    rzp.open();
                } else {
                    Swal.fire('Error', res.message, 'error');
                    $('#testPaymentBtn').prop('disabled', false).html('<i class="fas fa-bolt me-1"></i> Make Test Transaction');
                }
            }
        });
    });

    function verifyPayment(response) {
        $.ajax({
            url: 'api/payment_actions.php',
            type: 'POST',
            data: {
                action: 'verify_test_payment',
                razorpay_order_id: response.razorpay_order_id,
                razorpay_payment_id: response.razorpay_payment_id,
                razorpay_signature: response.razorpay_signature
            },
            success: function(res) {
                if (res.success) {
                    Swal.fire('Test Successful!', 'The transaction was completed and verified live.', 'success');
                } else {
                    Swal.fire('Verification Failed', res.message, 'warning');
                }
                loadLogs();
                $('#testPaymentBtn').prop('disabled', false).html('<i class="fas fa-bolt me-1"></i> Make Test Transaction');
            }
        });
    }

    // 3. Load Logs
    function loadLogs() {
        $.ajax({
            url: 'api/payment_actions.php',
            type: 'GET',
            data: { action: 'get_logs' },
            success: function(res) {
                if (res.success) {
                    let html = '';
                    res.data.forEach(log => {
                        const date = new Date(log.created_at).toLocaleString();
                        const statusClass = log.status === 'Success' ? 'text-success' : (log.status === 'Failed' ? 'text-danger' : 'text-warning');
                        html += `<tr>
                            <td><small class="text-muted">${log.razorpay_order_id}</small></td>
                            <td>₹${log.amount}</td>
                            <td class="${statusClass} font-weight-bold">${log.status}</td>
                            <td><small>${date}</small></td>
                        </tr>`;
                    });
                    if (res.data.length === 0) html = '<tr><td colspan="4" class="text-center py-3">No logs found.</td></tr>';
                    $('#logs-container').html(html);
                }
            }
        });
    }

    $('.refresh-logs').on('click', loadLogs);
    loadLogs();
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
