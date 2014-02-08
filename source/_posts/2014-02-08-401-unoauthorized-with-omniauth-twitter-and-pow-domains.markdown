---
layout: post
title: "401 unoauthorized with OmniAuth Twitter and Pow domains"
date: 2014-02-08 06:06
comments: true
categories: rails
---

As stated a few posts back, I have switched to using [Pow](http://pow.cx) for
managing my hosts configuration.

Recently, I was using `omniauth-twitter` to authenticate a client for my Rails
application. When trying to access the application's oauth url for twitter, i.e.
`/auth/twitter` via the pow based domain I was getting a `401 unauthorized`
error, while accessing it via the Webrick's `http://localhost:3000` worked fine.

I was scratching my heads over the reason, when I noticed that I was using
Environment variables in my provider definition, and I wondered probably Pow
does not have access to these variables? I use `dotenv` and was pretty sure
webrick had access to these Environment variables.

So, I googled for a while and found that Pow actually does not have access to
`dotenv` based variables. Instead, it does allow setting them via a `.powenv`
file. Therefore, I ran the following commands to configure all this from my
Rails' root path:

```bash
echo 'export TWITTER_KEY=<MY-TWITTER-KEY>' >> .powenv
echo 'export TWITTER_SECRET=<MY-TWITTER-SECRET>' >> .powenv
touch tmp/restart.txt
```

And, voila! I can now access my oauth workflow, simply.
