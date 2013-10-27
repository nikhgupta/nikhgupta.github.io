---
layout: post
title: Anonymous Proxy with Squid
description: "tutorial on getting anonymous proxy configuration"
published: true
category: code
tags: [tutorials, tools]
kind: article
comments: true
created_at: 2012-02-12 12:46:31 +05:30
updated_at: 2013-10-27 02:31:42 +05:30
---

Recently, I [set up a Squid Proxy Server](/code/installing-squid-proxy-server-on-centos-5-vps/),
however, when I tried to check my IP address, I found that it
was easy for such a service to detect that I am using a proxy server. But,
I really wanted  anonymity and privacy when I use internet for my peculiar
uses, and hence, I tried to setup an anonymous proxy with squid, which nearly
makes my real IP address untraceable. This post lays down the steps, I used
for setting up this Squid Proxy Server.

<!-- more -->

Lets, first ensure that the cache is not active on certain file types and
certain domains. You must copy the following lines where you find the
`hierarchy_stoplist` directive in the Squid Configuration file or at the very
bottom of it)

``` bash
# deny cache
hierarchy_stoplist cgi-bin ?
acl QUERY urlpath_regex cgi-bin \? \.css
no_cache deny QUERY
acl NOT_TO_CACHE dstdomain "/etc/squid/list/not-to-cache.conf"
no_cache deny NOT_TO_CACHE
```

This will disable cache on any page that uses cgi scripts or has a query
parameter or is a css file. Furthermore, we can add domains to
`/etc/squid/list/not-to-cache.conf` file - one domain per line - which will
not be cached by Squid afterwards.

Next, add up all the IPs which will be exposed to the outer world (the
following line must go in `/etc/squid/squid.conf` file at the very bottom):

``` bash
acl ip1 myip XXX.XXX.XXX.XXX
tcp_outgoing_address XXX.XXX.XXX.XXX ip1
acl ip2 myip XXX.XXX.XXX.YYY
tcp_outgoing_address XXX.XXX.XXX.YYY ip2
acl ip3 myip XXX.XXX.XXX.ZZZ
tcp_outgoing_address XXX.XXX.XXX.ZZZ ip3
```

The above will allow us to use any of the above IP address in our browser as a proxy and the corresponding `tcp_outgoing_address` will be displayed to the world.

Next, add the following rules to very bottom of the Squid Configuration file:

``` bash
# ANONYMOUS PROXY
forwarded_for off
request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all
```

Once, this is all done - check the configuration and restart Squid:

``` bash
chkconfig --level 2345 squid on
/etc/init.d/squid restart
```
