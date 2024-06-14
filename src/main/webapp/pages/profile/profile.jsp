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

    #modalOverlay-edit {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 500;
    }

    #profileModal-edit {
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

    .btn-container-edit {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }

    .close-btn-edit, .update-btn-edit {
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    .close-btn-edit {
      background-color: #dc3545;
      color: #fff;
    }

    .update-btn-edit {
      background-color: #007bff;
      color: #fff;
    }

    #filmModal {
      display: none; /* Modal escondido inicialmente */
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
    #filmDetails {
      margin-bottom: 20px;
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
    .primary-btn {
      margin-right: 10px;
    }
    .danger-btn {
      background-color: red;
      color: white;
      border: none;
      padding: 10px;
      border-radius: 4px;
    }
    .btn-container {
      display: flex;
      justify-content: space-between;
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
          <li><span class="material-symbols-outlined">logout</span><a href="../login/login.jsp" id="logout-button"><span>Logout</span></a></li>
        </ul>
      </div>
    </div>
  </div>
</header>

<main>
  <a href="../edit_profile/edit_profile.html" class="edit-profile-button">Edit Profile</a>
  <div id="profile-content"></div>
</main>
<div id="modalOverlay"></div>
<div id="filmModal">
  <div id="filmDetails">
    <h2 id="filmTitle"></h2>
    <p><strong>Director:</strong> <span id="filmDirector"></span></p>
    <p><strong>Rating:</strong> <span id="filmRating"></span></p>
    <p><strong>Votes:</strong> <span id="filmVotes"></span></p>
    <p><strong>Plot:</strong> <span id="filmPlot"></span></p>
    <img id="filmPoster" alt="Poster" style="width: 200px; display: none;"/>
  </div>
  <form id="updateFilmForm">
    <input type="hidden" id="filmId" name="filmId" value="">
    <div>
      <label for="relationType">Relation Type:</label>
      <select id="relationType" name="relationType">
        <option value="watching">Watching</option>
        <option value="watchlist">Watchlist</option>
        <option value="watched">Watched</option>
        <option value="cancelled">Cancelled</option>
      </select>
      <label for="favoriteCheckbox">
        <input type="checkbox" id="favoriteCheckbox"> Favorite
      </label>
    </div>
    <div class="btn-container">
      <button type="button" class="danger-btn" id="delete-relation-btn">Delete</button>
      <button type="submit" class="primary-btn" id="update-submit-film">Update</button>
    </div>
  </form>
  <span id="close-btn" onclick="closeModalFilm()" class="material-symbols-outlined">close</span>
</div>
<!-- Modal -->
<div id="modalOverlay-edit"></div>
<div id="profileModal-edit">
  <h2>Edit Profile</h2>
  <form id="updateProfileForm-edit">
    <div>
      <label for="userName-edit">Name:</label>
      <input type="text" id="userName-edit" name="name" required>
    </div>
    <div>
      <label for="userBio-edit">Bio:</label>
      <textarea id="userBio-edit" name="bio" required></textarea>
    </div>
    <div class="btn-container-edit">
      <button type="button" class="close-btn-edit" onclick="closeModalEdit()">Close</button>
      <button type="submit" class="update-btn-edit">Update</button>
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
                document.getElementById('userName-edit').value = data.name;
                document.getElementById('userBio-edit').value = data.bio;
              })
              .catch(error => console.error('Error fetching profile data:', error));
    } else {
      console.error('No userId found in localStorage');
    }
  }

  function openModal() {
    document.getElementById('modalOverlay-edit').style.display = 'block';
    document.getElementById('profileModal-edit').style.display = 'block';
  }

  function closeModalEdit() {
    document.getElementById('modalOverlay-edit').style.display = 'none';
    document.getElementById('profileModal-edit').style.display = 'none';
  }

  document.getElementById('updateProfileForm-edit').addEventListener('submit', function(event) {
    event.preventDefault();

    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;
    const name = document.getElementById('userName-edit').value;
    const bio = document.getElementById('userBio-edit').value;

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
                  closeModalEdit();
                } else {
                  console.error('Error updating profile:', data.message);
                }
              })
              .catch(error => console.error('Error updating profile:', error));
    } else {
      console.error('No userId found in localStorage');
    }
  });

  function showModal() {
    document.getElementById('filmModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
  }

  function closeModalFilm() {
    document.getElementById('filmModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
  }

  document.getElementById('explore-search').addEventListener('input', function () {
    let query = this.value.trim();

    if (query.length > 2) {
      searchMovies(query);
    } else {
      clearSearchResults();
    }
  });

  function searchMovies(query) {
    const url = 'http://www.omdbapi.com/?t=' + query +  '&apikey=4408d32b';

    fetch(url)
            .then(response => response.json())
            .then(data => {
              if (data.Response === "True") {
                displaySearchResults([data]);
              } else {
                clearSearchResults();
              }
            })
            .catch(error => console.error('Erro ao buscar dados:', error));
  }

  function displaySearchResults(results) {
    const searchResultsContainer = document.getElementById('searchResults');
    searchResultsContainer.innerHTML = '';

    results.forEach(result => {
      const item = document.createElement('div');
      item.classList.add('result-item');

      // Concatenação de strings tradicional
      item.innerHTML =
              '<img src="' + result.Poster + '" alt="' + result.Title + '" style="width: 50px; height: auto; margin-right: 10px;">' +
              '<div>' +
              '<strong>' + result.Title + '</strong> (' + result.Year + ')' +
              '<p>' + result.Plot + '</p>' +
              '</div>';

      searchResultsContainer.appendChild(item);

      item.addEventListener('click', () => {
        populateFilmModalNew(result);
        showModal();
      });
    });

    searchResultsContainer.style.display = 'block';
  }

  function populateFilmModalNew(film) {
    // Preenchendo os elementos do modal com os dados do filme
    document.getElementById('filmTitle').textContent = (film.Title + '(' + film.Year + ')');
    document.getElementById('filmDirector').textContent = film.Director;
    document.getElementById('filmRating').textContent = film.imdbRating;
    document.getElementById('filmVotes').textContent = film.imdbVotes;
    document.getElementById('filmPlot').textContent = film.Plot;

    const filmPoster = document.getElementById('filmPoster');
    if (film.Poster) {
      filmPoster.src = film.Poster;
      filmPoster.style.display = 'block';
    } else {
      filmPoster.style.display = 'none';
    }

    // Preenchendo os campos do formulário com os dados do filme
    document.getElementById('filmId').value = film.imdbId || '';
    document.getElementById('favoriteCheckbox').checked = false;
    document.getElementById('relationType').value = 'watching';
    document.getElementById(`delete-relation-btn`).style.display = 'none';
    document.getElementById(`update-submit-film`).innerText = 'Add';

  }

  function clearSearchResults() {
    const searchResultsContainer = document.getElementById('searchResults');
    searchResultsContainer.innerHTML = '';
    searchResultsContainer.style.display = 'none';
  }

  // Função para ocultar o dropdown quando clicar fora dele
  document.addEventListener('click', function (event) {
    const searchResultsContainer = document.getElementById('searchResults');
    if (!searchResultsContainer.contains(event.target) && event.target.id !== 'explore-search') {
      clearSearchResults();
    }
  });

  // Função de logout
  function logout() {
    localStorage.clear();
    window.location.href = "../login/login.jsp";
  }

  document.getElementById('logout-button').addEventListener('click', function(event) {
    event.preventDefault();
    logout();
  });
</script>
<script src="../../scripts/dropdown.js"></script>
</body>
</html>
