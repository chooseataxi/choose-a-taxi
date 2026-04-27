<?php
$hosts = ['localhost', '127.0.0.1'];
$users = ['root', 'u885872058_chooseataxi'];
$passes = ['', 'Nknehra@7432'];
$db = 'u885872058_chooseataxi';

foreach ($hosts as $host) {
    foreach ($users as $user) {
        foreach ($passes as $pass) {
            try {
                $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
                echo "SUCCESS: host=$host, user=$user, pass=$pass\n";
                exit;
            } catch (Exception $e) {
                echo "FAIL: host=$host, user=$user, pass=$pass - " . $e->getMessage() . "\n";
            }
        }
    }
}
?>
