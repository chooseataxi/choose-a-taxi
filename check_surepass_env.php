<?php
require_once __DIR__ . '/includes/db.php';
header('Content-Type: application/json');
echo json_encode([
    'SUREPASS_TOKEN_ENV' => isset($_ENV['SUREPASS_TOKEN']) ? 'Set' : 'Not Set',
    'SUREPASS_TOKEN_SERVER' => isset($_SERVER['SUREPASS_TOKEN']) ? 'Set' : 'Not Set',
    'SUREPASS_BASE_URL' => $_ENV['SUREPASS_BASE_URL'] ?? 'Not Set',
    'TOKEN_VALUE_START' => substr($_ENV['SUREPASS_TOKEN'] ?? '', 0, 10) . '...',
    'DOTENV_EXISTS' => class_exists('Dotenv\Dotenv') ? 'Yes' : 'No'
]);
