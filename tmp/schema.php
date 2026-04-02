<?php
require 'includes/db.php';
$stmt = $pdo->query("DESCRIBE partners");
foreach($stmt as $row) {
    echo $row['Field'] . " | " . $row['Type'] . "\n";
}
