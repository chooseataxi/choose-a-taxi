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

        // ── Submit a rating ─────────────────────────────────────────────────
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

            // Upsert — update if same reviewer+booking exists
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

        // ── Get ratings for a partner ────────────────────────────────────────
        case 'get_ratings': {
            $target = (int)($reviewed_id ?: $partner_id);
            if (!$target) { echo json_encode(['status' => 'error', 'message' => 'reviewed_id required']); exit; }

            // Summary
            $sumStmt = $pdo->prepare("
                SELECT COUNT(*) as total, ROUND(AVG(rating), 1) as avg_rating
                FROM partner_ratings WHERE reviewed_id = :id
            ");
            $sumStmt->execute([':id' => $target]);
            $summary = $sumStmt->fetch(PDO::FETCH_ASSOC);

            // Individual reviews with reviewer name
            $revStmt = $pdo->prepare("
                SELECT pr.id, pr.rating, pr.review_text, pr.created_at, pr.booking_id,
                       p.name as reviewer_name
                FROM partner_ratings pr
                LEFT JOIN partners p ON p.id = pr.reviewer_id
                WHERE pr.reviewed_id = :id
                ORDER BY pr.created_at DESC
                LIMIT 50
            ");
            $revStmt->execute([':id' => $target]);
            $reviews = $revStmt->fetchAll(PDO::FETCH_ASSOC);

            // Partner name
            $nameStmt = $pdo->prepare("SELECT name FROM partners WHERE id = :id");
            $nameStmt->execute([':id' => $target]);
            $partner = $nameStmt->fetch(PDO::FETCH_ASSOC);

            echo json_encode([
                'status'       => 'success',
                'partner_name' => $partner['name']  ?? 'Partner',
                'avg_rating'   => $summary['avg_rating'] ?? 0,
                'total'        => (int)($summary['total'] ?? 0),
                'reviews'      => $reviews,
            ]);
            break;
        }

        // ── Get just the avg rating for a partner (used on cards) ───────────
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
