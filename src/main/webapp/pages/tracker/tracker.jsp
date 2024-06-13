<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
  <link rel="stylesheet" href="../../index.css" />
  <link rel="stylesheet" href="tracker.css" />
  <title>screentrackr - Tracker</title>
  <style>
    .material-symbols-outlined {
      font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    }
  </style>
</head>
<body>
<div id="filmModal">
  <div id="filmDetails"></div>
  <form method="post" action="<%= request.getContextPath() %>/FilmRelationServlet">
    <input type="hidden" id="filmId" name="filmId" value="">
    <input type="hidden" id="favorite" name="favorite" value="false">
    <input type="hidden" id="posterImgUrl" name="posterImgUrl" value="">
    <select id="relationType" name="relationType">
      <option value="watching">Watching</option>
      <option value="watchlist">Watchlist</option>
      <option value="watched">Watched</option>
      <option value="cancelled">Cancelled</option>
    </select>
    <button type="submit" class="primary-btn" id="add-submit-film">Add</button>
  </form>
  <span id="close-btn" onclick="closeModal()" class="material-symbols-outlined">close</span>
</div>

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
  <section id="currently-watching" class="tracker-section">
    <h1 class="section-header">Currently Watching</h1>
    <ul id="currently-list" class="tracker-list">
      <!-- Conteúdo será adicionado pelo JavaScript -->
    </ul>
  </section>

  <section id="watchlist" class="tracker-section">
    <h1 class="section-header">Watchlist</h1>
    <ul id="watchlist-list" class="tracker-list">
      <!-- Conteúdo será adicionado pelo JavaScript -->
    </ul>
  </section>

  <section id="watched" class="tracker-section">
    <h1 class="section-header">Watched</h1>
    <ul id="watched-list" class="tracker-list">
      <!-- Conteúdo será adicionado pelo JavaScript -->
    </ul>
  </section>

  <section id="cancelled" class="tracker-section">
    <h1 class="section-header">Cancelled</h1>
    <ul id="cancelled-list" class="tracker-list">
      <!-- Conteúdo será adicionado pelo JavaScript -->
    </ul>
  </section>
</main>
<script src="../../scripts/dropdown.js"></script>
<script src="tracker.js"></script>
<script>
  // Função para buscar os filmes do usuário e exibir nas respectivas categorias
  function fetchUserFilms() {
    // Recupera o userData do localStorage e extrai o userId
    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;

    if (!userId) {
      console.error('User ID not found');
      return;
    }

    // Faz a requisição ao servlet para obter os filmes do usuário
    fetch('${pageContext.request.contextPath}/LoadUserFilmsServlet?userId=' + userId)
            .then(response => response.json())
            .then(data => {
              console.log('Received films:', data);
              localStorage.setItem('filmRelations', JSON.stringify(data)); // Salva no localStorage
              displayFilms(data); // Exibe os filmes nas categorias apropriadas
            })
            .catch(error => {
              console.error('Error fetching films:', error);
            });
  }

  // Função para exibir os filmes nas categorias apropriadas
  function displayFilms(filmRelations) {
    const currentlyList = document.getElementById('currently-list');
    const watchlistList = document.getElementById('watchlist-list');
    const watchedList = document.getElementById('watched-list');
    const cancelledList = document.getElementById('cancelled-list');

    // Limpa as listas existentes
    currentlyList.innerHTML = '';
    watchlistList.innerHTML = '';
    watchedList.innerHTML = '';
    cancelledList.innerHTML = '';

    // Adiciona os filmes nas respectivas listas
    filmRelations.forEach(relation => {
      const listItem = document.createElement('li');
      const img = document.createElement('img');
      img.src = relation.posterImgUrl;
      img.alt = 'Poster';
      listItem.appendChild(img);

      switch(relation.relationType) {
        case 'watching':
          currentlyList.appendChild(listItem);
          break;
        case 'watchlist':
          watchlistList.appendChild(listItem);
          break;
        case 'watched':
          watchedList.appendChild(listItem);
          break;
        case 'cancelled':
          cancelledList.appendChild(listItem);
          break;
      }
    });
  }

  // Chama a função ao carregar a página
  document.addEventListener('DOMContentLoaded', fetchUserFilms);
</script>
</body>
</html>
