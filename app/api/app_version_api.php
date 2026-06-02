<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

/**
 * App Version Check API
 * 
 * Used to manage force updates and inform users about new releases.
 */

$latest_version_code = 25;
$latest_version_name = "1.7.1";

// Any version code below this will be forced to update
$min_required_version = 25; 

$response = [
    "status" => "success",
    "latest_version_code" => $latest_version_code,
    "latest_version_name" => $latest_version_name,
    "min_required_version" => $min_required_version,
    "update_url" => "https://play.google.com/store/apps/details?id=in.chooseataxi.partner",
    "update_title" => "Google Play Policy Warning",
    "update_message" => "Google Play Warning: Remove awesome notification plugin within 48 Hours otherwise app will be removed from playstore.",
    "logo_url" => "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Google_Play_2022_icon.svg/512px-Google_Play_2022_icon.svg.png",
    "image_url" => "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Google_Play_2022_icon.svg/512px-Google_Play_2022_icon.svg.png",
    "is_warning" => true,
    "warning_type" => "google_play_violation"
];

echo json_encode($response);
