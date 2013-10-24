---
layout: post
title: "Back with a Bang!"
date: 2013-10-22 06:21
comments: true
categories: personal
---

Oh, yes! I am, definitely, back - with a bang! Before, an interpretion is made
on the word, you ought to know about `!#`: [Shebang](http://en.wikipedia.org/wiki/Shebang_(Unix).

First, let me talk about **Writing** - a habit that I have cultivated over time,
and a strong case can be made for the fact that it is one of the rarest
recreational stuff that I do and preach to my friends. It can be really helpful,
and at the same time, can take you to an n-dimensional hyperspace, where you can
imagine nearly anything you want to believe or create. Not only that, for me,
writing is a process to jot down those pesky little thoughts (hundreds of them)
that roam inside my mind like ants near a sugar cube. I, usually, keep
a personal diary where I am able to write these things down, but then, I am
craving for some social interaction (online, to be precise) and maintaining
a steady blog can really help with that.

<!-- more -->

Anyways, I write here. And, I write rarely as per the reasons stated above. But,
I am thinking to make a switch - give it a try. I won't be writing anything
personal, but atleast, I will be trying to make a steady attempt at posting once
per day - on coding, particularly.

Coming back to the *bang*, anyone who knows will agree that I live in code.
**Shebang** is probably the first thing that crosses my mind when I wake up, and
definitely, the last when I sleep. But, these days, I am leaning towarding
combining the two. That can either be done via [Literate Programming](http://en.wikipedia.org/wiki/Literate_programming)
(when coding), or otherwise, writing about code (when writing).

In order to accomplish the above goals, I have setup a new blog at the current
address - with only a few posts from the past. I am using [Octopress](http://octopress.org),
and yes, I chose it over [WordPress](http://wordpress.org), again.

Reasons for switching are really simple:

- Comfort of using [Vim](http://www.vim.org) or
  [Emacs](http://www.gnu.org/software/emacs/) to write my posts. In particular,
  [Emacs' Org mode](http://orgmode.org) is a godsend for writing your thoughts.
  I have been using it since last 2 months or so, and I am pretty confident with
  it, now.
- Posts are versioned and securely stored inside a Github repository.
- Site is served via Github pages, which in turn means, safer hosting. I am
  always experimenting with my hosting server, and often time, I am able to blow
  it up. Hosting my site on Github ensures that it is free from such
  manipulations and always served nicely.
- It, just, feels more appropriate. :)

So, I used the [GreyShade](https://github.com/shashankmehta/greyshade) theme
from [Shashank Mehta](http://shashankmehta.in), a fellow IIT guy (yeah, I have
served my time at IIT Delhi, too :P) and, gave it a simple spin to roll out with
the current version. I must say, he has done a really good work with the
Octopress theme and definitely, deserves a kudos!

Now, the site is all up and running and I, quickly, want to jot down a few tasks
that I am committed for this month:

- Migrate old posts from various sources to the current blog.
- Redirect old blog's links to the current blog.
- Improve upon the current website design.
  - The header hover should occur when hovering over the picture and not when
  	hovering over the header, itself. This is a bit difficult in pure CSS3,
  	since that defies the `cascading` rule of CSS, and instead, tries to modify
  	the parent from the child.
- Write a post daily on the current website, preferably, about coding in ruby.
- Setup org mode in Emacs, so that I can write my blog posts using it.
- Create a few basic public APIs:
  - an API that lists words matching a given pattern.
  - a WhoIs API that also, lists available domains matching a given pattern.
- Create a few basic applications using RoR:
  - a domain searching application, somewhat like [domai.nr](http://domai.nr)
  - an application that makes it easy to run scripts on servers (have detailed
  	specifications listed in a separate personal diary)
