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
    document.getElementById('filmId').value = film.imdbID; // Set the hidden input field value
}

function closeModal() {
    document.getElementById('filmModal').style.display = 'none';
}


document.addEventListener("DOMContentLoaded", function() {
    fetchRelationsAndUpdateUI();

    function fetchRelationsAndUpdateUI() {
        fetch('/api/relations')  // Adjust URL to your actual API endpoint
            .then(response => response.json()).then(relations => {
            updateSections(relations);
        })
            .catch(error => console.error('Error loading film relations:', error));
    }

    function updateSections(relations) {
        const sections = {
            'watching': document.getElementById('currently-list'),
            'watchlist': document.getElementById('watchlist-list'),
            'watched': document.getElementById('watched-list'),
            'cancelled': document.getElementById('cancelled-list')
        };

        for (const relation of relations) {
            const listItem = document.createElement('li');
            fetchPoster(relation.filmId)
                .then(posterUrl => {
                    listItem.innerHTML = `<img src="${posterUrl}" alt="Poster">`;
                    sections[relation.relationType].appendChild(listItem);
                });
        }
    }

    function fetchPoster(filmId) {
        return fetch(`http://www.omdbapi.com/?i=${filmId}&apikey=4408d32b`)
            .then(response => response.json())
            .then(data => data.Poster);
    }
});