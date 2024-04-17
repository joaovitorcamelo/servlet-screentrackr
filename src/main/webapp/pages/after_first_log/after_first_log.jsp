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
    <link rel="stylesheet" href="after_first_log.css" />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
    />
    <title>screentrackr</title>
    <style>
      .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 40;
        font-size: 40px;
      }
    </style>
  </head>

  <body>
  <form action="${pageContext.request.contextPath}/UpdateNameServlet" method="POST" id="name-form">
    <div class="form-header">
      <h1>What's your name?</h1>
    </div>
    <input type="text" name="name" placeholder="Name" required />
    <button class="primary-btn" type="submit" id="send-name-btn">
      Continue
    </button>
  </form>
  </body>

</html>
