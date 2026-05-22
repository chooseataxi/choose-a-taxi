<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Ensure tables exist before fetching
require_once __DIR__ . '/api/state_city_actions.php'; 
// (The API file creates the tables on load due to our schema, but outputs JSON if POST. So we'll run a quick table creation query here directly to be safe, or just rely on standard PDO queries since GET doesn't trigger the switch)
$pdo->exec("
    CREATE TABLE IF NOT EXISTS states (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        country VARCHAR(255) DEFAULT 'India',
        status ENUM('Active', 'Inactive') DEFAULT 'Active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
");

$states = $pdo->query("SELECT * FROM states ORDER BY name ASC")->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="card shadow mb-4 border-0">
        <div class="card-header bg-white py-3 d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold text-dark">State Management</h5>
            <button class="btn btn-yellow-black shadow-sm px-4 ms-auto" data-bs-toggle="modal" data-bs-target="#stateModal" onclick="openAddModal()">
                <i class="fas fa-plus mr-1"></i> Add State
            </button>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive p-3">
                <table id="statesTable" class="table table-hover align-middle">
                    <thead class="bg-light">
                        <tr>
                            <th width="50">#</th>
                            <th>State Name</th>
                            <th>Country</th>
                            <th>Status</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($states as $idx => $state): ?>
                        <tr>
                            <td><?= $idx + 1 ?></td>
                            <td class="font-weight-bold"><?= htmlspecialchars($state['name']) ?></td>
                            <td><?= htmlspecialchars($state['country']) ?></td>
                            <td>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" <?= $state['status'] === 'Active' ? 'checked' : '' ?> onchange="toggleStatus(<?= $state['id'] ?>)">
                                </div>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary me-2" onclick="openEditModal(<?= $state['id'] ?>, '<?= htmlspecialchars(addslashes($state['name'])) ?>', '<?= htmlspecialchars(addslashes($state['country'])) ?>')">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger" onclick="deleteState(<?= $state['id'] ?>)">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- State Modal -->
<div class="modal fade" id="stateModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="stateForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Add State</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="state_id" name="id">
                    <input type="hidden" id="action" name="action" value="add_state">
                    
                    <div class="mb-3">
                        <label>State Name</label>
                        <input type="text" class="form-control" id="state_name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label>Country</label>
                        <input type="text" class="form-control" id="country" name="country" value="India" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-yellow-black">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    .btn-yellow-black { background-color: #ffc107; color: #000; font-weight: 700; border: none; transition: 0.3s; }
    .btn-yellow-black:hover { background-color: #e0ac08; }
    .table thead th { background-color: #f8f9fa; border-bottom: 2px solid #dee2e6; color: #495057; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; }
    .table-hover tbody tr:hover { background-color: rgba(255, 193, 7, 0.05); }
    .form-check-input:checked { background-color: #ffc107; border-color: #ffc107; }
</style>

<script>
function openAddModal() {
    $('#modalTitle').text('Add State');
    $('#action').val('add_state');
    $('#state_id').val('');
    $('#state_name').val('');
    $('#country').val('India');
}

function openEditModal(id, name, country) {
    $('#modalTitle').text('Edit State');
    $('#action').val('update_state');
    $('#state_id').val(id);
    $('#state_name').val(name);
    $('#country').val(country);
    $('#stateModal').modal('show');
}

$('#stateForm').on('submit', function(e) {
    e.preventDefault();
    $.post('api/state_city_actions.php', $(this).serialize(), function(res) {
        if (res.success) {
            Swal.fire('Success', res.message, 'success').then(() => location.reload());
        } else {
            Swal.fire('Error', res.message, 'error');
        }
    });
});

function toggleStatus(id) {
    $.post('api/state_city_actions.php', { action: 'toggle_state_status', id: id }, function(res) {
        if (!res.success) Swal.fire('Error', res.message, 'error');
    });
}

function deleteState(id) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this! All cities under this state will also be deleted.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonText: 'No, cancel!',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.post('api/state_city_actions.php', { action: 'delete_state', id: id }, function(res) {
                if (res.success) {
                    Swal.fire('Deleted!', res.message, 'success').then(() => location.reload());
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            });
        }
    });
}

$(document).ready(function() {
    $('#statesTable').DataTable({
        pageLength: 10,
        ordering: true,
        responsive: true
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
