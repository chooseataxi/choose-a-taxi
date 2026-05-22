<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

// Ensure tables exist before fetching
require_once __DIR__ . '/api/state_city_actions.php'; 

// Fetch states for the dropdown
$states = $pdo->query("SELECT id, name FROM states WHERE status = 'Active' ORDER BY name ASC")->fetchAll();

// Fetch cities joined with state name
$cities = $pdo->query("
    SELECT c.*, s.name as state_name 
    FROM cities c 
    JOIN states s ON c.state_id = s.id 
    ORDER BY c.name ASC
")->fetchAll();
?>

<div class="container-fluid py-4">
    <div class="card shadow mb-4 border-0">
        <div class="card-header bg-white py-3 d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold text-dark">City Management</h5>
            <button class="btn btn-yellow-black shadow-sm px-4 ms-auto" data-bs-toggle="modal" data-bs-target="#cityModal" onclick="openAddModal()">
                <i class="fas fa-plus mr-1"></i> Add City
            </button>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive p-3">
                <table id="citiesTable" class="table table-hover align-middle">
                    <thead class="bg-light">
                        <tr>
                            <th width="50">#</th>
                            <th>City Name</th>
                            <th>State</th>
                            <th>Status</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($cities as $idx => $city): ?>
                        <tr>
                            <td><?= $idx + 1 ?></td>
                            <td class="font-weight-bold"><?= htmlspecialchars($city['name']) ?></td>
                            <td><span class="badge bg-secondary"><?= htmlspecialchars($city['state_name']) ?></span></td>
                            <td>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" <?= $city['status'] === 'Active' ? 'checked' : '' ?> onchange="toggleStatus(<?= $city['id'] ?>)">
                                </div>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary me-2" onclick="openEditModal(<?= $city['id'] ?>, '<?= htmlspecialchars(addslashes($city['name'])) ?>', <?= $city['state_id'] ?>)">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-outline-danger" onclick="deleteCity(<?= $city['id'] ?>)">
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

<!-- City Modal -->
<div class="modal fade" id="cityModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="cityForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Add City</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="city_id" name="id">
                    <input type="hidden" id="action" name="action" value="add_city">
                    
                    <div class="mb-3">
                        <label>City Name</label>
                        <input type="text" class="form-control" id="city_name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label>Select State</label>
                        <select class="form-control" id="state_id" name="state_id" required>
                            <option value="">-- Select State --</option>
                            <?php foreach ($states as $state): ?>
                                <option value="<?= $state['id'] ?>"><?= htmlspecialchars($state['name']) ?></option>
                            <?php endforeach; ?>
                        </select>
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
    $('#modalTitle').text('Add City');
    $('#action').val('add_city');
    $('#city_id').val('');
    $('#city_name').val('');
    $('#state_id').val('');
}

function openEditModal(id, name, state_id) {
    $('#modalTitle').text('Edit City');
    $('#action').val('update_city');
    $('#city_id').val(id);
    $('#city_name').val(name);
    $('#state_id').val(state_id);
    $('#cityModal').modal('show');
}

$('#cityForm').on('submit', function(e) {
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
    $.post('api/state_city_actions.php', { action: 'toggle_city_status', id: id }, function(res) {
        if (!res.success) Swal.fire('Error', res.message, 'error');
    });
}

function deleteCity(id) {
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonText: 'No, cancel!',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            $.post('api/state_city_actions.php', { action: 'delete_city', id: id }, function(res) {
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
    $('#citiesTable').DataTable({
        pageLength: 10,
        ordering: true,
        responsive: true
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
