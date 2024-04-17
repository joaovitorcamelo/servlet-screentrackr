document.addEventListener('DOMContentLoaded', function () {
  // Access the button by its ID
  var sendNameBtn = document.getElementById('send-name-btn');
  // Access the name form by its ID
  var nameForm = document.getElementById('name-form');
  // Access the photo form by its ID
  var photoForm = document.getElementById('photo-form');

  // Initially hide the photo form
  photoForm.style.display = 'none';

  // Add an event listener to the button
  sendNameBtn.addEventListener('click', function () {
    // Hide the name form
    nameForm.style.display = 'none';
    // Display the photo form
    photoForm.style.display = 'flex';
  });
});
