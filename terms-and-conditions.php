<?php 
$page_title = "Terms & Conditions | Choose A Taxi";
include 'includes/header.php'; 
?>

<!-- Custom Footer CSS -->
<link rel="stylesheet" href="assets/css/footer.css">

<style>
    .policy-hero {
        background: linear-gradient(135deg, #050b18 0%, #0d1e3d 100%);
        padding: 60px 20px;
        color: #ffffff;
        text-align: center;
        position: relative;
    }
    .policy-hero h1 {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 12px;
        color: #ffb703;
    }
    .policy-hero p {
        font-size: 1.1rem;
        color: #cfd6e4;
        max-width: 700px;
        margin: 0 auto;
    }
    .policy-meta {
        margin-top: 15px;
        font-size: 0.9rem;
        color: #94a3b8;
    }
    .policy-container {
        max-width: 960px;
        margin: -30px auto 60px auto;
        padding: 0 20px;
        position: relative;
        z-index: 10;
    }
    .policy-card {
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        padding: 40px;
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        color: #334155;
        line-height: 1.75;
    }
    .policy-section {
        margin-bottom: 35px;
        padding-bottom: 25px;
        border-bottom: 1px solid #f1f5f9;
    }
    .policy-section:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
    }
    .policy-section h2 {
        font-size: 1.4rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .policy-section h2 i {
        color: #00a63f;
        font-size: 1.25rem;
    }
    .policy-section p {
        margin-bottom: 14px;
        color: #475569;
    }
    .policy-section ul {
        margin-left: 20px;
        margin-bottom: 16px;
    }
    .policy-section li {
        margin-bottom: 8px;
        color: #475569;
    }
    .policy-highlight-box {
        background: #f0fdf4;
        border-left: 4px solid #00a63f;
        padding: 16px 20px;
        border-radius: 8px;
        margin: 20px 0;
    }
    .contact-box {
        background: #f8fafc;
        border-radius: 12px;
        padding: 24px;
        margin-top: 20px;
        border: 1px solid #e2e8f0;
    }
    @media (max-width: 768px) {
        .policy-card {
            padding: 24px 18px;
        }
        .policy-hero h1 {
            font-size: 1.9rem;
        }
    }
</style>

<div class="policy-hero">
    <h1>Terms & Conditions</h1>
    <p>Choose A Taxi & Choose A Taxi Partner</p>
    <div class="policy-meta">
        <span><i class="far fa-calendar-alt"></i> Effective Date: November 17, 2026</span>
    </div>
</div>

<div class="policy-container">
    <div class="policy-card">
        
        <div class="policy-section">
            <h2><i class="fas fa-file-contract"></i> 1. Agreement to Terms</h2>
            <p>
                These Terms and Conditions constitute a legally binding agreement between you ("Partner", "Driver", or "User") and <strong>Choose A Taxi</strong>. By accessing our website (<strong>https://chooseataxi.in</strong>) or using the <strong>Choose A Taxi Partner</strong> mobile application, you agree to be bound by these Terms.
            </p>
        </div>

        <div class="policy-section">
            <h2><i class="fas fa-id-card"></i> 2. Partner & Driver Eligibility</h2>
            <p>To register and operate as a Driver or Vehicle Partner on our platform, you confirm and warrant that:</p>
            <ul>
                <li>You are at least 18 years of age.</li>
                <li>You hold a valid Commercial Driving License issued by the appropriate licensing authority in India.</li>
                <li>All vehicle documents, including Registration Certificate (RC), Commercial Insurance, Pollution Under Control (PUC), and Tourist/Commercial Permits, are valid and current.</li>
                <li>You consent to automated identity verification via DigiLocker / Surepass government database checks.</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2><i class="fas fa-car"></i> 3. Booking Acceptance & Fulfillment Rules</h2>
            <ul>
                <li>Once a booking is accepted by a partner or driver, the vehicle and driver assigned must report to the passenger's pickup location on or before the scheduled time.</li>
                <li>Private (white-board) vehicles are strictly prohibited from operating commercial bookings on the platform. Accounts found using non-commercial vehicles will be suspended immediately.</li>
                <li>Drivers must maintain high standards of courtesy, passenger safety, vehicle cleanliness, and adherence to traffic rules.</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2><i class="fas fa-wallet"></i> 4. Payments, Wallets & Fees</h2>
            <ul>
                <li>Partner subscription fees and platform service fees are deducted from the partner's in-app wallet balance or paid via authorized payment methods (Razorpay).</li>
                <li>Withdrawal requests to registered bank accounts/UPI are processed within standard banking settlement hours, subject to minimum wallet balance requirements.</li>
            </ul>
        </div>

        <div class="policy-section">
            <h2><i class="fas fa-ban"></i> 5. Cancellation & Penalty Policy</h2>
            <p>
                To maintain dependability and passenger trust, cancellation of confirmed bookings is subject to standard service penalty fees as displayed within the Partner App penalty schedule. Willful cancellations without valid cause or failure to show up ("No-Show") may result in temporary or permanent suspension of partner privileges.
            </p>
        </div>

        <div class="policy-section">
            <h2><i class="fas fa-envelope"></i> 6. Contact & Grievances</h2>
            <div class="contact-box">
                <p><strong>Choose A Taxi (Choose A Taxi India)</strong></p>
                <p>Address: 40, Ashok Vihar Phase-3 Ext., Gurgaon - 122001, Haryana, India</p>
                <p>Phone: <a href="tel:8058602516" style="color: #00a63f; font-weight: 600;">+91 80586-02516</a></p>
                <p>Email: <a href="mailto:info@chooseataxi.in" style="color: #00a63f; font-weight: 600;">info@chooseataxi.in</a></p>
            </div>
        </div>

    </div>
</div>

<?php include 'includes/footer.php'; ?>
