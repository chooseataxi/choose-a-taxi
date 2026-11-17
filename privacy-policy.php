<?php 
$page_title = "Privacy Policy | Choose A Taxi";
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
    .policy-highlight-box.warning {
        background: #fffbeb;
        border-left-color: #f59e0b;
    }
    .policy-highlight-box strong {
        color: #0f172a;
    }
    .contact-box {
        background: #f8fafc;
        border-radius: 12px;
        padding: 24px;
        margin-top: 20px;
        border: 1px solid #e2e8f0;
    }
    .contact-box p {
        margin-bottom: 8px;
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
    <h1>Privacy Policy</h1>
    <p>Choose A Taxi & Choose A Taxi Partner</p>
    <div class="policy-meta">
        <span><i class="far fa-calendar-alt"></i> Effective Date: November 17, 2026</span> | 
        <span><i class="fas fa-shield-alt"></i> Applicable App: Choose A Taxi Partner (in.chooseataxi.partner)</span>
    </div>
</div>

<div class="policy-container">
    <div class="policy-card">
        
        <!-- Introduction -->
        <div class="policy-section">
            <h2><i class="fas fa-info-circle"></i> 1. Introduction</h2>
            <p>
                Welcome to <strong>Choose A Taxi</strong> ("we", "our", "us"). We operate the Choose A Taxi platform, website (<strong>https://chooseataxi.in</strong>), and the <strong>Choose A Taxi Partner</strong> mobile application (Package ID: <code>in.chooseataxi.partner</code>).
            </p>
            <p>
                We are committed to safeguarding the privacy and personal data of our users, drivers, vehicle partners, and service providers. This Privacy Policy details the types of information we collect, why and how we use it, our data retention and deletion policies, and your privacy rights under applicable data protection laws.
            </p>
            <p>
                By registering, accessing, downloading, or using our mobile application or website, you consent to the collection, transfer, storage, and handling of your information as outlined in this policy.
            </p>
        </div>

        <!-- Foreground Service & Location Data Disclosure -->
        <div class="policy-section">
            <h2><i class="fas fa-map-marker-alt"></i> 2. Location Information & Foreground Services (Crucial Disclosure)</h2>
            <p>
                The primary purpose of the Choose A Taxi Partner app is to facilitate taxi dispatch, assign trips, calculate fares, and enable passenger safety and live journey tracking. To make this service functional and reliable, our application requires continuous and precise location information.
            </p>
            
            <div class="policy-highlight-box">
                <strong><i class="fas fa-satellite"></i> Background Location Disclosure:</strong><br>
                Choose A Taxi Partner collects and transmits real-time location data (including precise GPS coordinates, heading, and speed) <strong>even when the application is closed or running in the background</strong>, whenever a driver/partner is on an active trip, en route to a pickup location, or has switched their shift availability to "Active/Online".
            </div>

            <p><strong>Why is Location Data Collected in the Background?</strong></p>
            <ul>
                <li><strong>Live Passenger Tracking:</strong> Enables passengers to track their approaching driver and monitor route progress in real-time during an ongoing trip.</li>
                <li><strong>Driver & Passenger Safety:</strong> Allows our central dispatch and safety monitoring system to verify route compliance, detect unexpected stops, and offer emergency assistance.</li>
                <li><strong>Accurate Mileage & Fare Computation:</strong> Ensures fair, distance-based trip metering and compensation for drivers.</li>
                <li><strong>Nearby Job Matching:</strong> Suggests real-time ride requests based on your current physical geographic location.</li>
            </ul>

            <div class="policy-highlight-box warning">
                <strong><i class="fas fa-bell"></i> Foreground Service & Driver Control:</strong><br>
                While tracking is active, the app uses an Android <strong>Foreground Service</strong> that displays a continuous, prominent notification in your system status bar (e.g. <em>"Choose A Taxi: Live Trip Tracking Active"</em>). You retain total control: tracking can be stopped at any moment directly from the notification's "Stop Tracking" action or by marking the trip as completed or going offline.
            </div>
        </div>

        <!-- Personal & Vehicle Data Collected -->
        <div class="policy-section">
            <h2><i class="fas fa-user-check"></i> 3. Information We Collect</h2>
            <p>To provide our transport platform, verify compliance with government transport regulations, and process earnings, we collect the following categories of information:</p>
            <ul>
                <li><strong>Personal Identity Information:</strong> Full name, mobile phone number, email address, profile photograph, and date of birth.</li>
                <li><strong>Regulatory & Verification Documents:</strong> Driving License, Vehicle Registration Certificate (RC), Vehicle Permit, Fitness Certificate, and Identity Verification records (via DigiLocker / Surepass government verification SDK).</li>
                <li><strong>Vehicle Information:</strong> Vehicle make, model, year, fuel type, registration number, seating capacity, and vehicle exterior/interior photos.</li>
                <li><strong>Financial & Payment Information:</strong> Bank account numbers, Account holder name, IFSC code, and UPI ID for disbursing partner earnings and wallet withdrawals. Online wallet top-up transactions are processed via PCI-DSS compliant payment gateways (Razorpay). We do not store credit/debit card numbers or CVVs on our servers.</li>
                <li><strong>Device & Technical Diagnostics:</strong> Device model, operating system version, IP address, unique device identifiers, network state, crash logs, and push notification tokens (OneSignal / FCM).</li>
            </ul>
        </div>

        <!-- Device Permissions -->
        <div class="policy-section">
            <h2><i class="fas fa-mobile-alt"></i> 4. Android Device Permissions Used</h2>
            <p>Our mobile application requests specific device permissions to function effectively:</p>
            <ul>
                <li><code>ACCESS_FINE_LOCATION</code> & <code>ACCESS_COARSE_LOCATION</code>: To detect your real-time vehicle position for job allocation and trip routing.</li>
                <li><code>ACCESS_BACKGROUND_LOCATION</code>: To allow uninterrupted journey tracking while navigating or when using other apps during an active trip.</li>
                <li><code>FOREGROUND_SERVICE</code> & <code>FOREGROUND_SERVICE_LOCATION</code>: To maintain a transparent, ongoing service notification while running live tracking.</li>
                <li><code>CAMERA</code> & <code>READ_MEDIA_IMAGES / STORAGE</code>: Required solely when you upload driver license copies, vehicle photos, or profile photos. We never access your camera or personal gallery without explicit user action.</li>
                <li><code>POST_NOTIFICATIONS</code>: To deliver real-time ride offers, booking updates, passenger chat messages, and account status notifications.</li>
            </ul>
        </div>

        <!-- How Information is Used -->
        <div class="policy-section">
            <h2><i class="fas fa-cogs"></i> 5. How We Use Your Information</h2>
            <p>We use the collected information for specific, lawful purposes:</p>
            <ul>
                <li>To authenticate driver accounts and facilitate passenger-driver ride connections.</li>
                <li>To compute trip distances, manage in-app wallet balances, process payouts, and generate digital invoices.</li>
                <li>To communicate transactional alerts, booking status, security updates, and promotional communications where permitted.</li>
                <li>To combat fraudulent bookings, prevent fake accounts, and ensure community safety.</li>
                <li>To comply with statutory legal requirements under Indian motor vehicle regulations and financial compliance mandates.</li>
            </ul>
        </div>

        <!-- Sharing & Third Parties -->
        <div class="policy-section">
            <h2><i class="fas fa-handshake"></i> 6. Sharing of Information with Third Parties</h2>
            <p>We do not sell, rent, or trade your personal data to advertisers or third parties. We share data only with trusted service providers who assist us in operating our platform:</p>
            <ul>
                <li><strong>Passengers:</strong> During an active booking, the allocated passenger sees the driver's first name, vehicle model, license plate number, contact number, rating, and live GPS location.</li>
                <li><strong>Google Play Services & Google Maps:</strong> Used for map rendering, location geocoding, and navigational route calculation.</li>
                <li><strong>Razorpay:</strong> Secure payment gateway partner handling wallet deposits and transactions.</li>
                <li><strong>Surepass / DigiLocker:</strong> Government-authorized verification partners for driving license and document authentication.</li>
                <li><strong>OneSignal & Firebase:</strong> Cloud messaging providers for delivering real-time push notifications.</li>
                <li><strong>Law Enforcement & Legal Compliance:</strong> We may disclose data if required to do so by applicable Indian law, court subpoena, or government authority for safety and crime investigation.</li>
            </ul>
        </div>

        <!-- Data Retention and Account Deletion -->
        <div class="policy-section">
            <h2><i class="fas fa-trash-alt"></i> 7. Data Retention & Account Deletion Request</h2>
            <p>
                We retain your personal information as long as your partner account remains active or as necessary to provide services, resolve disputes, and maintain statutory financial and tax transaction records.
            </p>
            
            <div class="policy-highlight-box">
                <strong><i class="fas fa-user-slash"></i> How to Request Account & Data Deletion:</strong><br>
                Under Google Play policies and data protection standards, you have the right to request full deletion of your account and associated personal data at any time.
                <br><br>
                To request account and data deletion:
                <ol style="margin-top: 10px; margin-left: 20px;">
                    <li>Send an email to <strong>info@chooseataxi.in</strong> with the subject line <em>"Account Deletion Request"</em>.</li>
                    <li>Specify your registered mobile phone number and partner ID.</li>
                    <li>Alternatively, call our support team directly at <strong>+91 8058602516</strong> during working hours.</li>
                </ol>
                Once verified, your account, personal data, driving documents, and location history will be permanently deleted or anonymized within <strong>14 to 30 days</strong>, with the exception of statutory tax and accounting records retained as mandated by Indian law.
            </div>
        </div>

        <!-- Security -->
        <div class="policy-section">
            <h2><i class="fas fa-lock"></i> 8. Data Security Safeguards</h2>
            <p>
                We take rigorous technical and administrative measures to protect your information against unauthorized access, loss, or misuse:
            </p>
            <ul>
                <li>All data transferred between the mobile app, website, and our servers is encrypted using Industry-standard SSL/TLS (HTTPS).</li>
                <li>Database records, authentication tokens (JWT), and sensitive credentials are encrypted and stored behind firewall-protected infrastructure.</li>
                <li>Access to driver identification documents is restricted strictly to authorized verification personnel.</li>
            </ul>
        </div>

        <!-- Children's Privacy -->
        <div class="policy-section">
            <h2><i class="fas fa-child"></i> 9. Children's Privacy</h2>
            <p>
                Our services and driver registration are intended exclusively for individuals aged 18 years or older who hold a valid commercial driving license. We do not knowingly collect personal data from minors under the age of 18.
            </p>
        </div>

        <!-- Updates to this Policy -->
        <div class="policy-section">
            <h2><i class="fas fa-sync-alt"></i> 10. Updates to this Policy</h2>
            <p>
                We may periodically update this Privacy Policy to reflect changes in our services, technologies, or legal obligations. We will notify users of any substantial revisions through in-app alerts, email, or a prominent notice on our website prior to the change becoming effective.
            </p>
        </div>

        <!-- Contact Us -->
        <div class="policy-section">
            <h2><i class="fas fa-envelope-open-text"></i> 11. Contact Us & Grievance Officer</h2>
            <p>If you have questions, feedback, or concerns regarding this Privacy Policy or your personal data, please reach out to our team:</p>
            
            <div class="contact-box">
                <p><strong>Entity Name:</strong> Choose A Taxi (Choose A Taxi India)</p>
                <p><strong>Registered Address:</strong> 40, Ashok Vihar Phase-3 Ext., Gurgaon - 122001, Haryana, India</p>
                <p><strong>Customer & Driver Support Helpline:</strong> <a href="tel:8058602516" style="color: #00a63f; font-weight: 600;">+91 80586-02516</a></p>
                <p><strong>Privacy & Grievance Email:</strong> <a href="mailto:info@chooseataxi.in" style="color: #00a63f; font-weight: 600;">info@chooseataxi.in</a></p>
                <p><strong>Official Website:</strong> <a href="https://chooseataxi.in" target="_blank" style="color: #00a63f;">https://chooseataxi.in</a></p>
            </div>
        </div>

    </div>
</div>

<?php include 'includes/footer.php'; ?>
