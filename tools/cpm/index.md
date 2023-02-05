---
title: "Curry Package Manager"
---
<section>
:::md:max-w-3xl

Curry Package Manager
==============================

:::
</section>
<section>
:::md:max-w-3xl

## Overview

The Curry Package Manager (CPM) is a tool to distribute and
install Curry libraries and applications and manage version dependencies
between them.
These libraries are organized in packages.
There is a central index of all these packages which can
easily be downloaded by CPM.
The individual packages are currently not stored in a central
server but their source can be anywhere.
CPM organizes the automatic access to appropriate versions
of these packages so that a user does not need to know
about these details.

CPM also supports *semantic versioning*, i.e., it is able to check
whether a new minor version of a package is consistent
(w.r.t. its API and behavior) with a previous version of
the same package.

:::
</section>
<section>
:::md:max-w-3xl

## Available Packages

There are more than [130 packages available](https://www-ps.informatik.uni-kiel.de/~cpm/)
(including more than 600 modules).
There is a [table of all packages](https://www-ps.informatik.uni-kiel.de/~cpm/)
with more detailed information (e.g., API documentation).
These packages can immediately be downloaded or installed when CPM is installed (see below).

:::
</section>
<section>
:::md:max-w-3xl

## Installing the Curry Package Manager

CPM is already part of recent distributions of the Curry systems
[PAKCS](https://www.informatik.uni-kiel.de/~pakcs/) (Version 1.15.0 or higher),
[KiCS2](https://www-ps.informatik.uni-kiel.de/kics2/) (Version 0.6.0 or higher),
and
[Curry2Go(https://www-ps.informatik.uni-kiel.de/curry2go/).
If you have some older version of PAKCS or KiCS2, you can also
install CPM from its public repository.
The installation requires that one of the Curry systems PAKCS or KiCS2
is installed and the executables `curry` and `git` are in your path
(if `curry` is not in your path, you can also specify the root location
of your Curry system by modifying the definition of `CURRYROOT`
in the `Makefile` before executing `make` in step 3).
Then perform the following steps to install CPM:

---

```sh
1> git clone https://git.ps.informatik.uni-kiel.de/curry-packages/cpm.git
2> cd cpm
3> make
```

---

If this was successful, the binary `cypm` has been generated in the
directory `~/.cpm/bin`. This is also the directory where CPM installs binaries
of applications distributed as packages. For convenient use, you should add the
directory `~/.cpm/bin` to your path. Alternatively, you can also put
the binary `~/.cpm/bin/cypm` somewhere in your path or create a symbolic
link from some path directory to this binary.

:::
</section>
<section>
:::md:max-w-3xl

## Quick Start

If you installed CPM so the binary `cypm` is in your path,
you can clone a copy of the central package index repository by

---

```sh
> cypm update
```

---

Afterwards, you can show a short list of all packages in this index by

---

```sh
> cypm list
```

---

The command

---

```sh
> cypm info PACKAGE
```

---

can be used to show more information about a package.

In order to use a package in your Curry program which you intend
to develop, you have to start a new project.
Note that your project can also contribute to the Curry packages.
Therefore, to initialize it and use other packages, you need
a package description file in some project directory.
All this can be created by the command `cypm new`:

---

```sh
> cypm new myproject
```

---

This command creates a new project directory `myproject`
containing an initial package description file `package.json`
and a subdirectory `src` (together with other template files).
Change into the new project directory:

--- 

```sh
> cd myproject
```

---

If you need some other packages for your project,
add them as a dependency in `package.json`.
Then run

---

```sh
> cypm install
```

---

to install all dependencies of the current package.
Afterwards, start your interactive Curry environment by

---

```sh
> cypm curry
```

---

and you will be able to load the modules of the current package
as well as all dependent packages.
In particular, the source directory `src` is added to your path
so that you can directly load any program you have stored
in this directory.
For instance, if the module `Main.curry` is stored in the
directory `src`, you can load it into your Curry system
(e.g., KiCS2 or PAKCS) by

---

```sh
> cypm curry :load Main
```

---

:::
</section>
<section>
:::md:max-w-3xl

## Manual and Further Documentation

For further information, look into the
[manual of CPM](https://www-ps.informatik.uni-kiel.de/~cpm/DOC/cpm-3.1.0/manual.pdf)

A detailed description about CPM and its implementation can be found
in the following thesis:

[A Package Manager for Curry (Jonas Oberschweiber, CAU Kiel, September 2016)](https://www.informatik.uni-kiel.de/~mh/lehre/abschlussarbeiten/msc/Oberschweiber.pdf)

:::
</section>
<section>
:::md:max-w-3xl

## Uploading and Publishing Packages

Currently, there is no support for automatically uploading
and publishing new packages.
However, if you have developed some package that might be of
interest to other Curry users, please send the package
as a tar or zip file to

---

> packages (AT) curry-language.org
<hr>

in order to make it publicly available.

:::
</section>

<!--
Abbr(iviation) tags are not supported by (Pandoc) Markdown.


*[API]: Application Programming Interface
-->