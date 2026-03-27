<?php
// Clear the admin_token cookie to logout
setcookie('admin_token', '', time() - 3600, '/');
header('Location: login.php');
exit;
