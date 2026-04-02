<?php
// Direct PDO connection to bypass any CLI errors with .env
try {
    $pdo = new PDO("mysql:host=localhost;dbname=u885872058_chooseataxi", "u885872058_chooseataxi", "Nknehra@7432", [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);

    // 1. Add driving_license_link
    try {
        $pdo->exec("ALTER TABLE partners ADD COLUMN driving_license_link VARCHAR(255) NULL AFTER aadhaar_pdf_link");
        echo "Added driving_license_link column.\n";
    } catch(PDOException $e) {
        if(strpos($e->getMessage(), 'Duplicate column name') !== false) {
             echo "Column driving_license_link already exists.\n";
        } else {
             throw $e;
        }
    }

    // 2. Add rc_book_link
    try {
        $pdo->exec("ALTER TABLE partners ADD COLUMN rc_book_link VARCHAR(255) NULL AFTER driving_license_link");
        echo "Added rc_book_link column.\n";
    } catch(PDOException $e) {
        if(strpos($e->getMessage(), 'Duplicate column name') !== false) {
             echo "Column rc_book_link already exists.\n";
        } else {
             throw $e;
        }
    }

    // 3. Add manual_verification_status
    try {
        $pdo->exec("ALTER TABLE partners ADD COLUMN manual_verification_status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending' AFTER status");
        echo "Added manual_verification_status column.\n";
    } catch(PDOException $e) {
        if(strpos($e->getMessage(), 'Duplicate column name') !== false) {
             echo "Column manual_verification_status already exists.\n";
        } else {
             throw $e;
        }
    }

    echo "Database schema update completed successfully.\n";
} catch(PDOException $e) {
    echo "Error updating schema: " . $e->getMessage() . "\n";
}
