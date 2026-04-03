<?php
$host = 'localhost';
$db   = 'u885872058_chooseataxi';
$user = 'u885872058_chooseataxi';
$pass = 'Nknehra@7432';

try {
    $pdo = new PDO("mysql:host=localhost;dbname=$db", 'root', '');
} catch(Exception $e) {
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    } catch(Exception $e2) {
        die("Connection Failed");
    }
}

try {
    $pdo->exec("ALTER TABLE partner_bookings DROP COLUMN distance_km");
    echo "Success Drop";
} catch(Exception $e) {
    echo "Fail " . $e->getMessage();
}
