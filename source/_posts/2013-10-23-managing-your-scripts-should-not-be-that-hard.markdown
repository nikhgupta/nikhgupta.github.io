---
layout: post
title: "managing your scripts should not be that hard"
date: 2013-10-23 01:46
comments: true
categories: [personal, code]
---

I am, often, found creating simple scripts to automate one or the other part of
my life. Most of the times, I would use a combination of project managers, task
managers, automation tools, and so on to do the tedious work for me. But, at the
other times, it is simply so much more easier to give my inner geek a kick in
the butt and start writing some code which will explicitely be used by me to
handle such one off tasks.

<!-- more -->

The Problem
-----------
But, here comes the irony, no matter what I try, I end up either misplacing
these little snippets of code, or otherwise it becomes so much tedious to
collect and keep them in an organized manner. Not to mention, the really
annoying part of creating aliases to these nice snippets and then, forgetting
what aliases you, currently, have. Oh, did I mention, I have to keep them online
in a Git repository, so that they are always versioned and sharing them is easy?
And, what if I am booting a new server or working on some other one-time
machine, it would kill me to do a clone of this repository, and then run them
via their full paths, and what if the script does not work on this new machine,
or what if I had to leave meanwhile?

Let me have a quick answer: it is not the 1990s, where the above issues
classified as a GNU license, and nor it is the 2000's, when I did not know how
to create an app dedicated for my own purposes.

The Solution
------------
The solution? It's easy. Search for an existing solution or roll out our own.
Unfortunately, I was unable to find an existing solution (or, atleast, I will
pretend the same), and therefore will be rolling out my own, with the following
features:

- Has a client side gem that can be used to list a user's scripts, and allow him
  to copy them in a folder on his machine, and assign aliases to these scripts
  on the go.
- The gem should be able to search for scripts based on some keywords.
- User should be able to have CRUD rights over their scripts. They should be
  able to share these scripts, as well as export them. They should be able to
  reference another script inside the script they are creating.
- All the scripts would be created use Github Gists, and hence, be versioned.
- The application should provide an interface to write (and, probably, test) the
  scripts on the server, itself. Provide a dedicated backend to the user?
- The users should be able to run the scripts on their server via the app
  interface, once they have the SSH authentication established? This is not as
  straight-forward, since the app server will be the one connecting to the
  user's server and hence, it is not safe.
- Scripts should have a unique programming structure, which identifies their
  requirements and alike, and notifies the user about the same.
- Logging should be done on cloud for output of the scripts.
- Scripts should be marked as safe based on their MD5 hash, kinda like thor
  does for its installed scripts.
- Scripts should be intelligent in telling the user when the runtime is not
  available, e.g. the user tries to run a ruby script on a server with no-ruby
  installed.
