var features = [...Array(6).keys()].map(number => ({
  title: 'Lorem ipsum dolor sit amet',
  text: 'Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  learnMore: '#'
}));

var app = new Vue({
  el: '#app',
  data: {
    title: 'Curry',
    subtitle: 'A Truly Integrated Functional Logic Programming Language',
    description: 'Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    showNav: false,
    navLinks: [
      {
        title: 'CurryWiki',
        url: 'https://www-ps.informatik.uni-kiel.de/currywiki/'
      },
      {
        title: 'Curr(y)gle',
        url: 'https://www-ps.informatik.uni-kiel.de/kics2/currygle/'
      },
      {
        title: 'PAKCS',
        url: 'https://www.informatik.uni-kiel.de/~pakcs/'
      },
      {
        title: 'KiCS2',
        url: 'https://www-ps.informatik.uni-kiel.de/kics2/'
      },
      {
        title: 'Packages',
        url: 'https://www.informatik.uni-kiel.de/~curry/cpm/'
      }
    ],
    downloadsUrl: '#',
    features: features,
  },
  methods: {
    toggleNav() {
      this.showNav = !this.showNav
    }
  }
});