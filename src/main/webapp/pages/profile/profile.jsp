<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.screentrackr.screentrackr.model.User"%>
<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Inter"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <link rel="stylesheet" href="../../index.css" />
    <link rel="stylesheet" href="profile.css" />
    <title>screentrackr - Profile</title>
    <style>
      .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
      }
    </style>
  </head>

  <body>
    <header id="logged-header">
      <ul id="header-list">
        <li><a href="../tracker/tracker.jsp">Tracker</a></li>
        <li><a href="../profile/profile.html">Profile</a></li>
      </ul>
      <img src="../../assets/screentrackr.svg" alt="screentrackr" />
      <div>
        <div class="input-with-icon">
          <span class="material-symbols-outlined"> search </span>
          <input type="text" id="explore-search" placeholder="Search" />
        </div>
        <div id="dropdown-menu">
          <span class="material-symbols-outlined" id="settings-icon">
            settings
          </span>
          <div id="dropdown-background">
            <ul id="dropdown-body">
              <li>
                <span class="material-symbols-outlined"> edit </span>
                <a href="../edit_profile/edit_profile.html">
                  <span>Edit profile</span>
                </a>
              </li>
              <li>
                <span class="material-symbols-outlined"> logout </span>
                <span>Logout</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>
    <main>
      <section id="profile-info">
        <img src="../../assets/test.webp" alt="Profile image" />
        <div>
          <h2><% if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            out.print(user.getName());
          }%></h2>
          <p>Bio is written here. Limit of 100 characters.</p>
        </div>
      </section>
      <section id="user-stats">
        <h1>Stats</h1>
        <div>
          <span class="material-symbols-outlined"> timer </span>
          <span>1592 hours watched</span>
        </div>
        <div>
          <span class="material-symbols-outlined"> live_tv </span>
          <span>72 productions watched</span>
        </div>
      </section>
    </main>
    <script src="../../scripts/dropdown.js"></script>
  </body>
</html>
