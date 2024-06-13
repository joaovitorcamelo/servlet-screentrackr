<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter" />
  <link rel="stylesheet" href="../../index.css" />
  <link rel="stylesheet" href="login.css" />
  <title>screentrackr - Login</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
    $(document).ready(function() {
      $('form').submit(function(event) {
        event.preventDefault(); // Impede que o formulário seja submetido da maneira tradicional

        const email = $('input[name="email"]').val();
        const password = $('input[name="password"]').val();

        $.ajax({
          url: '${pageContext.request.contextPath}/LoginServlet',
          type: 'POST',
          data: {
            email: email,
            password: password
          },
          success: function(response) {
            console.log('Login success:', response);
            localStorage.setItem('userData', JSON.stringify(response));
            console.log('xxx')
            // Verificar authToken e redirecionar
            if (response.authToken) {
              console.log('aqui aqui', response.authToken)
              window.location.href = '${pageContext.request.contextPath}/pages/tracker/tracker.jsp'; // Redireciona para a página do tracker
            } else {
              window.location.href = '${pageContext.request.contextPath}/pages/after_first_log/after_first_log.jsp'; // Redireciona para a página pós-primeiro login
            }
          },
          error: function(xhr, status, error) {
            console.log('Error:', error);
          }
        });
      });
    });
  </script>
</head>
<body>
<% if (session.getAttribute("errorMessage") != null) { %>
<div class="error-message">
  <h1>Login Error</h1>
  <p><%= session.getAttribute("errorMessage") %></p>
</div>
<% session.removeAttribute("errorMessage"); // Remove a mensagem após exibição %>
<% } %>
<% if (session.getAttribute("message") != null) { %>
<div class="success-message">
  <h1>Registration Succeeded</h1>
  <p>Your registration has been successfully completed.</p>
</div>
<% session.removeAttribute("message"); // Remove message after displaying %>
<% } %>
<header class="not-logged-header">
  <a href="login.jsp">
    <img src="../../assets/screentrackr.svg" alt="screentrackr" />
  </a>
</header>
<form>
  <input type="email" name="email" placeholder="E-mail" required />
  <input type="password" name="password" placeholder="Password" required />
  <a class="forgot-password" href="../forgot-password/forgot-password.html">Forgot password</a>
  <button class="primary-btn" type="submit">Login</button>
  <span class="signup-link">
      Don't have an account yet?
      <a href="../register/register.jsp">Sign up now</a>
    </span>
</form>
</body>
</html>
