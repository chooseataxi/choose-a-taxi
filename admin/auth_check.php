<?php
require_once __DIR__ . '/../includes/db.php';
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

function checkAdminAuth() {
    $jwt = $_COOKIE['admin_token'] ?? null;
    $isApi = strpos($_SERVER['REQUEST_URI'], '/api/') !== false;

    if (!$jwt) {
        if ($isApi) {
            header('Content-Type: application/json');
            http_response_code(401);
            echo json_encode(['success' => false, 'message' => 'Unauthorized access. Please login.']);
        } else {
            header('Location: login.php');
        }
        exit;
    }

    try {
        $secretKey = $_ENV['JWT_SECRET'] ?? 'b7e2c9f4a1d8e5b6c3a0f7d4e1b8c5a2d7f4e1b8c5a2d7f4e1b8c5a2d7f4e1b8';
        $decoded = JWT::decode($jwt, new Key($secretKey, 'HS256'));
        return (array)$decoded;
    } catch (Exception $e) {
        // Token is invalid, expired, etc.
        setcookie('admin_token', '', time() - 3600, '/'); // Clear the cookie
        if ($isApi) {
            header('Content-Type: application/json');
            http_response_code(401);
            echo json_encode(['success' => false, 'message' => 'Session expired. Please login again.']);
        } else {
            $error = urlencode($e->getMessage());
            header("Location: login.php?error=$error");
        }
        exit;
    }
}

// Perform auth check if not already on the login page or in the API folder
$adminData = checkAdminAuth();
