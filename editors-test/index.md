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

## Emacs

The distributions of the Curry systems
[PAKCS](http://www.informatik.uni-kiel.de/~pakcs/) and
[KiCS2](http://www-ps.informatik.uni-kiel.de/kics2)
contain (in the directory ''tools/emacs'') a Curry mode
(adapted from a Haskell mode) for the editor
[Emacs](http://www.gnu.org/software/emacs/).
The installation and usage is described in the distributed
''README'' file.

:::
</section>
<section>      
:::md:max-w-3xl

## Kate

The [Kate](http://kate-editor.org/) editor contains
syntax highlighting for Curry programs. This mode can be
acticated by Kate's download mechanism. To do this, start
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

In the dialog, just select Curry (it not already selected), click ''Install''
and wait for the installation to finish. You must restart Kate for the
installation to take effect.

:::
</section>
<section>      
:::md:max-w-3xl

## Atom 

The [Atom](https://atom.io/) editor contains syntax highlighting and snippets
for Curry programs with the package ''language-curry''.
To download the package, start Atom and navigate to

---

```default
Settings
  -> Install
```

---

type in ''language-curry'' and hit ''RETURN''.
Select the corresponding package, click ''Install'' and wait for the installation to finish.
Alternatively, it is possible to download the package via command-line with
the Atom Package Manager ''apm'' (must be in your ''PATH''):

---

```sh
> apm install language-curry
```

---

:::
</section>
