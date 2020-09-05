# Website of the functional logic programming language Curry

## Installation

1. Install stack
    - Stack is included in the haskell platform: <https://www.haskell.org/platform/>
    - Stack 1.9.3 should work
2. Install hakyll using stack: `stack install hakyll`
    - might require system packages `gmp-devel` or `libgmp-dev`
      to be installed for some dependencies to compile under linux

## Build

1. Build the Haskell executable: `stack build`
    - This should install the required ghc version as well as all required dependencies, as configure in the curry-lang-org.cabal and stack.yaml
    - currently using stack resolver lts-14.15 which corresponds to ghc-8.6.5
2. Build the site using the compiled executable: `stack exec site build`
    - This generates the site into the `_site` subdirectory
3. (Optional) Check for broken links: `stack exec site check`


## Development

To view the website simply build the project and start the built-in
hakyll web server at the root directory of this repository with the
following command.

```shell
stack build
stack exec site watch
```

Now open the browser of your choice and navigate to [localhost:8000](localhost:8000).

When any changes outside of the Haskell code are saved, all dependent
pages will be rebuild automatically and be seen in the browser after a
refresh.

After changes to the Haskell code more manual intervention is necessary.
First stop the running `stack exec site watch` invocation.
Then run the following commands.

```
stack build
stack exec site rebuild
stack exec site watch
```

It is also advisable to run `stack exec site check` to check for broken links.

## Structure

### Folder Structure

```
. project root
|
+ .gitignore
+ curry-lang-org.cabal         the cabal project file
+ index.html                   contains index.html for /
+ README.md                    this readme document
+ site.hs                      the haskell source defining the routes and resource processing
+ stack.yaml                   the stack project file 
|
|
+-- assets
|     |
|     +-- js                   contains .js files
|     +-- css                  contains .css files
|     +-- img                  contains images files
|
+-- code                       contains embedded code as markdown templates
+-- cpm                        contains the index.html for /cpm
+-- downloads                  contains the index.html for /downloads
+-- imprint                    contains the index.html for /imprint
+-- learn_more                 contains the files that are used to generate the Features 
|     |                        and Ecosystem sections on the landingpage
|     |
|     +-- *_desc.html          one *_desc.html each defining the title 
|     |                        and highlight color for each section
|     |
|     +--  ecosystem/features  one folder containing the definitions for 
|                              the items of the corresponding section
|
+-- link_groups                contains the definitions for the generated header/footer links 
|     |
|     +-- footer               contains a definition for each footer group 
|     |                        and a folder each for the link definitions of that group
|     |
|     +-- header               contains a definition for each header link
|
+-- privacy                    contains the index.html for /privacy
+-- syntax_definition          contains the modified language definitions used by pandoc 
|     |
|     +-- curry.xml            modified version of the default kde curry language syntax definition 
|                              used for syntax highlighting
|
+-- templates                  contains various templates
+-- versions                   contains one *_versions.html file 
      |                        and folder for each table on the downloads page
      |
      +-- *_version.html       description for a table on the downloads page
      +-- kics2/pakcs          version entries for the download page for each table respectively   
```

### Code Structure

The sites routes and used files are specified as part of the haskell program defined in `site.hs`.

The main function specifies the routes and route dependencies, it is separated from the remaining code by 
a line of dashes.

In the main function there is a `match` expression for each set of identically processed resources.
   

## Other

`stack exec site clean` can be used to clean the `_site` and `_cache` directory.

## Wiki -> Markdown Conversion

- Headlines 
 - replace `=` signes with markdown headline
 - Main Headline underline with `=` or prefix with `# `
 - Other headlines should be at least h2 headlines with `##` prefix

- Code Examples
  - add backtick fence
  - decrease indentation
  - annotate language for correct highlighting
    - explicit `default` is different to no annotation 
  - surround with lines containing only `___`

- External Link Rewrite Regex 
  - Find `\[\[\s*(\S*)\s*\|\s*(\S*)\s*\]\]`
  - Replace `[$2]($1)`
  
- Internal Links
  - manual
   - for links to wiki files (e.g. cass_longer.pdf) the file should be added to the assets and linked from there
  
- Images
 - manual
   - for wiki image download image and add it to the assets then link from there
   - for external images just link to the external image
    
- Adding section
  - Start (first) Section 
    ```markdown
    <section>
    :::md:max-w-3xl
    ```
  - Change Section 
    ```markdown
    :::
    </section>  
    <section>
    :::md:max-w-3xl
    ```
  - End (last) Section 
    ```markdown  
    :::
    </section>  
    ```