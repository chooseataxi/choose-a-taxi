<?php
require_once __DIR__ . '/../../includes/db.php';
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    if (empty($email) || empty($password)) {
        echo json_encode(['success' => false, 'message' => 'Email and password are required.']);
        exit;
    }

    try {
        $stmt = $pdo->prepare("SELECT * FROM admins WHERE email = ?");
        $stmt->execute([$email]);
        $admin = $stmt->fetch();

        if ($admin && password_verify($password, $admin['password'])) {
            // Generate JWT
            $secretKey = $_ENV['JWT_SECRET'] ?? 'default_secret_key_if_not_set';
            $issuedAt = time();
            $expire = $issuedAt + (int)($_ENV['JWT_EXPIRE_MIN'] ?? 43200) * 60;

            $payload = [
                'iat' => $issuedAt,
                'exp' => $expire,
                'sub' => $admin['id'],
                'name' => $admin['name'],
                'email' => $admin['email']
            ];

            $jwt = JWT::encode($payload, $secretKey, 'HS256');

            // Set JWT in HttpOnly cookie
            $isSecure = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on';
            setcookie('admin_token', $jwt, [
                'expires' => $expire,
                'path' => '/',
                'domain' => '', 
                'secure' => $isSecure,
                'httponly' => true,
                'samesite' => 'Strict',
            ]);

            echo json_encode([
                'success' => true, 
                'message' => 'Login successful',
                'admin' => [
                    'id' => $admin['id'],
                    'name' => $admin['name'],
                    'email' => $admin['email'],
                    'profile_picture' => $admin['profile_picture']
                ]
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Invalid email or password.']);
        }

    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => 'Server error: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
