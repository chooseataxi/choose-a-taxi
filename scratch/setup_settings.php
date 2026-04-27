<?php
try {
    $pdo = new PDO("mysql:host=localhost;dbname=u885872058_chooseataxi", "root", "");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $pdo->exec("CREATE TABLE IF NOT EXISTS site_settings (
        setting_key VARCHAR(100) PRIMARY KEY,
        setting_value TEXT,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    )");

    // Get values from .env if possible
    $rootPath = realpath(__DIR__ . '/../');
    $env = [];
    if (file_exists($rootPath . '/.env')) {
        $lines = file($rootPath . '/.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        foreach ($lines as $line) {
            if (strpos(trim($line), '#') === 0) continue;
            list($name, $value) = explode('=', $line, 2);
            $env[trim($name)] = trim($value, '"\' ');
        }
    }

    $settings = [
        'onesignal_app_id' => $env['ONESIGNAL_APP_ID'] ?? '8af20809-09e9-4ce1-9377-989b6b4e4600',
        'onesignal_rest_api_key' => $env['ONESIGNAL_API_KEY'] ?? ''
    ];

    $stmt = $pdo->prepare("INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES (?, ?)");
    foreach ($settings as $key => $value) {
        $stmt->execute([$key, $value]);
    }

    echo "Settings table created and initialized.";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
