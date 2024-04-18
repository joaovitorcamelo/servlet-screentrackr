document.getElementById('search-button').onclick = function() {
    const query = document.getElementById('explore-search').value;
    if(query !== "") {
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
    resultsDiv.innerHTML = ''; // Limpa os resultados anteriores
    let filmDiv = document.createElement('div');
    filmDiv.innerHTML = `<img src="${film.Poster}" alt="Poster"><span>${film.Title}</span>`;
    filmDiv.onclick = function() {
        showFilmModal(film);
    };
    resultsDiv.appendChild(filmDiv);
    resultsDiv.style.display = 'block';}

function showFilmModal(film) {
    document.getElementById('filmDetails').innerHTML = `
    <img src="${film.Poster}" alt="Poster">
    <div><h1>${film.Title} (${film.Year})</h1>
    <p>${film.Director}</p>
    <h3>${film.imdbRating} (${film.imdbVotes} votes)</h3>
    <p id="plot">${film.Plot}</p></div>`;
    document.getElementById('filmModal').style.display = 'block';
    window.selectedFilmId = film.imdbID; // Store selected film ID for later use
}

function closeModal() {
    document.getElementById('filmModal').style.display = 'none';
}