var features = [...Array(4).keys()].map(number => ({
  title: 'Lorem ipsum dolor sit amet',
  text: 'Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  url: '#',
  linkText: 'Learn More'
}));

var app = new Vue({
  el: '#app',
  data: {
    showNav: false,
    languageFeatures: features,
    ecosystem: features,
  },
  methods: {
    toggleNav() {
      this.showNav = !this.showNav
    }
  }
});