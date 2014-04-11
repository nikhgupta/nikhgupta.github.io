---
layout: post
title: "a rubyist's attempt on working with python - setup and first notes"
date: 2014-04-11 07:42
comments: true
categories: code
---

I never really needed to look for another language to learn once I was acquinted
with ruby some years back. I love it, and I really do. It provides clean code
which does what it reads - it feels like the language was written for me, which
was infact the idea behind ruby - a language made for developers.

But, anyways, I am giving Python another try for with hopes that it will be
fruitful for me to learn the language. It has been, I think, 2-3 years since
I last tried the language for some time, briefly. I have learned a lot in that
duration in the Ruby world. And, I am hoping, if nothing else, this attempt at
Python will make me a better rubyist. This post describes my notes on setting up
a development environment for Python on OSX 10.8 (Mountain Lion), and some
initial learning intakes.

<!-- more -->

Installation
------------

I preferred not to use the Python distribution that comes with OSX for my dev
needs, which most Pythonista will agree with. The reason is simple - I do not
want the system based Python to get corrupted while my dev percussions, and is
the same reason why I use `rbenv` for Ruby development.

So, I looked at some tutorials regarding this, and found that the good old
`homebrew` that I love has again come up with a rescue. Moreover, it provides me
with `pip` and `setuptools`, which is really great.

```bash
# Installs Python 2.x
brew install python --with-brewed-openssl
# Links some of the Python Dev. utilities to /Applications directory.
brew linkapps
```

Alright, so next we need a version control system, for which `mercurial` is
happily recommended in many tutorials, but I love my VCS and I am not going to
part away from it - I am loyal to it - `Git`.

Finally, lets install `virtualenv` which creates virtual isolated environments
for our Python projects, kinda like `rvm` in Ruby world.

```bash
pip install virtualenv
pip install virtualenvwrapper
```

Next, I do not want to run `pip` command against the system python and overwrite
or update a needed library. So, I will tell `pip` to only instally anything, if
we are in a `virtualenv` based environment. Add the following two lines to your
`~/.bashrc`, or `zsh` configuration file (or, whatever else you use):

```bash
# pip should only run if there is a virtualenv currently activated
export PIP_RESPECT_VIRTUALENV=true
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
```

Now, trying to install a package without a valid `virtualenv` will give an error
that says: 

```bash
~ ➲ pip install markdown
Could not find an activated virtualenv (required).
```

If you want to use `pip` for the system based Python, you can add a function
like this in your bash/zsh configuration file:

```bash
syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
```

Create a new virtualenv, using:

```bash
virtualenv test_project
cd test_project
. bin/activate
```

The Editor
----------

Although, there is a really good `PyCharm` editor available for Python, I will
still try and stay with my editor of choice: `Vim`, which is really
magnificient. However, in the upcoming days, I can install and add various
python based features for my vim editor.

Epilogue
--------

I have decided to write a separate blog post on what I find inside Python. Will
soon write up about it.
