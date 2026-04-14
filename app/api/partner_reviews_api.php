<?php
require_once __DIR__ . '/../../includes/db.php';

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit; }

$action      = $_REQUEST['action']      ?? '';
$partner_id  = $_REQUEST['partner_id']  ?? '';
$reviewed_id = $_REQUEST['reviewed_id'] ?? '';

// Generate a random ID to prove this file is fresh
$debug_id = "v3_" . time();

try {
    // ── Lazy table creation ──────────────────────────────────────────────────
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS partner_ratings (
            id           INT AUTO_INCREMENT PRIMARY KEY,
            reviewer_id  INT NOT NULL,
            reviewed_id  INT NOT NULL,
            booking_id   INT DEFAULT NULL,
            rating       TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
            review_text  TEXT,
            created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            UNIQUE KEY one_per_booking (reviewer_id, reviewed_id, booking_id)
        )
    ");

    switch ($action) {

        case 'submit_rating': {
            $reviewer_id = (int)($_POST['reviewer_id'] ?? $partner_id);
            $reviewed_id = (int)($_POST['reviewed_id'] ?? 0);
            $booking_id  = !empty($_POST['booking_id'])  ? (int)$_POST['booking_id']  : null;
            $rating      = (int)($_POST['rating']      ?? 0);
            $review_text = trim($_POST['review_text']  ?? '');

            if (!$reviewer_id || !$reviewed_id || $rating < 1 || $rating > 5) {
                echo json_encode(['status' => 'error', 'message' => 'Invalid parameters']);
                exit;
            }
            if ($reviewer_id === $reviewed_id) {
                echo json_encode(['status' => 'error', 'message' => 'Cannot rate yourself']);
                exit;
            }

            $stmt = $pdo->prepare("
                INSERT INTO partner_ratings (reviewer_id, reviewed_id, booking_id, rating, review_text)
                VALUES (:rev, :revd, :bid, :r, :txt)
                ON DUPLICATE KEY UPDATE rating = :r2, review_text = :txt2, created_at = NOW()
            ");
            $stmt->execute([
                ':rev'  => $reviewer_id,
                ':revd' => $reviewed_id,
                ':bid'  => $booking_id,
                ':r'    => $rating,
                ':txt'  => $review_text,
                ':r2'   => $rating,
                ':txt2' => $review_text,
            ]);

            echo json_encode(['status' => 'success', 'message' => 'Rating submitted']);
            break;
        }

        case 'get_ratings': {
            $target = (int)($reviewed_id ?: $partner_id);
            if (!$target) { echo json_encode(['status' => 'error', 'message' => 'reviewed_id required']); exit; }

            // 1. Target Partner Info (image and name)
            $nameStmt = $pdo->prepare("SELECT full_name, selfie_link FROM partners WHERE id = :id");
            $nameStmt->execute([':id' => $target]);
            $partner = $nameStmt->fetch(PDO::FETCH_ASSOC);

            // 2. Rating Summary
            $sumStmt = $pdo->prepare("
                SELECT COUNT(*) as total, ROUND(AVG(rating), 1) as avg_rating
                FROM partner_ratings WHERE reviewed_id = :id
            ");
            $sumStmt->execute([':id' => $target]);
            $summary = $sumStmt->fetch(PDO::FETCH_ASSOC);

            // 3. Monthly Performance Stats (Current Month)
            $monthStart = date('Y-m-01');
            $stats = [];
            
            // Total Posted
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM partner_bookings WHERE partner_id = ? AND start_date >= ?");
            $stmt->execute([$target, $monthStart]);
            $stats['posted'] = (int)$stmt->fetchColumn();

            // Total Completed
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM partner_bookings WHERE partner_id = ? AND status = 'Completed' AND start_date >= ?");
            $stmt->execute([$target, $monthStart]);
            $stats['completed'] = (int)$stmt->fetchColumn();

            // Total Cancelled
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM partner_bookings WHERE partner_id = ? AND status = 'Cancelled' AND start_date >= ?");
            $stmt->execute([$target, $monthStart]);
            $stats['cancelled'] = (int)$stmt->fetchColumn();

            // 4. Individual reviews with reviewer images
            $revStmt = $pdo->prepare("
                SELECT pr.id, pr.rating, pr.review_text, pr.created_at, pr.booking_id,
                       p.full_name as reviewer_name, p.selfie_link as reviewer_image
                FROM partner_ratings pr
                LEFT JOIN partners p ON p.id = pr.reviewer_id
                WHERE pr.reviewed_id = :id
                ORDER BY pr.created_at DESC
                LIMIT 50
            ");
            $revStmt->execute([':id' => $target]);
            $reviews = $revStmt->fetchAll(PDO::FETCH_ASSOC);

            echo json_encode([
                'status'        => 'success',
                'partner_name'  => $partner['full_name']  ?? 'Partner',
                'partner_image' => $partner['selfie_link'] ?? '',
                'avg_rating'    => $summary['avg_rating'] ?? 0,
                'total'         => (int)($summary['total'] ?? 0),
                'reviews'       => $reviews ?? [],
                'stats'         => $stats,
                'debug_id'      => $debug_id
            ]);
            break;
        }

        case 'get_avg_rating': {
            $target = (int)($reviewed_id ?: $partner_id);
            if (!$target) { echo json_encode(['avg' => 0, 'count' => 0]); exit; }

            $stmt = $pdo->prepare("
                SELECT ROUND(AVG(rating),1) as avg, COUNT(*) as cnt
                FROM partner_ratings WHERE reviewed_id = :id
            ");
            $stmt->execute([':id' => $target]);
            $r = $stmt->fetch(PDO::FETCH_ASSOC);
            echo json_encode(['avg' => $r['avg'] ?? 0, 'count' => (int)($r['cnt'] ?? 0)]);
            break;
        }

        default:
            echo json_encode(['status' => 'error', 'message' => 'Unknown action']);
    }

} catch (PDOException $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
