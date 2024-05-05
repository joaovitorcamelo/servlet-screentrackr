document.getElementById('search-button').onclick = function() {
    const query = document.getElementById('explore-search').value;
    if (query !== "") {
        fetch(`http://www.omdbapi.com/?t=${encodeURIComponent(query)}&apikey=4408d32b`)
            .then(response => response.json())
            .then(data => {
                    console.log(data);
                    displayResults(data);
                }
            )
            .catch(error => console.error('Erro ao buscar filmes:', error));
    }
};

function displayResults(film) {
    const resultsDiv = document.getElementById('searchResults');
    resultsDiv.innerHTML = ''; // Clears previous results
    let filmDiv = document.createElement('div');
    filmDiv.innerHTML = `<img src="${film.Poster}" alt="Poster"><span>${film.Title}</span>`;
    filmDiv.onclick = function() {
        showFilmModal(film);
    };
    resultsDiv.appendChild(filmDiv);
    resultsDiv.style.display = 'block';
}

function showFilmModal(film) {
    document.getElementById('filmDetails').innerHTML = `
    <img src="${film.Poster}" alt="Poster">
    <div><h1>${film.Title} (${film.Year})</h1>
    <p>${film.Director}</p>
    <h3>${film.imdbRating} (${film.imdbVotes} votes)</h3>
    <p id="plot">${film.Plot}</p></div>`;
    document.getElementById('filmModal').style.display = 'block';
    document.getElementById('filmId').value = film.imdbID;
    document.getElementById('posterImgUrl').value = film.Poster;

    // Check if the film is already in the session relations
    var isFilmInSession = checkFilmInSession(film.imdbID);
    var submitButton = document.getElementById('add-submit-film');
    var deleteButton = document.getElementById('delete-relation-btn');

    if (isFilmInSession) {
        submitButton.textContent = 'Update';
        deleteButton.style.display = 'inline-block'; // Show delete button if film is in session
    } else {
        submitButton.textContent = 'Add';
        deleteButton.style.display = 'none'; // Hide delete button if film is not in session
    }
}

function checkFilmInSession(filmId) {
    var filmRelations = '<%= new Gson().toJson(filmRelations) %>'; // Serialize the session film relations to JSON
    return filmRelations.some(function(relation) {
        return relation.filmId === filmId;
    });
}


function closeModal() {
    document.getElementById('filmModal').style.display = 'none';
}

function deleteFilmRelation() {
    var filmId = document.getElementById('filmId').value;
    if (!filmId) {
        alert('No film selected for deletion!');
        return;
    }

    fetch('<%= request.getContextPath() %>/FilmRelationServlet', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'filmId=' + filmId
    })
        .then(response => {
            if (response.ok) {
                alert('Film relation deleted successfully!');
                closeModal(); // Fechar o modal após a exclusão
                location.reload(); // Recarregar a página para refletir as mudanças
            } else {
                alert('Failed to delete film relation. Please try again.');
            }
        })
        .catch(error => console.error('Error:', error));
}

