<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host = $_SERVER['HTTP_HOST'] ?? $_SERVER['SERVER_NAME'] ?? 'chooseataxi.com';
$baseUrl = "$protocol://$host";

echo json_encode([
    'status' => 'success',
    'server' => [
        'base_url' => $baseUrl,
        'api_base_url' => "$baseUrl/app/api",
        'host' => $host,
        'protocol' => $protocol,
        'port' => $_SERVER['SERVER_PORT'] ?? 80,
        'server_software' => $_SERVER['SERVER_SOFTWARE'] ?? 'unknown',
        'server_time' => date('Y-m-d H:i:s'),
        'timezone' => date_default_timezone_get(),
    ],
    'app' => [
        'android_package' => 'in.chooseataxi.partner',
        'update_url' => 'https://play.google.com/store/apps/details?id=in.chooseataxi.partner',
    ],
    'endpoints' => [
        'auth' => "$baseUrl/app/api/partner_auth.php",
        'bookings' => "$baseUrl/app/api/partner_bookings_api.php",
        'version_check' => "$baseUrl/app/api/app_version_api.php",
        'config' => "$baseUrl/app/api/config.php",
    ],
], JSON_UNESCAPED_SLASHES);
