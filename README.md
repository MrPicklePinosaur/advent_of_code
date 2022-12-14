
<div align="center">

# advent of code 2022

Solving AoC 2022 with a different programming language every problem

</div>

# Rules

This year for AoC 2022 I impose an additional constraint that a different
programming language must be used per question. In additional, this programming
language should ideally be one that I do not know, or know very little of. I
plan to use this as a chance to try languages I haven't gotten around to
learning (like ruby), archaic languages (smalltalk) or completely cursed models
of computation (c preprocessor or sed).

# Questions

- [x][ ] [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1) Haku
- [x][x] [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2) Raku
- [ ][ ] [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3) Sed
- [x][x] [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4) Smalltalk
- [x][x] [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5) WebAssembly
- [ ][ ] [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) Latex
- [x][x] [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7) Vimscript
- [ ][ ] [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) OCaml

# Writeup

## Day 1

Haku is quite an interesting language to write. Unfortunately I ran into a ton
of issues with the Haku interpreter. First of all (on my machine), it is
_incredibly_ slow, taking a couple minutes to run the most simple of code. This
made the development cycle painfully slow. Worse, I'm not sure if my version of
Raku (language Haku interpreter is written in) is wrong or something, but I
found myself having to fix multiple issues in the interpreter myself, like the
code for comparisons or the code for reading a file.

In the end, this question took me very long to complete. It felt like I was
debugging the language more than working on the question.

However, I loved the idea of a natural language programming language and might
try re-implementing Haku in something like Haskell later.

## Day 2

After Haku, I decided to check out Raku, the language used to write the
interpreter for Haku. The question was perhaps a bit too easy to cheat on
(hardcode the solutions), so I did not get to explore very many features of
Raku. The syntax does feel a bit cute (lots of symbols) and I feel that you can
write some really concise programs if you are good.

Will consider coming back to Raku for text processing tasks.

## Day 3


## Day 4

Smalltalk is interesting. The syntax and core ideas (message passing) feels a
bit different to modern languages. It's pretty interesting exploring older
languages to see what has inspired the languages that we use today. Overall
this question was not very hard, most of the work was trying to figure out the
syntax of the language.

It might be cool to explore other 'outdated' languages for future questions.

## Day 5

Wasm needs to be executed by some javascript, so some node.js is used to write
some wrapper code. Furthermore, since wasm has no i/o capabilities, we need to
cheat a bit and pass some node functions to wasm. However, I have limited
myself to only i/o functions and not any other javascript utilities (like
string manipulation functions).

Ended up spending quite a bit of time stuck since I was using the
`load` instruction which loaded 4 bytes instead of `load8_u` which
loads a single byte to read characters from the input.

This question ended up being really time consuming (and tedious) since web
assembly is such a low level language. Web assembly has much more modern syntax
(s-expressions), so it is a bit more readable than something like x86 assembly.

Resources
- [WebAssembly OpCodes](https://pengowray.github.io/wasm-ops/)

## Day 6

This exercise has given me a buring hate for latex :P.

Apparently LaTeX's programming ecosystem was so ugly and messed up it required
the formulation of a so called LaTeX3 that attemps to unify the syntax.
Admittedly it is much better but it is still very frustrating to program in.
The syntax is clunky and verbose, and most of all debugging errors are very
very frustrating. This is since running the program is equivalent to compiling
a pdf. There are also a whole bunch of weird behaviors like variable scoping
and how parameters are passed to functions that took me a bit to figure out.

I salute those that are actually able to write packages for LaTex since for me
doing such a simple task was already enough to end me.

Currently on hold since I can't get LaTex to read file character by character,
I suspect it's dying trying to read such a long line in.

Resources
- [Programming LaTeX3](https://www.texdev.net/2014/02/02/programming-latex3-a-summary-so-far/)
- [LaTeX3: Programming in LaTeX with Ease](https://www.alanshawn.com/latex3-tutorial/)

## Day 7

After the LaTeX 'adventure', I'm pretty glad to have a (semi) sensible
programming language to work with again.

Resources
- [Learn Vimscript in Y Minutes](https://learnxinyminutes.com/docs/vimscript/)
- [Learn Vim the Smart Way](https://learnvim.irian.to/)

# Languages to use

list of languages that I am considering on using for future problems
- BASIC
- vimscript
- tex
- c preprocessor
- sql
- scratch
- ruby
- erlang
- ocaml
- haxe
