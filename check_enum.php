<?php
$dsn = "mysql:host=localhost;dbname=u885872058_chooseataxi;charset=utf8mb4";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];
try {
    $pdo = new PDO($dsn, "root", "", $options);
    $stmt = $pdo->query("DESCRIBE partner_transactions");
    print_r($stmt->fetchAll());
} catch (Exception $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
