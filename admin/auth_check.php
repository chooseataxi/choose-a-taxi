<?php
require_once __DIR__ . '/../includes/db.php';
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

function checkAdminAuth() {
    $jwt = $_COOKIE['admin_token'] ?? null;

    if (!$jwt) {
        header('Location: login.php');
        exit;
    }

    try {
        $secretKey = $_ENV['JWT_SECRET'] ?? 'default_secret_key_if_not_set';
        $decoded = JWT::decode($jwt, new Key($secretKey, 'HS256'));
        return (array)$decoded;
    } catch (Exception $e) {
        // Token is invalid, expired, etc.
        setcookie('admin_token', '', time() - 3600, '/'); // Clear the cookie
        $error = urlencode($e->getMessage());
        header("Location: login.php?error=$error");
        exit;
    }
}

// Perform auth check if not already on the login page or in the API folder
$adminData = checkAdminAuth();
