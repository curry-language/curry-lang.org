let showNavMenu = false;

document.addEventListener('DOMContentLoaded', () => {
  const navToggle = document.getElementById('navToggle');
  const navMenu = document.getElementById('navMenu');

  navToggle.addEventListener('click', () => {
    showNavMenu = !showNavMenu

    if (showNavMenu) {
      navMenu.classList.add('block')
      navMenu.classList.remove('hidden')
    } else {
      navMenu.classList.add('hidden')
      navMenu.classList.remove('block')
    }

    navToggle.setAttribute('aria-expanded', showNavMenu)
  });
});