<?php
require_once __DIR__ . '/../vendor/autoload.php';

// USE ABSOLUTE PATH TO PREVENT FAILURE
$rootPath = realpath(__DIR__ . '/../');

if (class_exists('Dotenv\Dotenv')) {
    try {
        $dotenv = Dotenv\Dotenv::createImmutable($rootPath);
        $dotenv->safeLoad();
    } catch (Exception $e) {
        // Silent fail for Dotenv if file missing, we rely on server vars
    }
}

// Database connection parameters (fallback to defaults if .env fails)
$host = $_ENV['DB_HOST'] ?? 'localhost';
$db   = $_ENV['DB_NAME'] ?? 'u885872058_chooseataxi';
$user = $_ENV['DB_USER'] ?? 'u885872058_chooseataxi';
$pass = $_ENV['DB_PASS'] ?? 'Nknehra@7432';
$port = $_ENV['DB_PORT'] ?? 3306;
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;port=$port;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
     $pdo = new PDO($dsn, $user, $pass, $options);
     date_default_timezone_set('Asia/Kolkata');
     $pdo->exec("SET time_zone = '+05:30'");
} catch (\PDOException $e) {
     // Log DB error for debugging
     error_log("Database Connection Failed: " . $e->getMessage());
     throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
