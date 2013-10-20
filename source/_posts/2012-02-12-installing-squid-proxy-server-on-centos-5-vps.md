---
layout: post
title: Squid Proxy Server on VPS
description: "tutorial on installing squid over Centos 5"
tags: [tutorials, tools]
category: code
published: true
kind: article
comments: true
created_at: 2012-02-12 12:46:31 +05:30
---

I wanted to browse the internet using a proxy for a variety of reasons. So,
I decided to give it a go using the Squid Proxy Server, which I could easily
setup on my own VPS Server, and manage it in whatever way I wanted.
Personally, I wanted to be able to browse using few different IPs using a HTTP
authentication.

Therfore, in this post, I layout the steps needed to configure squid proxy
server over a Centos5 server.

<!-- more -->

Please, note that all the following commands need to be run as `root`.

First, we need to **install Squid**:

``` bash
yum install squid -y
```

Next up, we need to **change the Squid Configuration** to allow access from
authenticated persons. To do this, we need to add the corresponding ACLs and
http_access rules in `/etc/squid/squid.conf` file (at the very top of the file,
should do):

``` bash
# add auth_params
auth_param basic program /usr/lib/squid/ncsa_auth /etc/squid/passwd
auth_param basic children 2
auth_param basic realm My Proxy Server
auth_param basic credentialsttl 24 hours
auth_param basic casesensitive off
# add acl rules
acl users proxy_auth REQUIRED
# http access rules
http_access deny !users
http_access allow users
```

Next, **create our authentication file** which Squid can use to verify for
user authentications:

``` bash
touch /etc/squid/passwd
chown root.squid /etc/squid/passwd
chmod 640 /etc/squid/passwd
```

Lets, **add a user** which can access this squid server (if you get a warning
that says it can not find the command: `htpasswd`, try to run the commented
command, instead):

``` bash
htpasswd /etc/squid/passwd username
# /usr/local/apache/bin/htpasswd /etc/squid/passwd username
```

Next, we **restart the squid server**:

``` bash
# check if startup config is okay
chkconfig --level 2345 squid on
/etc/init.d/squid restart
```

Now, we can simply connect to this squid server, by **defining the relevant proxy in the browser** :)

### Bonus

If you want to [setup Anonymous Proxy with Squid](Setting up Anonymous Proxy
with Squid)  in order to increase privacy and anonymity, make sure you check
that link ;)
