---
layout: post
title: "Finally. A self-hosted Gitlab instance!"
date: 2013-10-26 13:26
comments: true
categories: code
---

Alright. I seem to be pretty happy today. I think any stupid developer, like me,
would be in the given circumstances. If you are aware about the existance of
a very nifty witchcraft named [Github](http://github.com), then, I am sure you
will be equally happy for me.

**Github is magic**. *A protective one.*

For those unaware, Github is a code hosting platform. It allows me to write my
code and then, keep it safe and versioned in their platform. That way, my code
is always there for me. I can share code with other developers, as well as
*fork* their work and modify it, locally. And, so on. The cool thing is that the
service is really amazing and free for open-source projects.

<!-- more -->

However, there are times when a person needs some privacy, even with the code,
he writes. Especially, with the code, he writes. I, often, used Github's private
repositories for this purpose. But, with a recent project, I was aiming to
create around 100 different private repositories, which was a bit unmanageable
with Github. I know, I know. I must not need that much private repositories.
But, what can I do about it if the project specification itself demand for the
same.

Therefore, I began looking at private repository hosts, and
[BitBucket](http://bitbucket.org) seemed to be off, for some reasons. Finally,
I settled on using [GitlabHQ](http://gitlab.org) for my purposes. It offered
everything Github had to offer, and more. More in the sense, that I can host
things privately on my own server. Perfect.

And, since I was already using [DigitalOcean](http://digitalocean.com) for
hosting my server, and was using Ubuntu 12.10 as my operating system, it became
really easy to install Gitlab on my server. Followed [this
tutorial](https://www.digitalocean.com/community/articles/how-to-set-up-gitlab-as-your-very-own-private-github-clone)
from DigitialOcean's community tutorials, and I was up and running with my own
private repository server.

I was, further, planning to install [Gitlab CI](http://gitlab.org/gitlab-ci) on
my server, but that seemed to be an overkill, since I do not think I will need
continuous integration for my private projects, and for public projects, we have
another awesome witchcraft named [Travis CI](http://travis-ci.org).

O'course, you can test drive this on [Git @WickedDevelopers](http://git.wickeddevelopers.com).    
Happy, code browsing!
