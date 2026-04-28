<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

/**
 * App Version Check API
 * 
 * Used to manage force updates and inform users about new releases.
 */

$latest_version_code = 21;
$latest_version_name = "1.3.0";

// Any version code below this will be forced to update
$min_required_version = 21; 

$response = [
    "status" => "success",
    "latest_version_code" => $latest_version_code,
    "latest_version_name" => $latest_version_name,
    "min_required_version" => $min_required_version,
    "update_url" => "https://play.google.com/store/apps/details?id=in.chooseataxi.partner",
    "update_title" => "Update Required",
    "update_message" => "We've released a new version of Choose A Taxi with important bug fixes and new features. Please update to continue."
];

echo json_encode($response);
