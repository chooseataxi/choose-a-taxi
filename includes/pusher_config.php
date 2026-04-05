<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Pusher\Pusher;

$pusher_config = [
    'app_id' => '2136865',
    'key'    => '0708e2bb2bfc100d97ee',
    'secret' => '877392d3a0b245c04dac',
    'cluster' => 'ap2',
    'useTLS' => true
];

$pusher = new Pusher(
    $pusher_config['key'],
    $pusher_config['secret'],
    $pusher_config['app_id'],
    [
        'cluster' => $pusher_config['cluster'],
        'useTLS'  => $pusher_config['useTLS']
    ]
);
?>
