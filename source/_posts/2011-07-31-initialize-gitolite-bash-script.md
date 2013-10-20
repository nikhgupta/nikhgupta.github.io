---
layout: post
title: Initializing gitolite repositories
description: bash script to speed up initialization of gitolite repositories
tags: [bash, git, script]
category: code
published: true
kind: article
comments: true
created_at: 2011-07-31 12:46:31 +05:30
---

This script creates a git repository in the current directory, syncs it with
the Gitolite server (and also, the Github - optional) and all the regular
mumbo-jumbo when setting up the Git repository for the first time for
a particular folder.

<!--more-->

{% gist 7077610 %}
