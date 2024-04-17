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
    <link rel="stylesheet" href="register.css" />
    <title>screentrackr - Register</title>
  </head>

  <body>
  <% if (session.getAttribute("errorMessage") != null) { %>
  <div class="error-message">
    <h1>Registration Error</h1>
    <p><%= session.getAttribute("errorMessage") %></p>
  </div>
  <% session.removeAttribute("errorMessage"); // Remove a mensagem após exibição %>
  <% } %>

  <header class="not-logged-header">
      <a href="../login/login.jsp">
        <img src="../../assets/screentrackr.svg" alt="screentrackr" />
      </a>
    </header>
    <form action="<%= request.getContextPath() %>/RegisterServlet" method="POST">
      <input type="email" id="email" name="email" placeholder="E-mail" required />
      <input type="password" id="password" name="password" placeholder="Password" required />
      <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required />
      <button class="primary-btn" type="submit">Register</button>
      <span class="signin-link">
        Already have an account?
        <a href="../login/login.jsp">Sign in</a>
      </span>
    </form>
  </body>
</html>
