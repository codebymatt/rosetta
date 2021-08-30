# rosetta

A Markdown to HTML translator.

**[August 30th 2021] This project is a work in progress. I'm not writing it with other people's production use cases in mind, only mine. Keep this in mind if you decide to use it.**

[Gem available on rubygems.org](https://rubygems.org/gems/rosetta-ruby)

I've recently taken an interest in the syntax and semantics of programming languages, and would
like to explore some of the practices involved in writing one. Having said that, I don't want to
dive into writing a full featured programming language for various reasons, the primary one being
that I don't have any use cases where an existing language could not trivially satisfy my
programming needs.

With that in mind I've started smaller with a translator that takes Markdown source text
and outputs HTML.

At a very high level, Rosetta parses Markdown source into an abstract syntax tree, and then converts that AST into HTML.
I've started with a _subset_ of GitHub flavoured Markdown; I use GitHub's Markdown
on a near daily basis, and if I want to use this elsewhere I probably won't have need for a full
Markdown feature set.

I will only set the Gem version to V1 when I'm happy with the feature set, and when tests have been written.
If it's not 1.0.0 or greater, it's not finished and is subject to change!

## Markdown syntax

Rosetta supports the following features. For examples of what these look like in use,
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

- [x] Bold, italic, strikethrough
- [x] Inline URL links
- [x] Inline code blocks
- [ ] Inline image embedding

### Possible future syntax

- [ ] Superscript
- [ ] Subscript
- [ ] Code block language types
