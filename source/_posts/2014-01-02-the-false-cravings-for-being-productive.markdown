---
layout: post
title: "the false cravings for being productive"
date: 2014-01-02 19:02
comments: true
categories: personal
tags: organize, workflow, productivity
published: false
---

Anyways, today, I wanted to write about the workflow I wanted to put in place
- a simple workflow to keep me on track. And, I am writing about this now,
because I want to be more organizeed. Yeah, I am unable to follow my own
workflow and time management methods over the last few months, and the majority
of that stems from my hunger to try new tools to keep me productive (in turn )

Oh, I am a late night bird and its rare that I know when I will sleep or when
I will wake up. I never want to go too hard on me, and hence, my schedule is
untimed. It simply lists how I do things, and not when I do them. This works as
long as I remember I have tasks that need to be completed, today. And, I reward
myself for each completed task - via points. The more points I earn, the more
time I can spend on the things I love - coding for fun, snooker, buy some new
clothes, hangout with friends, chat over phone, and what not. Everything has
some assigned point system for this to work. Generally, 3 points an hour.

Emails
------

So, the first thing to do, when I wake up (leaving out the essentials) is to
turn on my [Mail.app](mac-mail), and go for [inbox-zero](inbox-zero). Here is
a simple [YAML](yaml) like description for this activity:

    name: inbox zero on emails
    time_taken: upto 30 minutes
    triggered_at:
        - when I wake up
        - when I return home at evening (usually, after hanging out with friends)
    notes:
        - organize emails as and when required
        - create email rules as and when required
        - reply to any email that needs immediate attention
        - reply all emails that take less than 5 minutes to reply
        - mark emails that need more attention
        - respond to marked emails from previous iteration
    result:
        - no lost emails or email mis-management
        - have replied to all necessary emails
        - emails that need my attention have been marked separately
        - emails that need my attention will get a response, eventually

Feeds/Updates
-------------

The second thing I love to do is following up on my favorite blogs, read some
news, and learn some code snippets. I use [Feedly](feedly) for managing my
feeds, and apply [inbox-zero](inbox-zero) over it.

    name: inbox zero on feeds
    time_taken: upto an hour
    triggered_at:
        - after the activity: "inbox zero on emails"
        - whenever, I am really ideal and not at home/laptop
    notes:
        - read unread items in my saved articles
        - comment on any interesting posts from saved articles
        - read new articles in the categories: Tech, Tools, Productivity
        - mark interesting articles as saved and unread
        - read the news updates from the category: News
        - do not mark anything as unread from the above category, save if needed
        - read new articles in the category: Individuals
        - mark interesting articles as saved and unread
    result:
        - read all interesting articles from previous iteration
        - interesting articles from today marked as saved and unread
        - more informed

StackOverflow
-------------

Oh, I love [StackOverflow](stack-overflow). It gives me a sense of helping
others via the only thing I really know - programming. Now, this activity does
not contribute to my improvement, directly and therefore, I only work on it as
long as it interests me upto a maximum of half an hour.

    name: stackoverflow
    time_taken: upto 30 minutes
    triggered_at:
        - when I need to switch away from my work

Anti-Procrastination
--------------------
