<?php
require_once __DIR__ . '/../auth_check.php';
require_once __DIR__ . '/../header.php';

$page_title = "Partner Management";
?>

<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark fw-bold"><i class="fas fa-handshake me-2"></i>Partner Management</h1>
            </div>
            <div class="col-sm-6 text-end">
                <a href="add-partner.php" class="btn btn-primary px-4 shadow-sm rounded-pill">
                    <i class="fas fa-plus-circle me-1"></i> Add New Partner
                </a>
            </div>
        </div>
    </div>
</div>

<div class="content">
    <div class="container-fluid">
        <div class="card shadow-sm border-0 rounded-4">
            <div class="card-body">
                <div class="table-responsive">
                    <table id="partnersTable" class="table table-hover align-middle">
                        <thead class="bg-light">
                            <tr>
                                <th width="40">ID</th>
                                <th>Partner Name</th>
                                <th>Contact</th>
                                <th>Verification</th>
                                <th width="120" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Data loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .table th { border-top: none !important; font-size: 0.85rem; text-transform: uppercase; color: #666; letter-spacing: 0.5px; }
    .btn-white { background: #fff; border: 1px solid #efefef; }
    .btn-white:hover { background: #f8f9fa; }
    .status-toggle { width: 40px !important; height: 20px !important; cursor: pointer; }
    .dataTables_wrapper .dataTables_paginate .paginate_button { margin-top: 10px; }
    .hover-primary:hover { color: #0d6efd !important; text-decoration: underline; }
    /* Make DataTables search blend with Bootstrap */
    .dataTables_filter input { border-radius: 20px !important; padding-left: 15px !important; border: 1px solid #ced4da !important; }
    .dataTables_filter input:focus { border-color: #86b7fe !important; box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25) !important; }
    .dataTables_wrapper .dataTables_length select { border-radius: 6px !important; border: 1px solid #ced4da !important; }
</style>

<!-- DataTables Scripts -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>

<script>
$(document).ready(function() {
    // Initialize DataTable with server-side processing
    var table = $('#partnersTable').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: 'api/partner_list_data.php',
            type: 'GET',
            error: function(xhr, error, thrown) {
                console.error('DataTables server error:', error, thrown);
                // Show user-friendly message in the table
                $('#partnersTable tbody').html(
                    '<tr><td colspan="5" class="text-center py-5">' +
                    '<i class="fas fa-exclamation-triangle fa-3x text-danger mb-3"></i>' +
                    '<h5 class="text-muted">Failed to load partners</h5>' +
                    '<p class="text-muted small">Please refresh the page or try again later.</p>' +
                    '</td></tr>'
                );
            }
        },
        pageLength: 10,
        lengthMenu: [10, 25, 50, 100],
        ordering: true,
        order: [[0, 'desc']],
        responsive: true,
        autoWidth: false,
        // Define which columns map to which data fields from the API response
        columns: [
            { data: 'id' },
            {
                data: null,
                orderable: true,
                render: function(data, type, row) {
                    if (type === 'display') {
                        return '<div class="d-flex align-items-center">' +
                            '<div class="rounded-circle shadow-sm text-center d-flex align-items-center justify-content-center me-3 border overflow-hidden" style="width:40px; height:40px; background-color: #f8f9fa; flex-shrink: 0;">' +
                            row.avatar_html +
                            '</div>' +
                            '<div>' +
                            '<a href="view-partner.php?id=' + row.id_raw + '" class="text-decoration-none">' +
                            '<h6 class="mb-0 fw-bold text-dark hover-primary">' + row.full_name + '</h6>' +
                            '</a>' +
                            '</div>' +
                            '</div>';
                    }
                    return row.full_name;
                }
            },
            {
                data: null,
                orderable: true,
                render: function(data, type, row) {
                    if (type === 'display') {
                        return '<div class="small">' +
                            '<i class="fas fa-phone-alt text-muted me-1"></i> <span class="fw-semibold text-dark">+91 ' + row.mobile + '</span><br>' +
                            '<i class="fas fa-envelope text-muted me-1"></i> <span class="text-muted">' + row.email + '</span>' +
                            '</div>';
                    }
                    return row.mobile + ' ' + row.email;
                }
            },
            {
                data: 'verification_badge',
                orderable: true,
                render: function(data, type, row) {
                    if (type === 'display' || type === 'filter') {
                        return row.verification_badge;
                    }
                    return row.manual_verification_status;
                }
            },
            {
                data: null,
                orderable: false,
                className: 'text-center',
                render: function(data, type, row) {
                    if (type === 'display') {
                        return '<div class="btn-group shadow-sm">' +
                            '<a href="view-partner.php?id=' + row.id_raw + '" class="btn btn-white btn-sm" title="View Partner Details"><i class="fas fa-eye text-info"></i></a>' +
                            '<a href="edit-partner.php?id=' + row.id_raw + '" class="btn btn-white btn-sm" title="Edit & Verify Partner"><i class="fas fa-edit text-primary"></i></a>' +
                            '<button class="btn btn-white btn-sm delete-btn" data-id="' + row.id_raw + '" title="Delete Partner"><i class="fas fa-trash-alt text-danger"></i></button>' +
                            '</div>';
                    }
                    return '';
                }
            }
        ],
        // Custom message when no records match
        language: {
            emptyTable: '<div class="text-center py-5">' +
                '<div class="mb-3"><i class="fas fa-users-slash fa-4x text-light"></i></div>' +
                '<h5 class="text-muted fw-bold">No partners registered yet</h5>' +
                '<p class="text-muted small">Start adding driving partners to expand your network.</p>' +
                '</div>',
            zeroRecords: '<div class="text-center py-5">' +
                '<div class="mb-3"><i class="fas fa-search fa-4x text-light"></i></div>' +
                '<h5 class="text-muted fw-bold">No matching partners found</h5>' +
                '<p class="text-muted small">Try adjusting your search criteria.</p>' +
                '</div>',
            loadingRecords: '<div class="text-center py-4"><i class="fas fa-spinner fa-spin fa-2x text-primary"></i><p class="text-muted mt-2">Loading partners...</p></div>',
            processing: '<div class="text-center py-2"><i class="fas fa-spinner fa-spin text-primary"></i> Processing...</div>',
            search: '<i class="fas fa-search"></i>',
            searchPlaceholder: 'Search partners...',
            lengthMenu: 'Show _MENU_ entries',
            info: 'Showing _START_ to _END_ of _TOTAL_ partners',
            infoEmpty: 'Showing 0 partners',
            infoFiltered: '(filtered from _MAX_ total)',
            paginate: {
                first: '<i class="fas fa-angle-double-left"></i>',
                previous: '<i class="fas fa-angle-left"></i>',
                next: '<i class="fas fa-angle-right"></i>',
                last: '<i class="fas fa-angle-double-right"></i>'
            }
        },
        // Draw callback — rebind events for dynamically loaded rows
        drawCallback: function(settings) {
            // Any post-draw actions if needed
        },
        // Pre-init: add a loading skeleton
        preDrawCallback: function(settings) {
            // Optional: could show spinner here
        },
        // Init complete — hide any loading states
        initComplete: function(settings, json) {
            // Move the search input and add a nice wrapper
            $('.dataTables_filter input').attr('placeholder', 'Search by name, mobile or email...');
        }
    });

    // ===== DELETE ACTION (event delegation for dynamic rows) =====
    $('#partnersTable tbody').on('click', '.delete-btn', function() {
        const id = $(this).data('id');
        Swal.fire({
            title: 'Delete this partner?',
            text: "This will permanently remove the partner account and associated documents.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.post('api/partner_actions.php', { action: 'delete', id: id }, function(res) {
                    if (res.success) {
                        Swal.fire('Deleted!', res.message, 'success').then(() => {
                            table.ajax.reload(null, false); // Reload without resetting pagination
                        });
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                });
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/../footer.php'; ?>
