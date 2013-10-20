---
layout: post
title: Basic Web Commons
description: "installing the requisite common packages"
tags: [series, tutorials, tools, automation]
category: code
published: false
kind: article
created_at: 2011-12-26 12:46:31 +05:30
series:
  id: PDE312
  number: 4
---
<h2>Basic Web Commons: Git, Curl, OpenSSL, OpenSSH etc.</h2>
Any Development Environment needs certain packages which are really useful for all major-minor projects. We will initially setup these packages so that we can use them in subsequent steps.
{% codeblock lang:bash %}sudo apt-get install nano guake git curl openssl  redis-server  subversion \
openssh-server openssh-client filezilla imagemagick sqlite3{% endcodeblock %}

The above packages will provide you with quite some functionality. But, we are mainly concerned with Git and SSH, so we should test these functionality. Git will be tested in the next step, automatically. To test SSH, we will try to login to our localhost server:
{% endcodeblock %}
This should give you a message such as:
{% codeblock lang:text %}[nikhgupta@dellinspiron ~ ]$ ssh localhost
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is ea:d7:1a:a4:ee:b0:27:7a:92:8d:b9:43:e2:2e:f4:dc.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
nikhgupta@localhost's password:
Welcome to Ubuntu 11.10 (GNU/Linux 3.0.0-14-generic x86_64)

* Documentation: https://help.ubuntu.com/

0 packages can be updated.
0 updates are security updates.

[nikhgupta@dellinspiron ~ ]$ logout
Connection to localhost closed.
[nikhgupta@dellinspiron ~ ]${% endcodeblock %}
If you see above, the SSH works :) You can even give password for your Ubuntu user, and you should be able to SSH to your own local server.
