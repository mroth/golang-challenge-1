Go Challenge 1
==============

My submission for [Go Challenge #1](http://golang-challenge.com/go-challenge1/).

Props to Matt Aimonetti, it was a _really_ fun code challenge, in particular the
reverse engineering stuff was a blast.

I usually don't post my code for exercises like this on GitHub but since this
one was so fun I wanted to encourage other people to try it out, so maybe this
will point a few more people at it.

A comparison with other languages
---------------------------------

That said, halfway through completing the challenge, I was feeling like Go
was not the ideal language (for me) to implement this particular problem in,
since I found myself _really_ wanting to reach for strong pattern matching
support.  So I also implemented a quick version in Elixir for comparison,
included in a secondary directory if anyone is curious.

I think the difference is fairly dramatic, in particular the Go version's
readability suffers from the having to manually implement error-bubbling, and
the lack of pattern matching makes certain parsing operations require extra
steps with conditional logic in between. (That is, assuming you grok pattern
matching and functional programming of course, otherwise the Elixir version is
probably much weirder looking to you.) It was definitely easier for me to write,
personally.

That said, different languages for different tasks and different tastes! I still
use Go for quite a bit, even if I don't always particularly love it. So no flame
wars please. :fire:


Grammar file for Synalyze It!
-----------------------------

I personally used Synalyze when reverse engineering the file format, I had never
used it before, but it seemed to work pretty well! I included my final "grammar"
file that describes the file format, you can use it if you want. Although I
highly recommend not using it and doing it on your own first if you are
attempting the challenge, the binary exploration is by far the most fun part!
([View Screenshot][screenshot] - CAUTION SPOILERS!).

[screenshot]: http://f.cl.ly/items/1c2F3y2J393l1X1q3e2O/splice_grammar.png


License
-------

As per the contest, all code here is licensed under Creative Commons.
