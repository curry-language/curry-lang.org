var features = [...Array(6).keys()].map(number => ({
  title: 'Lorem ipsum dolor sit amet',
  text: 'Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  learnMore: 'https://www-ps.informatik.uni-kiel.de/currywiki/'
}));

var app = new Vue({
  el: '#app',
  data: {
    title: 'Curry',
    subtitle: 'A Truly Integrated Functional Logic Programming Language',
    description: 'Curry is a universal programming language aiming to amalgamate the most important declarative programming paradigms, namely functional programming and logic programming. Moreover, it also covers the most important operational principles developed in the area of integrated functional logic languages: “residuation” and “narrowing”.',
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
        title: 'Tools',
        url: 'https://www-ps.informatik.uni-kiel.de/currywiki/'
      },
      {
        title: 'Packages',
        url: 'https://www.informatik.uni-kiel.de/~curry/cpm/'
      }
    ],
    downloadsUrl: 'https://www-ps.informatik.uni-kiel.de/currywiki/',
    features: features,
  },
  methods: {
    toggleNav() {
      this.showNav = !this.showNav
    }
  }
});