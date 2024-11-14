<section>
:::md:max-w-3xl

Editing Curry programs 
======================

:::
</section>
<section>      
:::md:max-w-3xl

Of course, one can use any text editor to write and modify Curry programs.
However, for some editors (listed below), there exist specific modes
to edit or highlight Curry programs.

:::
</section>
<section>      
:::md:max-w-3xl

## Visual Studio Code

In order to get Curry language support in Visual Studio Code,
you have to build the
[Curry Language Server](https://github.com/fwcd/curry-language-server)
on your machine which requires [Haskell stack](http://www.haskellstack.org/).
If you have `stack` installed, download the repository,
run `stack install`, and add `~/.local/bin` to your path.
For example, execute the following commands:

```sh
  > git clone https://github.com/fwcd/curry-language-server
  > cd curry-language-server
  > stack install
  > export PATH=~/.local/bin:$$PATH
```

After building the Curry Language Server, start Visual Studio Code. Then:

  * Go to extensions (Ctrl+Shift+X) and search for Curry or `fwcd.curry`.

  * Install the "Curry IDE for Visual Studio Code"

  * If the executable `curry-language-server` is not in your path,
    set the option `curry.languageServer.path` explicitly to this executable.
    This can be done by selecting `File>Preferences>Settings>Extensions>Curry`.

  * There you might also set `importPaths` to the directory
    where your Curry system contains the base libraries, e.g.:

        "curry.languageServer.importPaths": [
          "/home/joe/pakcs/lib"
        ],

  * The Curry IDE has to find the code of imported modules. In order
    to do so, you need to run `cypm deps -l` in the directory where
    you invoke Visual Studio Code. If `cypm` is in your path and you
    are inside a Curry package, the Curry Language Server does this
    automatically for you.

  * If you reach a situation where the language server cannot find the
    source code of imported entities, you might try to clean
    intermediate data. To do so, close Visual Studio Code, remove the
    directory `.curry/language-server`, run `cypm deps -l`, and start
    again.

:::
</section>
<section>      
:::md:max-w-3xl

## Emacs

The distributions of the Curry systems
[PAKCS](http://www.curry-lang.org/pakcs/) and
[KiCS2](http://www.curry-lang.org/kics2)
contain (in the directory `tools/emacs`) a Curry mode
(adapted from a Haskell mode) for the editor
[Emacs](http://www.gnu.org/software/emacs/).
The installation and usage is described in the distributed
`README` file.

:::
</section>
<section>      
:::md:max-w-3xl

## Kate

The [Kate](http://kate-editor.org/) editor contains
syntax highlighting for Curry programs. This mode can be
activated by Kate's download mechanism. To do this, start
Kate and go to

---

```default
Setting
  -> Configure Kate ...
      -> Open/Save
           -> Modes & Filetypes
               -> Download Highlighting Files ...
```

---

In the dialog, just select Curry (it not already selected), click `Install`
and wait for the installation to finish. You must restart Kate for the
installation to take effect.

:::
</section>
<section>      
:::md:max-w-3xl

## Atom 

The [Atom](https://atom.io/) editor contains syntax highlighting and snippets
for Curry programs with the package `language-curry`.
To download the package, start Atom and navigate to

---

```default
Settings
  -> Install
```

---

type in `language-curry` and hit `RETURN`.
Select the corresponding package, click `Install` and wait for the installation to finish.
Alternatively, it is possible to download the package via command-line with
the Atom Package Manager `apm` (which must be in your `PATH`):

---

```sh
  > apm install language-curry
```

---

:::
</section>
