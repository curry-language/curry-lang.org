<section>
:::md:max-w-3xl

Features of Curry
=================

:::
</section>
<section>      
:::md:max-w-3xl

To get an idea of the multi-paradigm programming language Curry,
here is an (incomplete) list of its features:

* __Program entities:__ Functions defined by equations (predicates are considered as Boolean functions or constraints)
* __Syntax:__ Almost similar to [Haskell](http://www.haskell.org). In addition, declarations of free variables are allowed and program rules might overlap (leading to nondeterministic computations).
* __Type system:__ Parametric polymorphism (a la Hindley/Milner) and overloading via type classes
* __Operational semantics:__ Basically, lazy reduction of functional expressions. However, function calls may contain free (logic) variables. Such function calls may be evaluated by non-deterministic instantiation of a variable or suspended until a variable becomes instantiated (e.g., by solving some predicate), i.e., this operational semantics combines the ideas of "narrowing" and "residuation". This operational semantics was firstly described in a [POPL'97 paper](http://www.michaelhanus.de/papers/POPL97.html) and another detailed description can be found in the [Curry report](https://www.curry-lang.org/docs/report/).
* __Higher-order functions:__ As usual where function application is delayed if functional values are unknown (i.e., free variables). 
* __Declarative (monadic) I/O__
* __(Equational) constraints__ where Curry system can support the concurrent evaluation of constraints
* __Encapsulated search__ to control the exploration of the search space (based on this feature, several predefined search strategies like depth-first search, breadth-first search, best solution search etc. are available)

:::
</section>
<section>      
:::md:max-w-3xl

These are the basic features of the kernel language. Look into the
[Curry report](/documentation/report/)
if you are interested in more details.
Further features might
be available in different extensions of this kernel language.

:::
</section>
