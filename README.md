# rosetta
A Markdown to HTML translator.

**April 15th 2021**
I've recently taken an interest in the syntax and semantics of programming languages, and would
like to explore some of the practices involved in writing one. Having said that, I don't want to
dive into writing a full featured programming language right now for various reasons.

With that in mind I'm going to start smaller with a translator that takes a Markdown source file
and outputs HTML. In an ideal world I'd use it as part of another project, but regardless of whether
I get that far I'm going to enjoy digging into the challenges involved.

My initial plan is to try and parse Markdown source into an abstract syntax tree, and then convert
that AST into HTML. I'll start with a subset of GitHub flavoured Markdown; I use GitHub's Markdown
on a near daily basis, and if I want to use this elsewhere I probably won't have need for a full
Markdown feature set.