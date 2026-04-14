<?php
require_once __DIR__ . '/includes/notification_helper.php';

echo "Testing FCM v1 Token Generation...\n";

try {
    // Reflection to call private method for testing
    $class = new ReflectionClass('NotificationHelper');
    $method = $class->getMethod('getAccessToken');
    $method->setAccessible(true);
    
    $token = $method->invoke(null);
    
    if ($token) {
        echo "SUCCESS: Access Token Generated: " . substr($token, 0, 20) . "...\n";
    } else {
        echo "FAILED: No token returned. Check error logs.\n";
    }
    
    echo "Project ID: " . NotificationHelper::getProjectId() . "\n";
    
} catch (Exception $e) {
    echo "ERROR: " . $e->getMessage() . "\n";
}
