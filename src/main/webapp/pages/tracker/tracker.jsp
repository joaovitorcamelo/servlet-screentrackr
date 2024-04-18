<%@ page import="java.util.List" %>
<%@ page import="com.screentrackr.screentrackr.model.UserFilmRelation" %>
<%
  List<UserFilmRelation> filmRelations = (List<UserFilmRelation>) session.getAttribute("filmRelations");
%>
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
    <input type="hidden" id="posterImgUrl" name="posterImgUrl" value=""> <!-- Adicione este campo hidden para a URL do pôster -->

    <select id="relationType" name="relationType">
      <option value="watching">Watching</option>
      <option value="watchlist">Watchlist</option>
      <option value="watched">Watched</option>
      <option value="cancelled">Cancelled</option>
    </select>
    <button type="submit" class="primary-btn">Add</button>
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
          <li><span class="material-symbols-outlined">logout</span><span>Logout</span></li>
        </ul>
      </div>
    </div>
  </div>
</header>
<main>
  <section id="currently-watching" class="tracker-section">
    <h1 class="section-header">Currently Watching</h1>
    <ul id="currently-list" class="tracker-list">
      <%
        if (filmRelations != null && !filmRelations.isEmpty()) {
          for (UserFilmRelation relation : filmRelations) {
            if ("watching".equals(relation.getRelationType())) {
              out.println("<li><img src='" + relation.getPosterImgUrl() + "' alt='Poster'></li>");
            }
          }
        } else {
          out.println("No films currently being watched.");
        }
      %>
    </ul>
  </section>

  <section id="watchlist" class="tracker-section">
    <h1 class="section-header">Watchlist</h1>
    <ul id="watchlist-list" class="tracker-list">
      <%
        if (filmRelations != null && !filmRelations.isEmpty()) {
          for (UserFilmRelation relation : filmRelations) {
            if ("watchlist".equals(relation.getRelationType())) {
              out.println("<li><img src='" + relation.getPosterImgUrl() + "' alt='Poster'></li>");
            }
          }
        } else {
          out.println("No films in the watchlist.");
        }
      %>
    </ul>
  </section>

  <section id="watched" class="tracker-section">
    <h1 class="section-header">Watched</h1>
    <ul id="watched-list" class="tracker-list">
      <%
        if (filmRelations != null && !filmRelations.isEmpty()) {
          for (UserFilmRelation relation : filmRelations) {
            if ("watched".equals(relation.getRelationType())) {
              out.println("<li><img src='" + relation.getPosterImgUrl() + "' alt='Poster'></li>");
            }
          }
        } else {
          out.println("No films watched.");
        }
      %>
    </ul>
  </section>

  <section id="cancelled" class="tracker-section">
    <h1 class="section-header">Cancelled</h1>
    <ul id="cancelled-list" class="tracker-list">
      <%
        if (filmRelations != null && !filmRelations.isEmpty()) {
          for (UserFilmRelation relation : filmRelations) {
            if ("cancelled".equals(relation.getRelationType())) {
              out.println("<li><img src='" + relation.getPosterImgUrl() + "' alt='Poster'></li>");
            }
          }
        } else {
          out.println("No cancelled films.");
        }
      %>
    </ul>
  </section>


</main>
<script src="../../scripts/dropdown.js"></script>
<script src="tracker.js"></script>
<script>
  // Get the context path
  var contextPath = "${pageContext.request.contextPath}";

  // Set the URL of the servlet using the context path
  var servletUrl = contextPath + "/FilmRelationServlet";

  // Function to make the request using fetch
  function setFilmRelationsInSession() {
    fetch(servletUrl)
            .then(response => {
              if (!response.ok) {
                throw new Error('Error while making the request');
              }
              return response.text();
            })
            .then(data => {
              console.log(data);
            })
            .catch(error => {
              console.error('Error:', error);
            });
  }

  // Call the setFilmRelationsInSession function when the page is loaded
  document.addEventListener("DOMContentLoaded", setFilmRelationsInSession);
</script>
</body>
</html>
