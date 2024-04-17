<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Inter"
    />
    <link rel="stylesheet" href="../../index.css" />
    <link rel="stylesheet" href="login.css" />
    <title>screentrackr - Login</title>
  </head>

  <body>
    <% if (session.getAttribute("message") != null) { %>
    <div class="success-message">
      <h1>Registration Succeeded</h1>
      <p>Your registration has been successfully completed.</p>
    </div>
    <% session.removeAttribute("message"); // Remove message after displaying %>
    <% } %>
    <header class="not-logged-header">
      <a href="./login.jsp">
        <img src="../../assets/screentrackr.svg" alt="screentrackr" />
      </a>
    </header>
    <form action="">
      <input type="text" placeholder="E-mail" required />
      <input type="password" placeholder="Password" required />
      <a class="forgot-password" href="../forgot-password/forgot-password.html"
        >Forgot password</a
      >
      <button class="primary-btn" type="submit">Login</button>
      <span class="signup-link">
        Don`t have an account yet?
        <a href="../register/register.jsp">Sign up now</a>
      </span>
    </form>
  </body>
</html>
