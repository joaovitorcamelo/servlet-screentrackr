<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <link rel="stylesheet" href="../../index.css" />
  <link rel="stylesheet" href="profile.css" />
  <title>screentrackr - Profile</title>
  <style>
    .material-symbols-outlined {
      font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    }

    .edit-profile-button {
      position: absolute;
      top: 10px;
      right: 10px;
      padding: 8px 16px;
      background-color: #007bff;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      text-decoration: none;
      font-size: 14px;
    }

    #profile-content button {
      margin-top: 10px;
      padding: 10px 20px;
      background-color: #28a745;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    #modalOverlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 500;
    }

    #profileModal {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.5);
      padding: 20px;
      z-index: 1000;
      width: 300px;
    }

    .btn-container {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }

    .close-btn, .update-btn {
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    .close-btn {
      background-color: #dc3545;
      color: #fff;
    }

    .update-btn {
      background-color: #007bff;
      color: #fff;
    }
  </style>
</head>

<body>
<header id="logged-header">
  <ul id="header-list">
    <li><a href="../tracker/tracker.jsp">Tracker</a></li>
    <li><a href="../profile/profile.jsp">Profile</a></li>
  </ul>
  <img src="../../assets/screentrackr.svg" alt="screentrackr" />
  <div>
    <div class="input-with-icon">
      <span class="material-symbols-outlined" id="search-button">search</span>
      <input type="text" id="explore-search" placeholder="Search" />
      <div id="searchResults" class="search-results"></div>
    </div>

    <div id="dropdown-menu">
      <span class="material-symbols-outlined" id="settings-icon">settings</span>
      <div id="dropdown-background">
        <ul id="dropdown-body">
          <li><span class="material-symbols-outlined">edit</span><a href="../edit_profile/edit_profile.html"><span>Edit profile</span></a></li>
          <li><span class="material-symbols-outlined">logout</span><a href="../login/login.jsp"><span>Logout</span></a></li>
        </ul>
      </div>
    </div>
  </div>
</header>

<main>
  <a href="../edit_profile/edit_profile.html" class="edit-profile-button">Edit Profile</a>
  <div id="profile-content"></div>
</main>

<!-- Modal -->
<div id="modalOverlay"></div>
<div id="profileModal">
  <h2>Edit Profile</h2>
  <form id="updateProfileForm">
    <div>
      <label for="userName">Name:</label>
      <input type="text" id="userName" name="name" required>
    </div>
    <div>
      <label for="userBio">Bio:</label>
      <textarea id="userBio" name="bio" required></textarea>
    </div>
    <div class="btn-container">
      <button type="button" class="close-btn" onclick="closeModal()">Close</button>
      <button type="submit" class="update-btn">Update</button>
    </div>
  </form>
</div>

<script>
  document.addEventListener("DOMContentLoaded", getUserData);

  function getUserData() {
    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;

    if (userId) {
      fetch('${pageContext.request.contextPath}/GetUserProfileServlet?userId=' + userId )
              .then(response => response.json())
              .then(data => {
                const profileContent = document.getElementById('profile-content');
                profileContent.innerHTML =
                        '<div>' +
                        '<h2>' + data.name + '</h2>' +
                        '<p>' + data.bio + '</p>' +
                        '<button onclick="openModal()">Edit Profile</button>' +
                        '</div>';
                // Preencher inputs do modal
                document.getElementById('userName').value = data.name;
                document.getElementById('userBio').value = data.bio;
              })
              .catch(error => console.error('Error fetching profile data:', error));
    } else {
      console.error('No userId found in localStorage');
    }
  }

  function openModal() {
    document.getElementById('modalOverlay').style.display = 'block';
    document.getElementById('profileModal').style.display = 'block';
  }

  function closeModal() {
    document.getElementById('modalOverlay').style.display = 'none';
    document.getElementById('profileModal').style.display = 'none';
  }

  document.getElementById('updateProfileForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;
    const name = document.getElementById('userName').value;
    const bio = document.getElementById('userBio').value;

    if (userId) {
      fetch('${pageContext.request.contextPath}/UpdateUserProfileServlet?userId=' + userId + '&name=' + name + '&bio=' + bio, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      })
              .then(response => response.json())
              .then(data => {
                if (data.status == 'success') {
                  getUserData();
                  closeModal();
                } else {
                  console.error('Error updating profile:', data.message);
                }
              })
              .catch(error => console.error('Error updating profile:', error));
    } else {
      console.error('No userId found in localStorage');
    }
  });
</script>
</body>
</html>
