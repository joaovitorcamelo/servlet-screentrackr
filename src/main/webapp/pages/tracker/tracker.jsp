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
    <link rel="stylesheet" href="tracker.css" />
    <title>screentrackr - Tracker</title>
    <style>
      .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
      }
    </style>
  </head>

  <body>
    <header id="logged-header">
      <ul id="header-list">
        <li><a href="../tracker/tracker.html">Tracker</a></li>
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
      <section>
        <h1 class="section-header">Currently watching</h1>
        <ul id="currently-list" class="tracker-list">
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
        </ul>
      </section>
      <section>
        <h1 class="section-header">Watchlist</h1>
        <ul id="watchlist" class="tracker-list">
          <li></li>
          <li></li>
        </ul>
      </section>
      <section>
        <h1 class="section-header">Watched</h1>
        <ul id="watched-list" class="tracker-list">
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
          <li></li>
        </ul>
      </section>
      <section>
        <h1 class="section-header">Cancelled</h1>
        <ul id="cancelled-list" class="tracker-list"></ul>
      </section>
    </main>
    <script src="../../scripts/dropdown.js"></script>
  </body>
</html>
