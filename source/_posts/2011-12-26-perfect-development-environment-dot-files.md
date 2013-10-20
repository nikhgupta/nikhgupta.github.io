---
layout: post
title: Dot Files
description: "get those tiny little pesky helpful files"
tags: [series, tutorials, tools, automation]
category: code
published: false
kind: article
created_at: 2011-12-26 12:46:31 +05:30
series:
  id: PDE312
  number: 5
---
I  manage  my own version of Dot Files. Well, my collection is not at all superb or exciting but it works for me, for my use case. I will really advise you to go to Github and search for a dotfile repo which suits your taste more.

{% codeblock lang:bash %}pushd /tmp
git clone https://github.com/nikhgupta/dotfiles.git dotfiles
sudo mv dotfiles/.* ~
popd{% endcodeblock %}

This will setup many commonly used aliases, as well as pretty up the prompt a bit ;)
