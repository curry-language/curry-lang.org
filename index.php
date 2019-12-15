<!DOCTYPE html>
<html lang="en">
<?php $title = ""; include("snippets/head.php"); ?>
<body>
  <?php include("snippets/header.php"); ?>
  <main class="pt-16">
    <section class="slanted-bottom flex justify-center px-6 pt-4 md:pt-6">
      <div class="md:max-w-3xl">
        <div class="flex flex-col justify-center sm:flex-row">
          <img class="h-32 w-32 sm:h-56 sm:w-56 -mb-4 mx-auto sm:mb-0 sm:ml-0 sm:mr-3" src="/assets/img/curry.svg" alt="Curry Logo">
          <h1 class="flex justify-center items-center font-bold leading-tight text-7xl sm:text-10xl">Curry</h1>
        </div>
        <span class="block text-center text-red leading-tight text-2xl mx-auto sm:text-4xl md:max-w-2xl">A Truly Integrated Functional Logic Programming Language</span>
        <div class="flex justify-center mt-8">
          <a class="flex items-center text-red text-center border border-red rounded-lg font-semibold leading-tight px-4 py-3 hover:bg-red hover:text-white" href="/downloads/">Downloads</a>
          <a class="flex items-center text-blue text-center border border-blue rounded-lg font-semibold leading-tight px-4 py-3 ml-4 hover:bg-blue hover:text-white" href="https://www-ps.informatik.uni-kiel.de/smap/">Try It!</a>
        </div>
      </div>
    </section>
    <section class="slanted flex justify-center bg-primary px-6">
      <div class="font-mono text-xs sm:text-base">
        <span class="comment">-- | Returns the last element.</span><br>
        <span class="func">last</span> <span class="symbol">::</span> <span class="symbol">[</span><span class="ident">a</span><span class="symbol">]</span> <span class="symbol">-&gt;</span> <span class="ident">a</span><br>
        <span class="func">last</span> <span class="ident">xs</span> <span class="symbol">|</span> <span class="ident">ys</span> <span class="func">++</span> <span class="symbol">[</span><span class="ident">x</span><span class="symbol">]</span> <span class="func">=:=</span> <span class="ident">xs</span> <span class="symbol">=</span> <span class="ident">x</span><br>
        <span class="whitespace-pre keyword">  where</span><br>
        <span class="whitespace-pre ident">    x</span><span class="symbol">,</span> <span class="ident">ys</span> <span class="keyword">free</span>
      </div>
    </section>
    <section class="slanted flex justify-center px-6">
      <div class="md:max-w-3xl">
        <p class="text-center text-lg text-gray-600 leading-relaxed mb-4">Curry is a <span class="font-bold">universal programming language</span> which combines the most important declarative programming paradigms, namely <span class="font-bold">functional programming</span> and <span class="font-bold">logic programming</span>. Moreover, it also covers the most important operational principles developed in the area of integrated functional logic languages: residuation and narrowing.</p>
        <p class="text-center text-lg text-gray-600 leading-relaxed mb-4">The development of Curry is an international initiative intended to provide a common platform for the research, teaching and application of integrated functional logic languages. The design of Curry is mainly discussed in the Curry mailing list. A detailed report describing the language is also available. To get an idea of Curry, you may have a look into the short list of Curry's features or a tutorial on Curry.</p>
        <div class="flex flex-col justify-center sm:flex-row">
          <a class="text-primary border border-primary rounded-lg font-semibold leading-tight mx-auto px-4 py-3 hover:bg-primary hover:text-white sm:mx-0" href="https://www-ps.informatik.uni-kiel.de/currywiki/_media/documentation/report.pdf">Curry Report</a>
          <a class="text-primary border border-primary rounded-lg font-semibold leading-tight mx-auto mt-4 px-4 py-3 hover:bg-primary hover:text-white sm:ml-4 sm:mr-0 sm:mt-0" href="https://www.informatik.uni-kiel.de/~curry/tutorial/tutorial.pdf">Tutorial</a>
          <a class="text-primary border border-primary rounded-lg font-semibold leading-tight mx-auto mt-4 px-4 py-3 hover:bg-primary hover:text-white sm:ml-4 sm:mr-0 sm:mt-0" href="https://www.informatik.uni-kiel.de/~curry/listarchive/">Mailing List</a>
        </div>
      </div>
    </section>
    <section class="slanted flex flex-col justify-center bg-primary px-6">
      <div class="mx-auto mb-4">
        <h1 class="text-center text-4xl font-bold text-white">Features</h1>
        <div class="marker bg-blue"></div>
      </div>
      <div class="features">
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Purely Functional</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center font-mono text-xs sm:text-base mt-4">
            <div>
              <span class="func">square</span> <span class="symbol">::</span> <span class="type">Int</span> <span class="symbol">-&gt;</span> <span class="type">Int</span><br>
              <span class="func">square</span> <span class="ident">x</span> <span class="symbol">=</span> <span class="ident">x</span> <span class="func">*</span> <span class="ident">x</span>
            </div>
          </div>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-blue border-2 border-blue rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/">Learn More</a>
          </div>
        </div>
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Type Inference</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center font-mono text-xs sm:text-base mt-4">
            <div>
              <span class="func">square</span> <span class="symbol">::</span> <span class="type">Int</span> <span class="symbol">-&gt;</span> <span class="type">Int</span><br>
              <span class="func">square</span> <span class="ident">x</span> <span class="symbol">=</span> <span class="ident">x</span> <span class="func">*</span> <span class="ident">x</span>
            </div>
          </div>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-blue border-2 border-blue rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/">Learn More</a>
          </div>
        </div>
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Nondeterminism</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center font-mono text-xs sm:text-base mt-4">
            <div>
              <span class="func">square</span> <span class="symbol">::</span> <span class="type">Int</span> <span class="symbol">-&gt;</span> <span class="type">Int</span><br>
              <span class="func">square</span> <span class="ident">x</span> <span class="symbol">=</span> <span class="ident">x</span> <span class="func">*</span> <span class="ident">x</span>
            </div>
          </div>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-blue border-2 border-blue rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/">Learn More</a>
          </div>
        </div>
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Free Variables</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center font-mono text-xs sm:text-base mt-4">
            <div>
              <span class="func">square</span> <span class="symbol">::</span> <span class="type">Int</span> <span class="symbol">-&gt;</span> <span class="type">Int</span><br>
              <span class="func">square</span> <span class="ident">x</span> <span class="symbol">=</span> <span class="ident">x</span> <span class="func">*</span> <span class="ident">x</span>
            </div>
          </div>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-blue border-2 border-blue rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/">Learn More</a>
          </div>
        </div>
      </div>
    </section>
    <section class="slanted flex justify-center px-6">
      <div class="md:max-w-3xl">
        <p class="text-center text-lg text-gray-600 leading-relaxed">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
      </div>
    </section>
    <section class="slanted flex flex-col justify-center bg-primary px-6">
      <div class="mx-auto mb-4">
        <h1 class="text-center text-4xl font-bold text-white">Ecosystem</h1>
        <div class="marker bg-red"></div>
      </div>
      <div class="features">
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Compilers</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-red border-2 border-red rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/implementations/overview/">Learn More</a>
          </div>
        </div>
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Package Manager</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-red border-2 border-red rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/tools/cpm/">Learn More</a>
          </div>
        </div>
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">CurryDoc</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-red border-2 border-red rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/currywiki/tools/currydoc/">Learn More</a>
          </div>
        </div>
        <div>
          <h2 class="text-center text-2xl font-semibold text-white mb-2">Curr(y)gle API Search</h2>
          <p class="text-center text-white">Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          <div class="flex justify-center mx-4 mt-4">
            <a class="inline-block w-full text-white text-center bg-red border-2 border-red rounded-lg font-semibold leading-tight px-4 py-2 hover:border-white" href="https://www-ps.informatik.uni-kiel.de/kics2/currygle/">Learn More</a>
          </div>
        </div>
      </div>
    </section>
  </main>
  <?php include("snippets/footer.php"); ?>
</body>
</html>