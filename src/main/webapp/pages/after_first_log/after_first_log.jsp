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
    <script src="after_first_log.js"></script>
  </head>

  <body>
    <form action="" id="name-form">
      <div class="form-header">
        <h1>What's your name?</h1>
      </div>
      <input type="text" placeholder="Name" required />
      <button class="primary-btn" type="button" id="send-name-btn">
        Continue
      </button>
    </form>

    <form action="" id="photo-form">
      <div class="form-header">
        <h1>Set a profile picture</h1>
      </div>

      <label for="image-input" id="upload-label">
        <span>Click to upload</span>
      </label>
      <input type="file" id="image-input" accept="image/*" />

      <div id="form-buttons">
        <button class="primary-btn" type="button" id="skip-btn">Skip</button>
        <button class="primary-btn" type="button" id="send-picture-btn">
          Continue
        </button>
      </div>
    </form>
  </body>
</html>
