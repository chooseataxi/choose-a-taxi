<?php
/**
 * Server-side DataTables endpoint for Partner Management
 * Handles pagination, searching, sorting via AJAX
 */
require_once __DIR__ . '/../../auth_check.php';

header('Content-Type: application/json');

try {
    // DataTables request parameters
    $draw     = intval($_REQUEST['draw'] ?? 0);
    $start    = intval($_REQUEST['start'] ?? 0);
    $length   = intval($_REQUEST['length'] ?? 10);
    $search   = trim($_REQUEST['search']['value'] ?? '');

    // Allowed sort columns mapping (index => actual DB column)
    $columns = [
        0 => 'p.id',
        1 => 'p.full_name',
        2 => 'p.mobile',
        3 => 'p.manual_verification_status',
        4 => null, // Actions — not sortable
    ];

    $orderColumnIndex = intval($_REQUEST['order'][0]['column'] ?? 0);
    $orderDir = strtoupper($_REQUEST['order'][0]['dir'] ?? 'DESC');
    $orderDir = in_array($orderDir, ['ASC', 'DESC'], true) ? $orderDir : 'DESC';
    $orderColumn = $columns[$orderColumnIndex] ?? 'p.id';
    // If the chosen column is not sortable (Actions), fallback to id DESC
    if ($orderColumn === null) {
        $orderColumn = 'p.id';
        $orderDir = 'DESC';
    }

    // Base WHERE clause
    $where = '';
    $params = [];

    if (!empty($search)) {
        $where = " WHERE (p.full_name LIKE :search1 OR p.mobile LIKE :search2 OR p.email LIKE :search3 OR CAST(p.id AS CHAR) LIKE :search4)";
        $searchParam = "%{$search}%";
        $params[':search1'] = $searchParam;
        $params[':search2'] = $searchParam;
        $params[':search3'] = $searchParam;
        $params[':search4'] = $searchParam;
    }

    // ===== Total records (unfiltered) =====
    $stmtTotal = $pdo->query("SELECT COUNT(*) FROM partners p");
    $recordsTotal = intval($stmtTotal->fetchColumn());

    // ===== Filtered records =====
    if (!empty($where)) {
        $stmtFiltered = $pdo->prepare("SELECT COUNT(*) FROM partners p{$where}");
        $stmtFiltered->execute($params);
        $recordsFiltered = intval($stmtFiltered->fetchColumn());
    } else {
        $recordsFiltered = $recordsTotal;
    }

    // ===== Page data =====
    $sql = "SELECT p.id, p.full_name, p.email, p.mobile, p.selfie_link,
                   p.manual_verification_status, p.status, p.created_at
            FROM partners p{$where}
            ORDER BY {$orderColumn} {$orderDir}
            LIMIT :lim OFFSET :off";

    $stmtData = $pdo->prepare($sql);
    foreach ($params as $key => $val) {
        $stmtData->bindValue($key, $val, PDO::PARAM_STR);
    }
    $stmtData->bindValue(':lim', $length, PDO::PARAM_INT);
    $stmtData->bindValue(':off', $start, PDO::PARAM_INT);
    $stmtData->execute();
    $rows = $stmtData->fetchAll();

    // ===== Format data rows for DataTables =====
    $data = [];
    foreach ($rows as $row) {
        // Selfie / Avatar
        $avatarHtml = '';
        if (!empty($row['selfie_link'])) {
            $avatarHtml = '<img src="../../uploads/partners/' . htmlspecialchars($row['selfie_link']) . '" style="width:100%; height:100%; object-fit:cover;">';
        } else {
            $avatarHtml = '<i class="fas fa-user text-primary"></i>';
        }

        // Verification badge
        $vStatus = $row['manual_verification_status'] ?? 'Pending';
        $vClass = 'bg-warning text-dark';
        if ($vStatus === 'Approved') $vClass = 'bg-success text-white';
        if ($vStatus === 'Rejected') $vClass = 'bg-danger text-white';
        $vIcon = $vStatus === 'Approved' ? 'fa-check-circle' : 'fa-clock';
        $verificationBadge = '<span class="badge ' . $vClass . ' rounded-pill px-3 py-2 border"><i class="fas ' . $vIcon . ' me-1"></i> ' . htmlspecialchars($vStatus) . '</span>';

        $data[] = [
            'id'                    => '#' . $row['id'],
            'id_raw'                => $row['id'],
            'full_name'             => htmlspecialchars($row['full_name'] ?? 'N/A'),
            'mobile'                => htmlspecialchars($row['mobile']),
            'email'                 => htmlspecialchars($row['email'] ?? 'Not Provided'),
            'selfie_link'           => htmlspecialchars($row['selfie_link'] ?? ''),
            'manual_verification_status' => $vStatus,
            'status'                => htmlspecialchars($row['status']),
            'created_at'            => $row['created_at'],

            // Pre-rendered HTML columns
            'avatar_html'           => $avatarHtml,
            'verification_badge'    => $verificationBadge,
        ];
    }

    echo json_encode([
        'draw'            => $draw,
        'recordsTotal'    => $recordsTotal,
        'recordsFiltered' => $recordsFiltered,
        'data'            => $data,
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'draw'            => intval($_REQUEST['draw'] ?? 0),
        'recordsTotal'    => 0,
        'recordsFiltered' => 0,
        'data'            => [],
        'error'           => 'Server error: ' . $e->getMessage(),
    ]);
}
