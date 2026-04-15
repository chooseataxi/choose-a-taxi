<?php
/**
 * Database Migration Script
 * This script adds the missing columns to the 'cars' table.
 */

require_once __DIR__ . '/includes/db.php';

echo "<h3>Database Migration Utility</h3>";
echo "Attempting to update table 'cars'...<br>";

try {
    $sql = "ALTER TABLE cars 
            ADD COLUMN include_toll ENUM('Included', 'Excluded') DEFAULT 'Included', 
            ADD COLUMN include_tax ENUM('Included', 'Excluded') DEFAULT 'Included', 
            ADD COLUMN include_driver_allowance ENUM('Included', 'Excluded') DEFAULT 'Included', 
            ADD COLUMN include_night_charges ENUM('Included', 'Excluded') DEFAULT 'Included', 
            ADD COLUMN include_parking ENUM('Included', 'Excluded') DEFAULT 'Included'";
    
    $pdo->exec($sql);
    echo "<span style='color: green;'>Success: Columns added successfully!</span><br>";
} catch (PDOException $e) {
    if (strpos($e->getMessage(), 'Duplicate column name') !== false) {
        echo "<span style='color: orange;'>Notice: Columns already exist. No changes needed.</span><br>";
    } else {
        echo "<span style='color: red;'>Error: " . $e->getMessage() . "</span><br>";
    }
}

echo "<br><a href='index.php'>Return to Home</a>";
?>
