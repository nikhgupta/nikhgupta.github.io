---
layout: post
title: Getting Started with Ruby and Rails..
description: my thoughts on ruby and rails community
tags: [rails, article]
category: code
published: true
kind: article
comments: true
created_at: 2012-03-19 12:46:31 +05:30
---

Okay, so past an year I have been trying to switch into RubyOnRails for
various reasons - and yes, they are numerous. I wanted to work less with the
*how-tos* and instead, wanna work more with *what-i-want-next* when I develop
applications for myself. I wanted to make use of those gorgeous little gems
that will fit in so nicely with my Ruby code - I wanted to develop business
logic instead of behavior (think devise, paperclip, clearance, and so on) and
then, I, also, wanted to make use of some of the awesome assistants the rail
community has for their everyday tasks (think capistrano, cucumber, and so
on).

<!-- more -->

Now, I do understand that the language (or I should say Syntax) is easy to
learn and gorgeously, so.

``` php
# Think PHP:
if (!empty($my_variable)) do_this();
```

``` ruby
# v/s Ruby:
do_this if my_variable
```

But, then again, learning RubyOnRails has been a tough job. Primarily, due to
the steep learning curve on *how-to-get-started-with-ruby-on-rails* frontier.

Fortunately, for me, I have been a `shell` guy - I, absolutely, adore shell
and rely on it for much of the repetitive tasks, everyday - kinda to the
extent that, iTerm.app is the most frequently used application on my Mac, just
like every other developer, who understands the sheer power shell puts in our
hand ;) (Not to mention, `git` is involved in almost all my projects)

So, I went on and installed RVM and loaded it with Rubies and Gems and what
not, and I have been using this setup from quite a long time - just not enough
to actually start building some awesome application.

This was partly due to the fact that, whenever I needed to make some
application for a client, I would go in and start building it with CakePHP
rather. Probably, the simple reason being I wanted to get on with creating the
application, instead of learning a framework which will create the
application, afterwards. I did not *really* wanted to invest the time into
RubyOnRails.

But, alas! we are humans - and, that makes us unsatisfied with whatever little
satisfaction, we might have, by chance. And, I wanted to dwell inside
RubyOnRails world, yet, again. But, this time, I really wanted to go all out
and give it a good fight and either win or lose, but have an outcome at once.

I know, most of us would never go in the step-by-step-of-learnings-steps and
jump to things we don't quite understand - which is nice, but may often, force
you to give up on things - which is what used to happen with me. So, this
time, I decided to go slow - learnings things one step at a time - and follow
screencasts and tutorials, with all my heart.

Oh, and did I tell you? It was just not enough! I wanted to know if I can use
Vim to be more productive? And, hence I got myself a shiny new MacVim.app to
learn along with (and, I must say its been around 3 weeks and I am more than
happy with what I can do with Vim).

Well, coming back to RubyOnRails, I started with the famous `_why` tutorial at:
tryruby.org and man! that definitely, did help me a lot (as an example,
earlier I was never aware why some methods had an exclamation in ruby at the
end). So, the first step would be to *really* know things work in Ruby. And,
TryRuby.org helps with that when you are starting out in Ruby.

Next, I started watching a few screencasts on getting started with RubyOnRails
(note that, I wanted to learn things from the basic - just so that, I am sure
I have my basics all covered up - also, note that I have already gone through:
[Michael Hartl's awesome RubyOnRails
book](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book)), and
finally, I was really inspired by [this particular
tutorial](http://net.tutsplus.com/tutorials/ruby/the-intro-to-rails-screencast-i-wish-i-had/)
which really explained things a lot, and not to mention the [Rails for
Zombies](http://railsforzombies.org) session.

Within a short time, I was up and running with an application I could use to
tweak and learn all-things-rails! However, this is not simply what I wanted.
I wanted to learn new ways - the tools - wanted to learn BDD, easy
deployments, and things alike.

So, I next started learning how to use capybara for my BDD needs. BDD is
awesome - since I can simply write what I wanted and every time I could just
look up what test is failing and write the code for it - it keeps me on track
with what needs to be done next, and while doing so definitely, takes away the
pain associated with manually testing the application. I guess, the Rails
Introduction tutorial I mentioned above, also, deals with setting up Capybara
with RSpec for testing purposes.

Soon, I found out using Cucumber will further help me be more expressive, and
concise while being forgiving on my clients. So, I started finding out how to
integrate Capybara with Cucumber and [this
screencast](http://net.tutsplus.com/tutorials/ruby/ruby-for-newbies-testing-web-apps-with-capybara-and-cucumber/)
really helped me along with Google searches.

So, now I had Cucumber working along with Capybara, but yet I have always
loved the work done by [ThoughtBot Studio](http://thoughtbot.com/community/)
and wanted to utilize Factory Girl in my tests - so, I started searching and
I guess [this is the
post](http://collectiveidea.com/blog/archives/2010/09/09/practical-cucumber-factory-girl-steps/)
that really helped me with getting Factory Girl fixtures to work with my
Cucumber features.

At the end, I would say:

> I am very new to RubyOnRails world, and wanted to simply pen down my
> thoughts about this awesome community at around 6 AM while I am all
> exhausted. I would keep updating this post with my thoughts on how I am
> learning things in the RubyOnRails world.
