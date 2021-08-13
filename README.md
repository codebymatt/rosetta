# rosetta
A Markdown to HTML translator.

**[April 15th 2021] This project is a work in progress.**

I've recently taken an interest in the syntax and semantics of programming languages, and would
like to explore some of the practices involved in writing one. Having said that, I don't want to
dive into writing a full featured programming language right now for various reasons.

With that in mind I'm going to start smaller with a translator that takes a Markdown source file
and outputs HTML. In an ideal world I'd use it as part of another project, but regardless of whether
I get that far I'm going to enjoy digging into the challenges involved.

My initial plan is to try and parse Markdown source into an abstract syntax tree of some sort, and then convert
that AST into HTML. I'll start with a *subset* of GitHub flavoured Markdown; I use GitHub's Markdown
on a near daily basis, and if I want to use this elsewhere I probably won't have need for a full
Markdown feature set.

## Markdown syntax
Rosetta will support the following features. For examples of what these look like in use,
visit [the GitHub Markdown Guide](https://guides.github.com/features/mastering-markdown/).
I'll mark each item as completed once Rosetta can convert them to its AST representation.

### Block level
- [x] Headers from 1-6
- [x] Numbered and bulleted lists, as well as sub lists
- [x] Quotes
- [x] Standalone code blocks
- [x] Block URL links
- [ ] Block image embedding

### Inline
- [ ] Bold, italic, strikethrough
- [ ] Inline URL links
- [ ] Inline code blocks
- [ ] Inline image embedding

### Possible future syntax
- [ ] Superscript
- [ ] Subscript
- [ ] Code block language types
