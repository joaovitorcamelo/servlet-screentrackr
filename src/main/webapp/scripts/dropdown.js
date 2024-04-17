const settingsSpan = document.getElementById('settings-icon');
const dropdown = document.getElementById('dropdown-background');

function toggleDropdown() {
  if (dropdown.style.display === 'block') {
    dropdown.style.display = 'none';
  } else {
    dropdown.style.display = 'block';
  }
}

settingsSpan.addEventListener('click', toggleDropdown);
