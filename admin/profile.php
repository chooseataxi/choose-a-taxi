<?php 
require_once __DIR__ . '/auth_check.php';
require_once __DIR__ . '/header.php'; 

// Fetch the latest admin data from the database
$stmt = $pdo->prepare("SELECT * FROM admins WHERE id = ?");
$stmt->execute([$adminData['sub']]);
$user = $stmt->fetch();

if (!$user) {
    echo "<div class='alert alert-danger'>User not found.</div>";
    exit;
}
?>

<div class="container-fluid py-4">
    <div class="row">
        <!-- Profile Sidebar -->
        <div class="col-md-4">
            <div class="card card-primary card-outline shadow-sm">
                <div class="card-body box-profile">
                    <div class="text-center position-relative mb-3">
                        <img id="profile-preview" class="profile-user-img img-fluid img-circle shadow-sm"
                             src="<?= !empty($user['profile_picture']) ? $user['profile_picture'] : './src/images/user-avtar.png' ?>"
                             alt="User profile picture"
                             style="width: 150px; height: 150px; object-fit: cover;">
                        
                        <label for="profile_pic_input" class="position-absolute" style="bottom: 0; right: 50%; transform: translateX(75px); cursor: pointer; background: #fff; padding: 6px; border-radius: 50%; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                            <i class="fas fa-camera text-primary"></i>
                            <input type="file" id="profile_pic_input" name="profile_picture" style="display: none;" accept="image/*">
                        </label>
                    </div>

                    <h3 class="profile-username text-center font-weight-bold mb-1"><?= htmlspecialchars($user['name']) ?></h3>
                    <p class="text-muted text-center"><?= htmlspecialchars($user['email']) ?></p>

                    <ul class="list-group list-group-unbordered mb-3 mt-4">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <b>Mobile</b> <span class="text-muted"><?= htmlspecialchars($user['mobile'] ?? 'Not set') ?></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <b>Member Since</b> <span class="text-muted"><?= date('M d, Y', strtotime($user['created_at'])) ?></span>
                        </li>
                    </ul>

                    <button type="button" id="save-pic-btn" class="btn btn-primary btn-block shadow-sm" style="display: none;">
                        <i class="fas fa-save mr-1"></i> Save New Photo
                    </button>
                </div>
            </div>
        </div>

        <!-- Edit Profile Forms -->
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header p-2 bg-white border-bottom">
                    <ul class="nav nav-pills nav-fill" id="profileTabs">
                        <li class="nav-item"><a class="nav-link active" href="#info" data-bs-toggle="tab">Personal Information</a></li>
                        <li class="nav-item"><a class="nav-link" href="#security" data-bs-toggle="tab">Account Security</a></li>
                    </ul>
                </div>
                
                <div class="card-body">
                    <div class="tab-content">
                        <!-- Personal Info Tab -->
                        <div class="active tab-pane" id="info">
                            <form id="profileForm" class="form-horizontal animate__animated animate__fadeIn">
                                <div class="form-group row mb-4">
                                    <label class="col-sm-3 col-form-label font-weight-bold">Full Name</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-user"></i></span></div>
                                            <input type="text" name="name" class="form-control" value="<?= htmlspecialchars($user['name']) ?>" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-4">
                                    <label class="col-sm-3 col-form-label font-weight-bold">Email Address</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-envelope"></i></span></div>
                                            <input type="email" name="email" class="form-control" value="<?= htmlspecialchars($user['email']) ?>" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-4">
                                    <label class="col-sm-3 col-form-label font-weight-bold">Mobile Number</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-phone"></i></span></div>
                                            <input type="text" name="mobile" class="form-control" value="<?= htmlspecialchars($user['mobile']) ?>" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="offset-sm-3 col-sm-9">
                                        <button type="submit" class="btn btn-success px-4 font-weight-bold shadow-sm">
                                            <i class="fas fa-check-circle mr-1"></i> Update Profile
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Security Tab -->
                        <div class="tab-pane" id="security">
                            <form id="passwordForm" class="form-horizontal animate__animated animate__fadeIn">
                                <div class="form-group row mb-4">
                                    <label class="col-sm-3 col-form-label font-weight-bold">Current Password</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-lock"></i></span></div>
                                            <input type="password" name="current_password" class="form-control" placeholder="Required to make changes" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="dropdown-divider mb-4"></div>
                                <div class="form-group row mb-4">
                                    <label class="col-sm-3 col-form-label font-weight-bold">New Password</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-key"></i></span></div>
                                            <input type="password" name="new_password" class="form-control" placeholder="At least 6 characters" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-4">
                                    <label class="col-sm-3 col-form-label font-weight-bold">Confirm Password</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-shield-alt"></i></span></div>
                                            <input type="password" name="confirm_password" class="form-control" placeholder="Repeat new password" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="offset-sm-3 col-sm-9">
                                        <button type="submit" class="btn btn-danger px-4 font-weight-bold shadow-sm">
                                            <i class="fas fa-shield-halved mr-1"></i> Update Password
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Tab switching fix for Bootstrap 5
    $('#profileTabs a').on('click', function (e) {
        e.preventDefault();
        $(this).tab('show');
    });

    // Profile Picture Preview
    $('#profile_pic_input').change(function() {
        const file = this.files[0];
        if (file) {
            let reader = new FileReader();
            reader.onload = function(event) {
                $('#profile-preview').attr('src', event.target.result);
                $('#save-pic-btn').fadeIn();
            }
            reader.readAsDataURL(file);
        }
    });

    // Profile Picture Upload
    $('#save-pic-btn').click(function() {
        const formData = new FormData();
        const fileInput = document.getElementById('profile_pic_input');
        
        if (fileInput.files.length === 0) return;
        formData.append('profile_picture', fileInput.files[0]);

        $.ajax({
            url: 'api/update_profile.php',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            beforeSend: function() {
                $('#save-pic-btn').html('<i class="fas fa-spinner fa-spin"></i> Saving...');
            },
            success: function(response) {
                if (response.success) {
                    Swal.fire('Success', 'Profile picture updated!', 'success');
                    $('#save-pic-btn').hide().html('<i class="fas fa-save mr-1"></i> Save New Photo');
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            }
        });
    });

    // Basic Info Update
    $('#profileForm').on('submit', function(e) {
        e.preventDefault();
        const formData = $(this).serialize();

        $.ajax({
            url: 'api/update_profile.php',
            type: 'POST',
            data: formData,
            beforeSend: function() {
                $('button[type="submit"]', '#profileForm').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Updating...');
            },
            success: function(response) {
                if (response.success) {
                    Swal.fire('Success', 'Profile updated successfully!', 'success');
                    $('.profile-username').text($('input[name="name"]').val());
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            complete: function() {
                $('button[type="submit"]', '#profileForm').prop('disabled', false).html('<i class="fas fa-check-circle mr-1"></i> Update Profile');
            }
        });
    });

    // Password Update
    $('#passwordForm').on('submit', function(e) {
        e.preventDefault();
        const formData = $(this).serialize();

        if ($('input[name="new_password"]').val() !== $('input[name="confirm_password"]').val()) {
            Swal.fire('Error', 'New passwords do not match!', 'error');
            return;
        }

        $.ajax({
            url: 'api/update_password.php',
            type: 'POST',
            data: formData,
            beforeSend: function() {
                $('button[type="submit"]', '#passwordForm').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Updating...');
            },
            success: function(response) {
                if (response.success) {
                    Swal.fire('Success', 'Password updated successfully!', 'success');
                    $('#passwordForm')[0].reset();
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            },
            complete: function() {
                $('button[type="submit"]', '#passwordForm').prop('disabled', false).html('<i class="fas fa-shield-halved mr-1"></i> Update Password');
            }
        });
    });
});
</script>

<?php require_once __DIR__ . '/footer.php'; ?>