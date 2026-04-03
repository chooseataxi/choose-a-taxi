<?php
$host = 'localhost';
$db   = 'u885872058_chooseataxi';
$user = 'u885872058_chooseataxi';
$pass = 'Nknehra@7432';

try {
    // If the server doesn't allow remote the standard is root / blank
    $pdo = new PDO("mysql:host=localhost;dbname=$db", 'root', '');
} catch(Exception $e) {
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    } catch(Exception $e2) {
        die("Connection Failed");
    }
}

try {
    $pdo->exec("ALTER TABLE partner_bookings AUTO_INCREMENT = 2627600");
    echo "Success";
} catch(Exception $e) {
    echo "Fail " . $e->getMessage();
}
