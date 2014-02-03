---
layout: post
title: "easy oauth callbacks on localhost"
date: 2014-02-03 07:29
comments: true
categories: code
published: false
---

Most OAuth applications do not allow us to use domains like: `localhost:9292`
for oauth callbacks. While this is good for Production server, it is a real mess
while in development. O'course, I can spin up a Heroku instance, but that needs
me to push a commit and wait for rebuild every time I make some change and want
to debug the process. That doesn't cut it.

I looked around a while and found that I can do this easily by forwarding my
localhost ports on the internet using some service. And, I found `localtunnel`,
which effectively, does this. It allows me to pick up a port on my local
machine, and forward it so that it is accessible on the internet.

Installation is simple: `gem install localtunnel`.

Now, I have [Pow](http://pow.cx) installed on port `3100`, and I wish to serve
up 
