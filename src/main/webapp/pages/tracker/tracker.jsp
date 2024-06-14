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

    #filmModal {
      width: 500px;
      height: max-content;
      gap: 5px;
    }

    #filmModal * {
      font-size: 12px;
    }

    #filmModal h2 {
      font-size: 16px;
    }

    #filmDetails {
      flex-direction: column;
      gap: 5px;
    }

    #filmDetails #filmPlot {
      width: 100px;
      text-wrap: normal;
    }

    #filmModal form {
      display: flex;
      flex-direction: column;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    #filmModal form div {
      display: grid;
      grid-template-columns: 1fr 1fr;
      justify-content: center;
      align-items: center;
      gap: 20px;
    }

    .danger-btn {
      background-color: #ff0f0f;
      border: none;
      outline: none;
      padding: 10px 20px;
      border-radius: 3px;
      color: #300000;
      font-size: 1.8rem;
      cursor: pointer;
    }
  </style>
</head>
<body>
<div id="modalOverlay"></div>
<div id="filmModal">
  <div id="filmDetails">
    <img id="filmPoster" alt="Poster" style="height: 180px; aspect-ratio:0.5; display: none;"/>
    <h2 id="filmTitle"></h2>
    <p><strong>Director:</strong> <span id="filmDirector"></span></p>
    <p><strong>Rating:</strong> <span id="filmRating"></span></p>
    <p><strong>Votes:</strong> <span id="filmVotes"></span></p>
    <p><strong>Plot:</strong> <span id="filmPlot"></span></p>
  </div>
  <form id="updateFilmForm">
    <input type="hidden" id="filmId" name="filmId" value="">
    <div>
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
          <li><span class="material-symbols-outlined">logout</span><a href="../login/login.jsp" id="logout-button"><span>Logout</span></a></li>
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

  // Função para exibir os filmes nas categorias apropriadas e adicionar evento de clique para abrir o modal
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
      img.alt = relation.title;
      img.setAttribute('data-film-id', relation.filmId); // Adiciona o ID do filme como data attribute
      listItem.appendChild(img);

      // Adiciona o evento de clique para abrir o modal
      img.addEventListener('click', () => openFilmModal(relation.filmId));

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

  // Função para abrir o modal e buscar detalhes do filme
  function openFilmModal(filmId) {
    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;

    if (!userId) {
      console.error('User ID not found');
      return;
    }

    // Faz a requisição para obter os detalhes do filme
    fetch('${pageContext.request.contextPath}/FilmDetailsServlet?userId=' + userId + '&filmId=' + filmId)
            .then(response => response.json())
            .then(data => {
              console.log('Film details:', data);
              populateFilmModalExisting(data);
              showModal();
            })
            .catch(error => {
              console.error('Error fetching film details:', error);
            });
  }

  // Função para preencher o modal com os dados do filme
  function populateFilmModalExisting(film) {
    // Preenchendo os elementos do modal com os dados do filme
    document.getElementById('filmTitle').textContent = (film.title + '(' + film.year + ')');
    document.getElementById('filmDirector').textContent = film.director;
    document.getElementById('filmRating').textContent = film.rating;
    document.getElementById('filmVotes').textContent = film.votes;
    document.getElementById('filmPlot').textContent = film.plot;

    const filmPoster = document.getElementById('filmPoster');
    if (film.posterImgUrl) {
      filmPoster.src = film.posterImgUrl;
      filmPoster.style.display = 'block';
    } else {
      filmPoster.style.display = 'none';
    }

    // Preenchendo os campos do formulário com os dados do filme
    document.getElementById('filmId').value = film.filmId || '';
    document.getElementById('favoriteCheckbox').checked = film.isFavorite || false;
    document.getElementById('relationType').value = film.relationType || 'watching';
    document.getElementById(`delete-relation-btn`).style.display = 'block';
    document.getElementById(`update-submit-film`).innerText = 'Update';
  }

  // Função para mostrar o modal
  function showModal() {
    document.getElementById('filmModal').style.display = 'block';
    document.getElementById('modalOverlay').style.display = 'block';
  }

  // Função para fechar o modal
  function closeModal() {
    document.getElementById('filmModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
  }

  // Função para deletar a relação do filme
  document.getElementById('delete-relation-btn').addEventListener('click', deleteFilmRelation);

  function deleteFilmRelation() {
    const filmId = document.getElementById('filmId').value;
    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;

    if (!userId) {
      console.error('User ID not found');
      return;
    }

    // Use a URL com query parameters para enviar dados com o método DELETE
    fetch('${pageContext.request.contextPath}/DeleteFilmRelationServlet?userId=' + userId + '&filmId=' + filmId, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json'
      }
    })
            .then(response => {
              // Verificar se a resposta é ok (status 200-299)
              if (!response.ok) {
                throw new Error('Error while deleting film relation');
              }
              return response.json(); // Tentar analisar como JSON
            })
            .then(data => {
              if (data.status === 'success') {
                alert('Film relation deleted successfully');
                closeModal();
                fetchUserFilms(); // Atualiza a lista de filmes
              } else {
                alert('Error deleting film relation: ' + data.message);
              }
            })
            .catch(error => {
              console.error('Error deleting film relation:', error);
              // Exibir mensagem de erro específica se a resposta não for JSON
              alert('Error deleting film relation. Please check the server logs.');
            });
  }

  // Função para atualizar a relação do filme
  document.getElementById('updateFilmForm').addEventListener('submit', updateFilmRelation);

  function updateFilmRelation(event) {
    event.preventDefault();

    const filmId = document.getElementById('filmId').value;
    const relationType = document.getElementById('relationType').value;
    const isFavorite = document.getElementById('favoriteCheckbox').checked;
    const userData = JSON.parse(localStorage.getItem('userData'));
    const userId = userData ? userData.userId : null;

    if (!userId) {
      console.error('User ID not found');
      return;
    }

    // Construa a URL com parâmetros de consulta
    const url = '${pageContext.request.contextPath}/UpdateFilmRelationServlet?userId=' + userId + '&filmId=' + filmId + '&relationType=' + relationType + '&isFavorite=' + isFavorite;

    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    })
            .then(response => {
              if (!response.ok) {
                throw new Error('Error while updating film relation');
              }
              return response.json(); // Tentar analisar como JSON
            })
            .then(data => {
              if (data.status === 'success') {
                alert('Film relation updated successfully');
                closeModal();
                fetchUserFilms(); // Atualiza a lista de filmes
              } else {
                alert('Error updating film relation: ' + data.message);
              }
            })
            .catch(error => {
              console.error('Error updating film relation:', error);
              alert('Error updating film relation. Please check the server logs.');
            });
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
        populateFilmModalNew(result)
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

  // Chama a função ao carregar a página
  document.addEventListener('DOMContentLoaded', fetchUserFilms);
</script>
</body>
</html>
