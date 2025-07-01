---
title: "Applications of Curry"
---
<section>
:::md:max-w-3xl

Applications of Curry
======================

Since Curry amalgamates functional, logic, and concurrent
programming paradigms, the intended applications areas of Curry
cover the areas of languages belonging to these paradigms
(see, for instance,
[real-world applications of functional programming](https://homepages.inf.ed.ac.uk/wadler/realworld/)).
Many tools for Curry are implemented in Curry
and some of them are large applications of Curry.
Since these tools are listed in the tools section of the footer,
the following list does not include them.

:::
</section>

<section>
:::md:max-w-3xl

## Address server

This is a system to manage addresses. It consists of a
graphical user interface for the convenient insertion and
modification of addresses and an address server to access
addresses from Internet clients. To see some part of the functionality
of the address server, you can look at the
[current list of subscribers](https://www.michaelhanus.de/currylist/members.cgi)
of the [Curry mailing list](/various/mailinglist/).
The implementation uses the features for
[persistent redicates](https://www.michaelhanus.de/papers/JFLP04_dyn.html)
and the
[GUI library](https://www.michaelhanus.de/papers/PADL00.html)
of Curry.
For further details contact
[Michael Hanus](https://www.michaelhanus.de/).


## Bibliographic database

This is a system to store, retrieve and convert bibliographic
information oriented at documents in BibTeX format.
In addition to pure BibTeX, entries also contain lists of
keywords and signatures (which can be queried).
The implementation has a graphical user interface for the convenient access,
insertion, and modification of bibliographic entries.
It is possible to convert entries or the complete database
into various formats, including standard BibTeX or XML.
The implementation uses various libraries, including a library for
[GUI programming in Curry](https://www.michaelhanus.de/papers/PADL00.html).
For further details contact 
[Michael Hanus](https://www.michaelhanus.de/).


## Chords

[Chords](https://www.curry-lang.org/pakcs/examples/chords.curry)
is an application of Curry in the area of music composition.
This system is able to generate appropriate chords for the accompaniment
of a given melody. There is also a
[report](https://www.michaelhanus.de/reports/LIFO-98-08.html)
which sketches the implementation and describes
the advantages of Curry to implement this application.


## CurryWeb

CurryWeb is an open system to support web-based learning.
Characteristic features of this system are openness
(i.e., no strong distinction between instructors and students) and 
self-responsible use (e.g., every user is responsible
for selecting the right material to obtain the desired knowledge).
The system supports the selection of material by
structuring all learning material hierarchically
and as a hypergraph whose nodes and edges are marked with
educational objectives and educational units, respectively.

The complete system is implemented in Curry
and exploits the various features of Curry, in particular, for
[HTML programming](https://www.michaelhanus.de/papers/PADL01.html).
There is also a
[paper](https://www.michaelhanus.de/papers/WFLP03_CurryWeb.html)
describing the ideas of this system in more detail.
For further details contact 
[Michael Hanus](https://www.michaelhanus.de/).


## Ecological simulation

This system simulates the ecological behavior of a river
depending on sewage running into different parts of the river.
The system together with an implementation of Curry
is described in the following master thesis (in Spanish):

[Santiago Escobar Román](http://www.dsic.upv.es/users/elp/sescobar.html):
Implementación de un lenguaje declarativo avanzado y su aplicación a la simulación del
ecosistema de una cuenca hidrográfica.
Facultad de Informática, Universidad Politécnica de Valencia, Spain, September 1998


## Grappa

A graph language can be described with a graph grammar in a manner
similar to a string grammar known from the theory of formal
languages.
Grappa is a library of functional logic GRAPh PArser combinators.
The Curry implementation (of the former Haskell implementation of Grappa)
provides two main benefits: Grammars can be
translated to quite efficient parsers in a schematic way. Furthermore,
parsers can be used as generators and for graph completion at the same
time.

Grappa has been used to implement a bi-directional transformation
between the business process modeling notation (BPMN) and executable
models of the business process execution language (BPEL).
The implementation of this transformation is available in the
[Curry package bpmn2bpel](https://cpm.curry-lang.org/pkgs/bpmn2bpel.html)
and the ideas behind this implementation are described in this paper:

S. Mazanek, M. Hanus:
[Constructing a Bidirectional Transformation between BPMN and BPEL with a Functional Logic Programming Language](http://dx.doi.org/10.1016/j.jvlc.2010.11.005)
Journal of Visual Languages and Computing, 22(1), pp. 66-89, 2011


## Module and Study Program Management

This is a system to manage module descriptions and study programs
for university curricula. The complete system is web-based, i.e.,
lecturers can describe their teaching units and collect them to
study programs via standard web browsers.
The system is in use at the
[University of Kiel](https://www.uni-kiel.de)
and can be accessed at the
[ModulDB website](https://moduldb.informatik.uni-kiel.de/).
The high-level libraries of Curry, e.g., for
[database programming](https://www.michaelhanus.de/papers/PADL08.html),
[type-safe web programming](https://cpm.curry-lang.org/pkgs/wui2.html),
and [web frameworks based on ER-models](https://www.michaelhanus.de/papers/PADL10.html)
were quite helpful to construct this application.
For further details contact 
[Michael Hanus](https://www.michaelhanus.de/).


## Recipe database

This is a system to manage a database containing recipes
(and references to recipes). It has a
graphical user interface for the convenient access, insertion, and
modification of recipes. Recipes will be automatically
converted into HTML format for providing WWW access to
the database and into LaTeX for formatting printing.
The implementation uses the
[GUI library](https://www.michaelhanus.de/papers/PADL00.html)
of Curry.
For further details contact 
[Michael Hanus](https://www.michaelhanus.de/).


## SOL

SOL is a web-based system to support practical assignments of courses,
e.g., it has been applied in computer science courses at the
[University of Kiel](https://www.uni-kiel.de/).
SOL provides web-based functionality for lectures, tutors (who correct
assignments), and students. Lectures can structure courses into units
that contain various assignments, e.g., multiple/single choice tests,
gap texts, programming tasks etc. Students can submit their solutions
to a learning unit which will be judged by tutors. Students can form
smaller learning groups to solve their tasks. Moreover, SOL contains a
message system to exchange information between students, tutors, and
lectures.

The complete system is implemented in Curry and exploits the various
features of Curry, in particular, for
[database programming](https://www.michaelhanus.de/papers/JFLP04_dyn.html)
and [HTML programming](https://www.michaelhanus.de/papers/PADL01.html).
For further details contact [Michael Hanus](https://www.michaelhanus.de/).


## Spicey: An ER-based Web Framework

Spicey is a framework to support the implementation of web-based
systems in the multi-paradigm declarative language Curry. Spicey
generates an initial implementation from an entity-relationship (ER)
description of the underlying data. The generated implementation
contains operations to create and manipulate entities of the data
model, supports authentication, authorization, session handling, and
the composition of individual operations to user
processes. Furthermore, the implementation ensures the consistency of
the database w.r.t. the data dependencies specified in the ER model,
i.e., updates initiated by the user cannot lead to an inconsistent
state of the database.  Further details can be found in the
[Curry package Spicey](https://cpm.curry-lang.org/pkgs/spicey.html)
which contains also references to papers on Spicey.


## Web Server Scripting

Several dynamic web pages have been implemented using Curry's
HTML library which is based on standard CGI features but exploits
the functional and logic features of Curry to support
the convenient and high-level implementation of web services.
There is also a
[PADL 2001 paper](https://www.michaelhanus.de/papers/PADL01.html)
which describes the ideas behind the design of
this library. For further details contact 
[Michael Hanus](https://www.michaelhanus.de/).


## Wine manager

This is a system to manage a (private) wine cellar.
It has a graphical user interface for the convenient access, insertion, and
modification of wines (structured into categories).
Wine lists can be converted into HTML and LaTeX format for
printing or offering wines in the web.
The implementation uses the
[GUI library](https://www.michaelhanus.de/papers/PADL00.html)
of Curry.
For further details contact 
[Michael Hanus](https://www.michaelhanus.de/).

:::
</section>
