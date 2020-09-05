---
title: "Curry Analysis Server System"
---
<section>
:::md:max-w-3xl

Curry Analysis Server System
============================

:::
</section>
<section>
:::md:max-w-3xl

## Introduction

CASS is a tool in the
[PAKCS](http://www.informatik.uni-kiel.de/~pakcs/) and
[KiCS2](http://www-ps.informatik.uni-kiel.de/kics2) distributions
for the analysis of Curry programs.
CASS is generic so that various kinds of
analyses (e.g., groundness, non-determinism, demanded arguments) can
be easily integrated.  In order to analyze larger applications
consisting of dozens or hundreds of modules, CASS supports a modular
and incremental analysis of programs.  Moreover, it can be used by
different programming tools, like documentation generators, analysis
environments, program optimizers, as well as Eclipse-based
development environments.  For this purpose, CASS can also be
invoked as a server system to get a language-independent access to
its functionality. CASS is completely implemented Curry
as a master/worker architecture to exploit
parallel or distributed execution environments.

:::
</section>
<section>
:::md:max-w-3xl

## Usage

The analysis results computed by CASS can be accessed in various ways:

:::
</section>
<section>
:::md:max-w-3xl

### Batch mode
CASS is started with an analysis name and the name of the module to be analyzed.
Then this analysis is applied to the module and the results are printed.
This mode is useful to get a quick access to analysis information so that one can experiment with different abstractions,
fixpoint computations, etc.
For instance, the following command analyzes the groundness behavior of operations
of the module `rev` (here we assume that CASS is installed as part of
PAKCS or KiCS2 so that it is invoked via `curry analyze`):

___
```sh
> curry analyze Groundness rev
rev.append ground if arguments [1,2] are ground
rev.main always ground result
rev.rev ground if argument 1 is ground
```
___

:::
</section>
<section>
:::md:max-w-3xl

### API mode
If the analysis information should be used in an application implemented in Curry,
the application program could use the CASS interface operations to start an analysis and 
use the computed results for further processing. 
For instance, CASS provides an operation

___
```curry
analyzeGeneric :: Analysis a -> String -> IO (Either (ProgInfo a) String)
```
___

to apply an analysis (first argument) to some module (whose name is given in the second argument).
The result is either the analysis information computed for this module
or an error message in case of some execution error.

:::
</section>
<section>
:::md:max-w-3xl

### Server mode
If the analysis results should be used in an application
implemented in some language that does not have a direct interface to Curry,
one can start CASS in a server mode. In this case, one can connect to
CASS via some socket using a simple communication protocol that is specified
in the documentation of CASS and also sketched below.
The server mode of CASS is used in a recently developed Eclipse plug-in for Curry
(see [this master thesis ](http://www.informatik.uni-kiel.de/~mh/lehre/abschlussarbeiten/msc/palkus.pdf)).

The following figure shows some uses of CASS.

![](/assets/img/tools/cass/cass-ecosystem-scrshots-big.png "Cass Ecosystem Screenshot")
<!-- Pandoc generates adds a caption instead of an alt text when putting something in the [], using title instead -->

:::
</section>
<section>
:::md:max-w-3xl

## Server Protocol

To start CASS in the server mode, execute the command

___
```sh
curry analyze --server [ -p <port> ]
```
___

where an optional port number for the communication can be provided.
Otherwise, a free port number is chosen and shown.
In the server mode, it understands the following commands:

___
```sh
GetAnalysis
SetCurryPath <dir1>:<dir2>:...
AnalyzeModule          <kind of analysis> <output type> <module name>
AnalyzeInterface       <kind of analysis> <output type> <module name>
AnalyzeFunction        <kind of analysis> <output type> <module name> <function name>
AnalyzeDataConstructor <kind of analysis> <output type> <module name> <constructor name>
AnalyzeTypeConstructor <kind of analysis> <output type> <module name> <type name>
StopServer
```
___

The answer to each request can have two formats:

___
```sh
error <error message>
```
___

if an execution error occurred, or

___
```sh
ok <n>
<result text>
```
___

where the number `<n>` is the number of lines of the result text.
For instance, the answer to the command `GetAnalysis` is a list of all available
analyses. The list has the form

___
```sh
<kind of analysis> <output type>
```
___

For instance, a communication could be:

___
```sh
> GetAnalysis
< ok 5
< Deterministic CurryTerm
< Deterministic Text
< Deterministic XML
< HigherOrder   CurryTerm
< DependsOn     CurryTerm
```
___

The command `SetCurryPath` instructs CASS
to use the given directories to search for modules to be
analyzed. This is necessary since the CASS server might be
started in a different location than its client.

Complete modules are analyzed by `AnalyzeModule`, whereas
`AnalyzeInterface` returns only the analysis information of
exported entities. Furthermore, the analysis results of individual functions,
data or type constructors are returned with the remaining analysis commands.
Finally, `StopServer` terminates the CASS server.

For instance, if we start CASS by

___
```sh
cass --server -p 12345
```
___

we can communicate with CASS as follows (user inputs are prefixed by `>`);

___
```sh
> telnet localhost 12345
Connected to localhost.
> GetAnalysis
ok 42
Overlapping XML
Overlapping CurryTerm
Overlapping Text
Deterministic XML
...
> AnalyzeModule Demand Text rev
ok 3
rev.append demanded arguments: 1
rev.main no demanded arguments
rev.rev demanded arguments: 1
> AnalyzeModule Demand CurryTerm rev
ok 1
[(("rev","append"),"demanded arguments: 1"),(("rev","main"),"no demanded arguments"),(("rev","rev"),"demanded arguments: 1")]
> StopServer
ok 0
Connection closed by foreign host.
```
___

:::
</section>
<section>
:::md:max-w-3xl

## Web Demo Installation

If you want try CASS on simple programs via a web interface,
you can use the
[Web Demo Installation of CASS](http://www-ps.informatik.uni-kiel.de/~mh/webcass/main.cgi).

:::
</section>
<section>
:::md:max-w-3xl

## Further Information

More details about CASS and how to implement new analyses
with CASS can be found in the following paper:

**[A Modular and Generic Analysis Server System for Functional Logic Programs](http://www.informatik.uni-kiel.de/~mh/papers/PEPM14.html)**
(PEPM 2014, [longer version](/assets/files/tools/cass/cass_paper.pdf))

A [previous version of this paper](http://www.informatik.uni-kiel.de/~mh/papers/CICLOPS13.html)
has been presented at the
13th International Colloquium on Implementation of Constraint and Logic Programming Systems
(CICLOPS 2013).

:::
</section>