<?php
require_once __DIR__ . '/../auth_check.php';
include __DIR__ . '/../header.php';

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

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-bullhorn me-2"></i>Manage App Notices</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="../index.php">Admin</a></li>
                    <li class="breadcrumb-item active">Mobile App Notices</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <?php if ($message): ?>
                    <div class="alert alert-success shadow-sm border-0 rounded-3">
                        <i class="fas fa-check-circle me-2"></i><?php echo $message; ?>
                    </div>
                <?php endif; ?>

                <div class="card shadow-lg border-0 rounded-4 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="mb-0 fw-bold text-dark">Post New Notice</h5>
                        <p class="text-muted small mb-0">Broadcast messages to all partners in real-time.</p>
                    </div>
                    <div class="card-body p-4">
                        <form method="POST">
                            <input type="hidden" name="action" value="save_notice">
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-muted text-uppercase mb-2">Notice Title</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fas fa-tag text-muted"></i></span>
                                    <input type="text" name="title" class="form-control border-start-0 ps-0 shadow-none" placeholder="e.g. Important Security Update" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-muted text-uppercase mb-2">Message Content (Hindi/English)</label>
                                <textarea name="content" class="form-control shadow-none" rows="6" placeholder="Type your notice here..." required style="border-radius: 12px;"></textarea>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary rounded-pill py-3 fw-bold shadow-sm">
                                    <i class="fas fa-paper-plane me-2"></i>POST NOTICE NOW
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <?php if ($active_notice): ?>
                <div class="card shadow border-0 rounded-4 overflow-hidden">
                    <div class="card-header bg-success-subtle py-3 border-0">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="fw-bold mb-0 text-success"><i class="fas fa-broadcast-tower me-2"></i>Currently Active Notice</h5>
                            <span class="badge bg-success rounded-pill px-3 py-2">LIVE NOW</span>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="p-4 bg-light rounded-4 border border-dashed">
                            <h6 class="fw-bold text-dark mb-2" style="font-size: 1.1rem;"><?php echo htmlspecialchars($active_notice['title']); ?></h6>
                            <p class="mb-0 text-secondary" style="line-height: 1.6;"><?php echo nl2br(htmlspecialchars($active_notice['content'])); ?></p>
                            <hr class="my-4 opacity-10">
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted"><i class="far fa-calendar-alt me-1"></i> Posted on: <?php echo date('d M Y, h:i A', strtotime($active_notice['created_at'])); ?></small>
                                <div class="text-primary small fw-bold">Active for all partners</div>
                            </div>
                        </div>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<style>
    .bg-success-subtle { background-color: #e8f5e9; }
    .border-dashed { border-style: dashed !important; border-width: 2px !important; border-color: #dee2e6 !important; }
    .btn-primary { background-color: #28a745; border: none; }
    .btn-primary:hover { background-color: #218838; }
</style>

<?php include __DIR__ . '/../footer.php'; ?>
