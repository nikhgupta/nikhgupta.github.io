---
layout: post
title: 'Vim as PHP IDE: Ctags, and Code Browsing'
description: "learn what vim can do for your PHP based needs :)"
tags: [cakephp, vim, php, notes]
category: code
published: true
kind: article
comments: true
created_at: 2012-04-01 17:26:11 +05:30
---
So, past few weeks, I have been really fascinated with the all powerful Vim.
And, I often wonder why: I took so much time switching to it? Probably, the
steep learning curve! It has to be.

Anyways, so I have really really progressed with Vim this time, as compared to
my earlier trials. I am quite efficient with Vim now - even writing this blog
post on it. I know how to move quickly, make efficient uses of search and
replace, using Vim scripts etc. I have really really found plugins like
Gundo, Fugitive, Tagbar, Syntastic, Snipmate, NerdTree, and Powerline to be
useful and not to mention plugins like Vim-Rails which make my day-to-day
tasks easier with a particular language. Oh, and did I mention the incredible
`!` and `@` operators? They just rock!

But, well. This post is about using Ctags with Vim to make Vim feel more like
an IDE and readily use Source Code Browsing within frameworks, large code
projects, etc. Here, in this post, I have specified my configuration/process
for using Ctags with MacVim for a CakePHP based project.

<!-- more -->

### The Process

Well, I would try to create my Ctags on the fly, using Git hooks. This lets me
simply checkout, merge or commit to a branch and my tags would be generated
for the code in question. Moreover, these Ctags generated files are stored
inside `.git` directory, which keeps our repositories clean (no need to add
a file to `.gitignore`). Also, I would prefer a centralized place where I can
manage any script I use to create these Ctags, and hence, if after about an
year I think I need a change in the way script is working, or if say I want to
add support for or remove support for a language, I should be able to do it
from a single place and affect all my git repositories using these Ctags
hooks.

For this to work, i.e. for Vim to pick up our Ctags (that will be created in
`.git/tags` file) we need to have `Fugitive` installed (which I will really
really recommend anyways). This will make Vim look for Ctags in a `.git/tags`
and `.git/<lang>.tags` file in our repository, irrespective of the current
working directory.

Let   s set up a default set of hooks that Git will use as a template when
creating or cloning a repository (requires Git 1.7.1 or newer):

``` bash
git config --global init.templatedir '~/.git_template'
mkdir -p ~/.git_template/hooks
```

I, usually, put all my Git related stuff in `~/Code/__dotfiles/git/` and
hence, the above template directory lands up as
`~/Code/__dotfiles/git/template/` with all the hooks, in my
[.dotfiles](http://github.com/nikhgupta/dotfiles) repository.

Now onto the first hook, which isn't actually a hook at all, but rather
a script the other hooks will call. Place in `~/.git_template/hooks/ctags` and
mark as executable:

``` bash
#!/bin/sh
rm -f .git/tags ctags --tag-relative -Rf.git/tags \
  --exclude=.git --languages=-javascript,sql
```

Although, make sure that the `ctags` version is the GNU one, and the above
script runs without showing any errors. If installing via `Homebrew` make sure
that the `which ctags` command shows the correct `ctags` executable path.

Making this a separate script makes it easy to invoke `.git/hooks/ctags` for
a one-off re-index (or `git config --global alias.ctags '!.git/hooks/ctags'`,
then `git ctags`), as well as easy to edit for that special case repository
that needs a different set of options to ctags. For example, I might want to
re-enable indexing for JavaScript or SQL files, which I've disabled here
because I've found both to be of limited value and noisy in the warning
department.  And, in these edge cases, all I need is to modify the
corresponding `.git/hooks/ctags` script in that git repository. Neat and
clean.

We still need to create the actual hooks that the Git will copy to all
repositories that are (re)initialized using the `git init` command.  All the
files in the `~/.git_template/hooks` folder needs to be marked as executables.
You should use the following content for: `post-commit`, `post-merge`, and
`post-checkout` hooks (which simply calls the `ctags` hook, we create above):

``` bash
#!/bin/sh
.git/hooks/ctags >/dev/null 2>&1 &
```

Additionally, if you feel tags should also be generated on using `git rebase`,
add the following code to `post-rewrite` hook:

``` bash
#!/bin/sh
case "$1" in
  rebase) exec .git/hooks/post-merge ;;
esac
```

Once, the above is done, all we need to do is to issue a `git init` command to
create Ctags for an already existing repository. All new git repositories will
automatically include these hooks and hence, will create the Ctags file on the
fly. Pure Automation. ;)

### Global Projects

There are some projects that I always want available for source code browsing
like the Rails source code itself. For such projects, I would generally run
a one-off shell script that does this work for me, and store the generated
tags file in a directory such as `~/.tags/` with a suitable name. O'course it
does not make sense to version this directory.

``` bash
#!/usr/bin/env sh

RubyVersion="1.9.3-p194"
LaravelPath="${HOME}/Code/projects/lab/laravel"

mkdir -p "${HOME}/.ctags"

# RVM: Ruby version 1.9.3-p194
if [ -n "${RubyVersion}" ]; then
  mkdir -p "${HOME}/.ctags/ruby/${RubyVersion}"
  TAG_FILE="${HOME}/.ctags/ruby/${RubyVersion}/tags"
  rm -f "${TAG_FILE}"
  for rubydir in `find "${HOME}/.rvm/gems" -type d -depth 1 -iname "*${RubyVersion}*"`; do
    if [ -d "${rubydir}/gems" ]; then
      echo "Looking inside: ${rubydir}/gems"
      ctags --recurse --tag-relative \
        --languages=-javascript,sql \
        --exclude=.git \
        --sort=yes --append \
        -f "${TAG_FILE}" \
        $rubydir/gems/*
    fi
  done
  echo
  echo "------ generated ctags for: ${RubyVersion} ------"
  cat "${TAG_FILE}" | wc
  echo "---------------------------------------------"
  echo
fi

# Laravel
if [ -n "${LaravelPath}" -a -d "${LaravelPath}" ]; then
  mkdir -p "${HOME}/.ctags/php/laravel"
  TAG_FILE="${HOME}/.ctags/php/laravel/tags"
  rm -f "${TAG_FILE}"
  echo "Looking inside: ${LaravelPath}"
  ctags --recurse --tag-relative \
    --languages=-javascript,sql \
    --exclude=.git \
    --sort=yes --append \
    --PHP-kinds=+cf \
    --regex-PHP='/abstract class ([^ ]*)/\1/c/' \
    --regex-PHP='/interface ([^ ]*)/\1/c/' \
    --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/' \
    -f "${TAG_FILE}" \
    $LaravelPath
  echo
  echo "-------- generated ctags for: Laravel -------"
  cat "${TAG_FILE}" | wc
  echo "---------------------------------------------"
  echo
fi
```

Finally, I set the following inside my `~/.vimrc` file:

``` vim
set tags=./tags;/
augroup TagFileType
  autocmd!
  autocmd FileType * setl tags<
  autocmd FileType * exe 'setl tags+=~/.ctags/' . &filetype . '/*/tags'
augroup END
```

This basically tells vim to only load ctags for the current filetype, i.e. for
a `ruby` buffer, vim will load all ctags files inside `~/.ctags/ruby`
directory, and no ctags file inside `~/.ctags/php`

### Epilogue

(Now, that I have completed writing the post and I read it again, it seems
that this post feels like a rewrite [a post by tPope](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html). Well,
I was originally thinking of a different way to create these Ctags, but as
I went deeper and deeper, I realized that what
[tPope](https://github.com/tpope) describes is so natural and easy, that
I have to ditch whatever it is - what I was doing now. And, do not forget,
I am less than a month old with Vim and I am talking Ctags with Vim.  I am
allowed to reherse my steps :P )
