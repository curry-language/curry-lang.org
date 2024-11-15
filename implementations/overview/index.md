---
title: "Implementations of Curry"
---
<section>
:::md:max-w-3xl

Implementations of Curry
========================

:::
</section>
<section>
:::md:max-w-3xl

## Overview

Since the development of Curry is an international initiative by
various research groups, several implementations are available and/or
under development. Some of them are listed below.
More details about these systems and their installation can be found
in the referenced web pages.

:::
</section>
<section>
:::md:max-w-3xl

## PAKCS

:::
</section>
<section>
:::md:max-w-3xl

The
[Portland Aachen Kiel Curry System (PAKCS)](https://www.curry-lang.org/pakcs)
is an implementation of Curry jointly developed by the
[Portland State University](https://www.cs.pdx.edu/~antoy/),
the Aachen University of Technology, and the
[Kiel University](http://www.informatik.uni-kiel.de/~mh/).
PAKCS is an interactive system
to develop Curry programs. It has a simple user interface,
some interactive debugging features and provides direct access
to various useful tools (which are usually installed by the
[Curry Package Manager](https://www.curry-lang.org/tools/cpm).
Since PAKCS compiles Curry programs into Prolog programs,
it also provides constraint solvers for arithmetic, Boolean,
and finite domain constraints.

Depending on the Prolog system (currently, SWI-Prolog and SICStus-Prolog
are supported), the compilation of Curry programs is relatively fast
but their execution is much slower compared to KiCS2.
Thus, Curry applications are often developed with PAKCS and
deployed with KiCS2.


:::
</section>
<section>
:::md:max-w-3xl

## KiCS2

:::
</section>
<section>
:::md:max-w-3xl

[KiCS2](https://www.curry-lang.org/kics2)
is a Curry compiler and interactive system which
translates Curry programs into [Haskell](https://www.haskell.org/) programs.
KiCS2 supports several search strategies
(e.g., depth-first, breadth-first, iterative deepening).
It has an interactive environment similarly to PAKCS
and also supports the same libraries and packages as PAKCS.
Due to the use of the [Glasgow Haskell Compiler](http://www.haskell.org/ghc)
to generate executables,
the compilation is often slower than PAKCS but the
generated executables run much faster.
Therefore, KiCS2 has been used to deploy various applications.


:::
</section>
<section>
:::md:max-w-3xl

## Curry2Go

:::
</section>
<section>
:::md:max-w-3xl

[Curry2Go](https://www.curry-lang.org/curry2go)
is a Curry compiler which
translates Curry programs into [Go](https://golang.org/) programs.
Similarly to many other implementations of Curry,
the distribution contains
an interactive environment (read/eval/print loop)
to ease the development of Curry applications.
Curry2Go supports various search strategies
(e.g., depth-first, breadth-first, iterative deepening).
The default strategy is a _fair search strategy_
which performs parallel evaluations in a multi-processor environment.
In particular, the strategy is _operationally complete_,
i.e., it always computes a value if it exists according to the
declarative interpretation of the Curry program.
For instance, Curry2Go computes a value to the following
non-deterministic choice between three expressions,
where the leftmost and rightmost are non-terminating:

    Curry2Go Interactive Environment Version...
    Prelude> length [1..] ? 42 ? length [1..]
    42

This is achieved by compiling non-determinism into goroutines.
Thus, in multi-processor environments, non-deterministic programs
are executed in a parallel manner.


:::
</section>
<section>
:::md:max-w-3xl

## MCC

:::
</section>
<section>
:::md:max-w-3xl

The [Münster Curry Compiler (MCC)](http://danae.uni-muenster.de/curry/)
is a mature native code compiler for
Curry which conforms to the Curry report except for committed
choice which is not supported. Since release 0.9.5 there are no
longer restrictions to the encapsulated search. Supported
extension to the Curry language include disequality constraints,
recursive pattern bindings, and IO exceptions. A distinctive
feature of the Münster Curry compiler is the integration of a
declarative debugger of wrong answers. An interactive Curry
environment and a make-like build tool for Curry are included
in the distribution. Besides the Gnu C compiler no other
software is needed to compile and run Curry programs with
the Münster Curry compiler.
Newer features of Curry are not supported since MCC
is no longer maintained.


:::
</section>
<section>
:::md:max-w-3xl

## Sprite

:::
</section>
<section>
:::md:max-w-3xl

Sprite is a compiler and runtime for Curry programs.
It is based on the Fair Scheme, a compilation strategy for transforming
declarative, non-deterministic source programs into imperative,
deterministic code.
As the Fair Scheme emphasizes operational completeness,
Sprite aims to produce all values of Curry programs,
subject only to practical limits such as the amount of memory available.

Papers on Sprite:

* [Compiling a Functional Logic Language: The Fair Scheme](https://doi.org/10.1007/978-3-319-14125-1_12)

* [A New Functional-Logic Compiler for Curry: Sprite](https://arxiv.org/abs/1608.04016)


:::
</section>
<section>
:::md:max-w-3xl

# Older Implementations

:::
</section>
<section>
:::md:max-w-3xl

Below are references to some older implementations of Curry
that are no longer actively maintained.

* __[FLVM](http://web.cecs.pdx.edu/~antoy/homepage/download.html)__
  is a virtual machine for functional logic computations.
  Curry programs are compiled into FLVM instructions
  that are executed by the FLVM interpreter that is implemented in Java.
  A feature of the
  FLVM is the implementation of a fair (i.e., operationally complete)
  execution of nondeterministic computations and sharing
  of deterministic computations over nondeterministic branches.

* The __[Sloth system](http://babel.ls.fi.upm.es/research/Sloth/)__
  is a compiler which translates Curry programs into Prolog programs.
  The Sloth system has an interactive
  interface to load programs, evaluate expressions etc.

* The __[Zinc Compiler](http://zinc-project.sourceforge.net/)__
  is an experimental compiler for an
  extended version of Curry and based on the
  Münster Curry Compiler (MCC) supporting type classes.

* __[CIDER](https://www.curry-lang.org/pakcs/cider/)__
  is a graphical programming and development environment for Curry.
  CIDER is intended as a platform to integrate various
  tools for analyzing and debugging Curry programs.
  CIDER is completely implemented in Curry. Although the graphical debugger
  contains an interpreter for executing Curry programs,
  it is only intended for visualizing the execution of smaller programs
  and not for executing larger programs.

:::
</section>
