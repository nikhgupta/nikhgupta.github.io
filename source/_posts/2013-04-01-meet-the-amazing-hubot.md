---
title: Meet the Amazing Hubot
created_at: 2013-04-01 17:03:34 +0530
description: My own little J.A.R.V.I.S. simulation
kind: article
layout: post
published: true
comments: true
tags: []
---

Recently, I came across [Hubot](http://hubot.github.com) - the amazing bot
from [Github](http://github.com), which lets me do nearly anything while
talking to it. Some of the examples being querying my site for availability,
tracking down how many visitors I had in last 24 hours, updating my twitter
status, grabbing tasks from my basecamp projects, and so on.

Currently, I am using Hubot on [HipChat](http://hipchat.com) and GTalk, but as
my team frequently uses Skype, I will be enabling a Skype adapter for it,
pretty soon (the Skype adapter, in particular, can not be installed on
[Heroku](http://heroku.com)). The Hubot instance runs as _Edwin Jarvis_, as
I always wanted to have something close to the esteemed J.A.R.V.I.S. from the
movie Iron-Man.

<!-- more -->

Installing Hubot
================

Here is a brief overview for anyone wanting to get started with Hubot:

  * Install [Node.js](http://nodejs.org)
  * Clone the hubot repository from github, locally:

``` bash
git clone http://github.com/github/hubot jarvis
cd jarvis
npm install
bin/hubot
```

This should start the Hubot in your Shell. If, instead, this gives an error
saying `redis` was not found or something similar, make sure to remove
`redis-brain.coffee` from `hubot-scripts.json` file, and try running again!

Using Multiple Adapters
=======================

Ok, so running Hubot locally is good - we can see what it does, we can test
out our code/scripts, etc., but the real power of hubot lies in running it
over a chat server, so that it acts like ChatOps - you can virtually do
anything online by simply talking to the Hubot (think: deploying your code).

Since, [Hipchat](http://hipchat.com) now provides a free plan for upto
5 users, it stands ideally as a Chat server for our needs (we are a small
team). Additionally, GTalk serves as a quick access to our bot, since it is
always open via either the GMail browser tab, or via some chat client.
However, there is a sligh problem. Hubot doesn't currently support multiple
adapters, i.e. we can't tell hubot to run on both Hipchat and Gtalk,
simultaneously, while using the same source code. But, why use the same
source? Why not make another hubot to run on GTalk? Well, I use a lot of
scripts - some are custom - and it is a pain to update two sources to make the
two hubots use the same set of scripts. Therefore, I implemented the following
procedure to let the two hubots use the same source:

  * First, create new dedicated accounts for our hubot on both Hipchat and
  Gtalk.
  * Add `hubot-hipchat` and `hubot-gtalk` as dependencies in `package.json`.
  It should look like:

``` json
"dependencies": {
    "hubot-hipchat": ">= 2.4.5",
    "hubot-gtalk": ">= 0.0.1",
    ...
}
```

  * Edit `Procfile` so that it uses adapter name and user from the environment
  variables that we will create for the heroku instance of each bot:

``` bash
web: bin/hubot -a $HUBOT_ADAPTER_NAME -n $HUBOT_ADAPTER_USER
```

  * Create a git repository for our bot, so that we can track our bot's code:

``` bash
git init
git add .
git commit -am "Initial Commit"
```

  * Download and install [Heroku Toolbelt](http://toolbelt.heroku.com), since
  we will be deploying our bots to Heroku.

  * Let us, first deploy our bot on GTalk, since it is a bit easy. Start by
  creating a Heroku application for our GTalk bot:

``` bash
heroku create
heroku rename 'some-random-name-for-our-gtalk-bot'
git remote rename heroku gtalk
```

  * We will be using `redis` as our bot's brain. So, install `redis` on our
  heroku instance (which is free, by the way):

``` bash
heroku addons:add redistogo:nano
```

  * Push the bot to heroku:

``` bash
git push gtalk master
```

  * Set our environment variables for the GTalk bot:

``` bash
heroku config:add \
  HUBOT_ADAPTER_NAME="gtalk" \
  HUBOT_ADAPTER_USER="<bot name>" \
  HUBOT_GTALK_USERNAME="<bot gmail complete address>" \
  HUBOT_GTALK_PASSWORD="<bot gmail password>" \
  HUBOT_GTALK_WHITELIST_DOMAINS="<your company domain name>"
```

  * Run our heroku process:

``` bash
heroku ps:scale web=1
```

  * Your Gtalk bot is now live.

  * Let us, now, run this on HipChat. Start again, by creating a Heroku
  application for our Hipchat bot:

``` bash
heroku create
heroku rename 'some-random-name-for-our-hipchat-bot'
git remote rename heroku hipchat
```

  * Install `redis`:

``` bash
heroku addons:add redistogo:nano
```

  * Push the bot to heroku:

``` bash
git push hipchat master
```

  * Set our environment variables for the HipChat bot. Settings marked with
  `@@` can be obtained by visiting your bot's [XMPP/Jabber account
  settings](https://www.hipchat.com/account/xmpp), after logging in HipChat
  with your bot's account:

``` bash
heroku config:add --app="<name-for-our-hipchat-bot>" \
  HUBOT_ADAPTER_NAME="hipchat" \
  HUBOT_ADAPTER_USER="<@@room name>" \
  HEROKU_URL="http://<name-for-our-hipchat-bot>.herokuapp.com" \
  HUBOT_HIPCHAT_JID="<@@username>@chat.hipchat.com" \
  HUBOT_HIPCHAT_PASSWORD="<hipchat.com password for your bot>"
```

  * Run our heroku process:

``` bash
heroku ps:scale web=1
```

  * Your HipChat bot should now be live. Try logging in as a normal hipchat
  user, and talking to the bot (hint: `@jarvis help`, where my bot's mention
  name was `@jarvis`)
