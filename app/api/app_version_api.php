<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

/**
 * App Version Check API
 * 
 * Used to manage force updates, partner warnings, and plugin migration notices.
 * 
 * NOTE FOR DEVELOPERS:
 * --------------------------------------------------
 * PLUGIN MIGRATION REQUIRED (Immediate Action):
 *   - REMOVE   : awesome_notifications
 *   - INSTALL  : flutter_local_notifications
 *
 * Migration Steps:
 *   1. In pubspec.yaml:
 *        REMOVE  → awesome_notifications: ^x.x.x
 *        ADD     → flutter_local_notifications: ^17.0.0
 *
 *   2. Android → AndroidManifest.xml:
 *        Remove all awesome_notifications receiver/service entries.
 *        Add flutter_local_notifications channel setup in MainActivity.
 *
 *   3. iOS → AppDelegate.swift / AppDelegate.m:
 *        Remove awesome_notifications initialization.
 *        Add UNUserNotificationCenter delegate via flutter_local_notifications.
 *
 *   4. Dart Code:
 *        REMOVE  → AwesomeNotifications().initialize(...)
 *        ADD     → FlutterLocalNotificationsPlugin().initialize(
 *                     InitializationSettings(
 *                       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
 *                       iOS: DarwinInitializationSettings(),
 *                     ),
 *                  );
 *
 *   Official Docs: https://pub.dev/packages/flutter_local_notifications
 * --------------------------------------------------
 */

// ─── Version Configuration ────────────────────────────────────────────────────
$latest_version_code = 24;
$latest_version_name = "1.6.1";

// Any version code BELOW this will be force-updated
$min_required_version = 24;

// ─── Google Pay Compliance Warning ───────────────────────────────────────────
// Show this warning to all partners via in-app alert
$google_pay_warning = [
    "show_warning"    => true,
    "icon"            => "google_pay",                         // Use Google Pay SVG/asset in app
    "icon_url"        => "https://www.gstatic.com/images/branding/product/2x/googleg_48dp.png",
    "severity"        => "critical",                           // critical | warning | info
    "title"           => "⚠️ Action Required – App Removal Notice",
    "message"         => "Your app is at risk of being removed from Google Play within 48 hours due to non-compliance with Google Pay policies. Please review and resolve all flagged issues immediately to avoid suspension.",
    "deadline_hours"  => 48,
    "action_label"    => "Review Policy",
    "action_url"      => "https://support.google.com/googleplay/android-developer/answer/9858738",
    "issued_at"       => date("Y-m-d H:i:s"),
];

// ─── Plugin Migration Notice ──────────────────────────────────────────────────
$plugin_notice = [
    "show_notice"     => true,
    "type"            => "plugin_migration",
    "severity"        => "high",
    "title"           => "Plugin Update Required",
    "message"         => "The 'awesome_notifications' plugin is deprecated and must be replaced with 'flutter_local_notifications' immediately. Follow the migration guide to avoid notification failures.",
    "remove_plugin"   => "awesome_notifications",
    "install_plugin"  => "flutter_local_notifications",
    "pub_dev_url"     => "https://pub.dev/packages/flutter_local_notifications",
    "migration_guide" => "https://pub.dev/packages/flutter_local_notifications#readme",
];

// ─── Final Response ───────────────────────────────────────────────────────────
$response = [
    "status"               => "success",
    "latest_version_code"  => $latest_version_code,
    "latest_version_name"  => $latest_version_name,
    "min_required_version" => $min_required_version,
    "force_update"         => false,
    "update_url"           => "https://play.google.com/store/apps/details?id=in.chooseataxi.partner",
    "update_title"         => "Update Required",
    "update_message"       => "A new version of Choose A Taxi Partner is available with important improvements. Please update to continue using the app.",
    "google_pay_warning"   => $google_pay_warning,
    "plugin_notice"        => $plugin_notice,
    "generated_at"         => date("Y-m-d H:i:s"),
];

echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
