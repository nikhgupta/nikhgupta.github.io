---
layout: post
title: "serving legacy php applications using Apache alongside Pow"
date: 2014-02-03 06:49
comments: true
categories: code
---

I have started using [Pow](http://pow.cx) lately, which I have avoided for
a long time, without any explicit reasoning. Now that I have actually tried it,
I can definitely say that using Pow is really a breeze, and is really powerful
at the same time. Before this, I used to run Phusion Passenger for my needs, and
while that was a lot more powerful, it was a lot more fuss for my naive needs.

Now, Pow is really great for Rack based applications, but does not work well
enough with other applications, e.g. the ones using PHP. What makes it worse is
that the default Pow configuration takes over the port 80, and thereby, my
Apache server will never be hit. Great.

I, quickly, googled some stuff and found a way to make Apache and Pow play
nicely with each other, and at the same time remove the need for `dnsmasq`,
which I am, currently, using to resolve arbitrary top-level domains. This post
contains my notes on this topic.

<!-- more -->

## Uninstall Pow

The first step we need to perform is to uninstall Pow, if it is already
installed. That way, we make sure that nothing interferes with our setup.

```bash
curl get.pow.cx/uninstall.sh | sh
```

## Add Configuration for Pow

We will tell Pow to use the port 3100, instead of taking over port 80, and let
the poor Apache be. Furthermore, I will tell Pow to resolve a number of TLDs to
`127.0.0.1`. 

```bash
echo 'export POW_DST_PORT=88' >> ~/.powconfig
echo 'export POW_DOMAINS=dev,pow,lab,test' >> ~/.powconfig
```

From the above list of TLDs, we want `dev`, and `pow` to serve applications
using Pow, while `lab` and `test` will be serving Apache based applications
using VirtualHost directives.

## Adding Apache VirtualHosts

First, we will tell Apache to pass any requests for `dev`, and `pow` TLDs to
Pow using reverse proxy:

```apache
<VirtualHost *:80>
    ServerName pow
    ServerAlias *.dev *.pow *.xip.io

    ProxyPass / http://localhost:20559/
    ProxyPassReverse / http://localhost:20559/
    ProxyPreserveHost On
</VirtualHost>
```

Having done that, we tell Apache to serve up the remaining TLDs from
a particular directory:

```apache
<VirtualHost *:80>
    ServerName lab
    ServerAlias *.lab *.test
    VirtualDocumentRoot "/Users/nikhgupta/Code/legacy-apps/%1"
</VirtualHost>
```

Now, make sure that the above directives are being served up by Apache by
including them in your `httpd.conf` somewhere, somehow.

## Restart Apache

Apache will use the above VirtualHost directives upon restart/reload:

```bash
sudo apachectl restart
```

## Install Pow

All that remains is to install Pow:

```bash
curl get.pow.cx | sh
```

## Install Powder

Oh, yes, this is my favorite. Simply, install Powder to further simplify your
life.

```bash
gem install powder
```

*Ecstatic* :)

## Results?

For starters, I can serve up any rack based application by simply running
`powder list` in that directory, and then access it using `appname.dev` or
`appname.pow`. And, this also works for static websites as well e.g.
[Jekyll](http://jekyllrb.com) (note that, this requires that the current
directory has a `public` sub directory which contains an `index.html` file.)

Moreover, my old Apache configurations run without any implications. And,
therefore, I can keep on working on applications that are served using PHP.

Effectively, I can run a ruby/rails based application in a single step by
running `powder link`, and a php application in zero steps by simply placing it
at the correct location.
