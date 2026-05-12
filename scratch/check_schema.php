<?php
require 'd:/wamp/www/chooseataxi.com/includes/db.php';
echo "--- partners ---\n";
foreach($pdo->query("DESCRIBE partners")->fetchAll() as $r) echo $r['Field']."\n";
echo "\n--- partner_bookings ---\n";
foreach($pdo->query("DESCRIBE partner_bookings")->fetchAll() as $r) echo $r['Field']."\n";
