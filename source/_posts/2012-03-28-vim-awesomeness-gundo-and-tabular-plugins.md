---
layout: post
title: ! 'Vim: Gundo and Tabular plugins'
description: "notes on some awesome vim plugins"
tags: [vim, tools, notes]
category: code
published: true
kind: article
comments: true
created_at: 2012-03-28 12:46:31 +05:30
---

Recently, I switched to MacVim in order to give VIM another shot. Since, then,
Vim has kept on amazing me with its feature set.

Learning from Vimcasts.org, I get to know the Gundo and Tabular plugins. This
post is a short excerpt of what they do and how they help me in my day to day
editing.

<!-- more -->

### Gundo

Traditional editors have a concept of undo-redo which is fairly simple - you
can do something - undo it and redo it, i.e. you can traverse on path `ABEFG`

VIM allows me to traverse the changes in a chronological manner, as well. That
is to say, I can even go to edits not in the same timeline, i.e. I am able to
traverse `ABCDEFG` as they happened.

``` text
          / `---------- C ---- D
A--- B -- |
          \,----------------------- E ----- F ------- G
```

We can use the `:earlier Nm` command to go back a few minutes (and even
seconds, hours, days). We can use `:GundoToggle` to view a quick Ascii tree of
our changes and compare the two edits in the vim timeline for undos

### Tabular

I can simply align my code using `:Tabularize /{pattern}`. For example, to
align assignments I can use something like `:Tab /=` and, if I prefer to keep
the spaces attached to the code on the left, I can use something like `:Tab
/=\zs` The effects will be as below:

``` ruby
# no tabularize
a = 1322
abc = 1323
abcde = 1324

# :Tab /=
a     = 1322
abc   = 1323
abcde = 1324

# :Tab /=\zs
a =     1322
abc =   1323
abcde = 1324
```
