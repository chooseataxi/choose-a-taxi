<?php
require_once __DIR__ . '/../includes/db.php';

try {
    // Create admins table if it doesn't exist
    $sql = "CREATE TABLE IF NOT EXISTS admins (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        mobile VARCHAR(20) NOT NULL,
        profile_picture VARCHAR(255) DEFAULT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
    
    $pdo->exec($sql);
    echo "Admins table created or already exists.<br>";

    // Insert default admin if table is empty
    $check = $pdo->query("SELECT COUNT(*) FROM admins")->fetchColumn();
    if ($check == 0) {
        $name = "Admin";
        $email = "admin@chooseataxi.com";
        $mobile = "1234567890";
        $password = password_hash("Admin@123", PASSWORD_BCRYPT);
        $profile_picture = "assets/images/default-admin.png";

        $stmt = $pdo->prepare("INSERT INTO admins (name, email, mobile, profile_picture, password) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$name, $email, $mobile, $profile_picture, $password]);
        
        echo "Default admin created successfully!<br>";
        echo "Email: $email<br>";
        echo "Password: Admin@123<br>";
    } else {
        echo "Admins already exist in the database.";
    }

} catch (PDOException $e) {
    die("Error setting up admin: " . $e->getMessage());
}
