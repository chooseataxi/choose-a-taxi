<?php
include '../../includes/db.php';
session_start();

if (!isset($_SESSION['admin_id'])) {
    header("Location: ../login.php");
    exit;
}

$message = "";
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['action'])) {
    if ($_POST['action'] == 'save_notice') {
        $content = $_POST['content'];
        $title = $_POST['title'];
        
        // Deactivate old notices
        $pdo->prepare("UPDATE app_notices SET status = 'inactive'")->execute();
        
        // Insert new notice
        $stmt = $pdo->prepare("INSERT INTO app_notices (title, content, status, created_at) VALUES (?, ?, 'active', NOW())");
        if ($stmt->execute([$title, $content])) {
            $message = "Notice updated successfully! Old notices expired.";
        }
    }
}

// Fetch active notice
$active_notice = $pdo->query("SELECT * FROM app_notices WHERE status = 'active' ORDER BY id DESC LIMIT 1")->fetch();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage App Notices - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;900&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; background: #f4f6f9; }
        .card { border-radius: 15px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .btn-primary { background: #2E3E5C; border: none; padding: 12px 30px; border-radius: 10px; font-weight: 600; }
        .btn-primary:hover { background: #1a2538; }
        .header { background: #2E3E5C; color: white; padding: 40px 0; margin-bottom: 40px; }
    </style>
</head>
<body>

<div class="header">
    <div class="container">
        <h1>Manage App Notices</h1>
        <p class="mb-0">Broadcast messages to all partners in real-time.</p>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-8 mx-auto">
            <?php if ($message): ?>
                <div class="alert alert-success"><?php echo $message; ?></div>
            <?php endif; ?>

            <div class="card mb-4">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4">Post New Notice</h5>
                    <form method="POST">
                        <input type="hidden" name="action" value="save_notice">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Notice Title</label>
                            <input type="text" name="title" class="form-control" placeholder="e.g. Important Security Update" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Message Content (Hindi/English)</label>
                            <textarea name="content" class="form-control" rows="6" placeholder="Type your notice here..." required></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">POST NOTICE NOW</button>
                        </div>
                    </form>
                </div>
            </div>

            <?php if ($active_notice): ?>
            <div class="card">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0">Currently Active Notice</h5>
                        <span class="badge bg-success">LIVE</span>
                    </div>
                    <div class="p-3 bg-light rounded-3">
                        <h6 class="fw-bold"><?php echo htmlspecialchars($active_notice['title']); ?></h6>
                        <p class="mb-0 text-muted"><?php echo nl2br(htmlspecialchars($active_notice['content'])); ?></p>
                        <hr>
                        <small class="text-secondary">Posted on: <?php echo $active_notice['created_at']; ?></small>
                    </div>
                </div>
            </div>
            <?php endif; ?>
        </div>
    </div>
</div>

</body>
</html>
