---
layout: post
title: "making ngrok work with pow and apache (exposing localhost domains to the internet)"
date: 2014-02-07 02:56
comments: true
categories:  workflow
---

OK. I am really happy with my recent endeavour to try out [Pow](http://pow.cx)
and making it work alongside Apache. What this means is that, on my macbook pro,
I can simply run `powder link` inside a rack-based application, and then, use
`http://<appname>.dev` to connect to this application. For legacy (non-rack)
based application, I can simply create a directory in a specificied location,
and that directory will be served by Apache at: `http://<dirname>.lab`. Details
for this implementation/workflow can be found in [this post][1].

Now, this works really nicely. But, I wanted a way to access these sites easily
on the public internet, lets say, to showcase the current work to a client, etc.
This is where [ngrok](http://ngrok.com) comes in. It allows us to establish
a tunnel that forwards a port on our machine and make it available on the public
internet. This post walks through the steps I took to make it play nicely and
really smoothly with Apache and Pow.

<!-- more -->

## Installing `ngrok`

Installing `ngrok` is pretty easy. We need to download a zip file, unzip it and
move the executable inside it to a directory in our `$PATH`. Assuming that
`/usr/local/bin` is in our `$PATH`, we can do something like this:

```bash
cd /tmp
wget https://dl.ngrok.com/darwin_amd64/ngrok.zip
unzip ngrok.zip
chmod +x ngrok
cp ngrok /usr/local/bin
```

Now, we need to verify that `ngrok` is working by running: `ngrok help`. Once,
we have it working, we need to [register](https://ngrok.com/signup) us on
`ngrok` website, and authorize us with `ngrok` as stated in the
[dashboard](http://ngrok.com/dashboard).

Now, `ngrok` is ready to serve our localhost on the public internet. Running:
`ngrok 80` should provide us with a unique URL, which we can access to view our
localhost site, i.e. `http://localhost/`.

## Pow domains?

I wanted to view my Pow based domains over the internet, and this is fairly easy
to do. With our [current Pow setup][1], it is still easier. 

> If you have reached this post while searching to make ngrok work with apache
> or pow, please read that article, before you proceed further. Instructions in
> this post assume that Pow and Apache are setup in a particular manner, and may
> not work in your case.

Alright, we need to reinstall Pow to let it know what mischief we are upto.
We can run the following commands to uninstall Pow, add an environment variable
to our Pow configuration file, and then, reinstall Pow. This particular
environment variable tells Pow to resolve DNS for `*.ngrok.com` on our local
machine, but not serve them.

```bash
curl get.pow.cx/uninstall.sh | sh
echo "export POW_EXT_DOMAINS=ngrok.com" >> ~/.powconfig
curl get.pow.cx | sh
```

That is all we need to make Pow serve our local Pow site, e.g. `myapp.dev` on
the internet, provided this application is being forwarded on `myapp.ngrok.com`
hostname. In order to achieve this, we can run `ngrok`, like this:

```bash
ngrok --subdomain=myapp myapp.dev:88
```

Note that, as per our current Pow configuration, Pow is running on port 88, and
that is what we need to specify here. Great. So, we can now access our local
`myapp.dev` Pow based site on the internet by visiting `http://myapp.ngrok.com`.

## Apache domains?

`ngrok` allows us to expose our Apache `VirtualHost` domains over
the internet by adding the public hostname of the application as a `ServerAlias`
inside the appropriate `VirtualHost` directive.

In my case, I am using the following `VirtualHost` directive (which allows me
to simply create a directory named `myapp` inside the path specified by the
`VirtualDocumentRoot`, and access it on `http://myapp.lab`):

```apache
<VirtualHost *:80>
    ServerName lab
    ServerAlias *.lab
    VirtualDocumentRoot "/Users/nikhgupta/Code/legacy-apps/%1"
</VirtualHost>
```

We want `ngrok` to serve all `*.lab` local sites on the internet. Therefore, we
add a `ServerAlias` with the value `*.lab.ngrok.com` to this `VirtualHost`
directive.

This works because, when a request to `*.lab.ngrok.com` is made on the internet,
`ngrok` will forward it to our machine, which will read the hostname to be
`*.lab.ngrok.com`, which is where Apache kicks in and tries to serve it, using
the above directive. Nice, and simple :)

So, our directive should look like this, now:

```apache
<VirtualHost *:80>
    ServerName lab
    ServerAlias *.lab *.lab.ngrok.com
    VirtualDocumentRoot "/Users/nikhgupta/Code/legacy-apps/%1"
</VirtualHost>
```

To make this all work, we need `ngrok` to serve the site correctly. Assuming
that we want to access `myapp.lab`, we will need to issue a command like this:

```bash
ngrok --subdomain=myapp.lab myapp.lab:80
```

Voila, we can now access our Apache `VirtualHost` domains on the internet, as
well.

## Epilogue

To sum it up, with the above changes, and the following sites that work on our
local machine:

1. `my-pow-app.dev`:    pow based application
2. `my-apache-app.lab`: apache based application

We can issue the following two commands (in separate tabs):

```bash
# access `my-pow-app.dev` via: http://my-pow-app.ngrok.com
ngrok --subdomain=my-pow-app my-pow-app.dev:88

# access `my-apache-app.lab` via: http://my-apache-app.lab.ngrok.com
ngrok --subdomain=my-apache-app.lab my-apache-app.lab:80
```

## Further Improvement to Workflow

I created this handly little shell snippet to easily serve up a local domain on
the internet using `ngrok` (and, optionally, with HTTP Basic Authentication):

```bash
expose() {
    website=$1
    subdomain=$2
    username=$3
    password=$4
    [ -n $website ] || (echo "I need a local website to tunnel to." && exit)
    [ -n $subdomain ] && subdomain="--subdomain=${subdomain}"
    if [[ -n $username  ]] && [[ -n $password ]]; then
        httpauth="-httpauth=${username}:${password}"
    else
        echo "Not using secure tunnel since auth params were not provided."
    fi
    ngrok $subdomain $httpauth $website
}
```

I am pretty sure that the above function can be further improved, but it works.
It empowers me to issue a simplified command to serve any local domain.

To best realize the power of this little snippet, we need to add the following one-line
functions (after the above function) in our shell configuration:

```bash
expose-dev() { expose $1.dev:88 $1 $2 $3; }
expose-lab() { expose $1.lab:80 $1.lab $2 $3; }
```

Now, to serve up a Pow based site, e.g. `myapp.dev`, we can simply run:

```bash
expose-dev myapp
```

And, to serve up an Apache based site, e.g. `myapp.lab`, we can simply run:
```bash
expose-lab myapp
```

Not only that, we can, also, add HTTP Basic Authentication while serving up
a local site, by simply passing two more parameters for username and password,
like this:

```bash
expose-lab myapp username password
```

Now, when we visit `http://myapp.lab.ngrok.com`, we will be greeted with a HTTP
Basic Authentication before we are allowed accessed to our local site.

**Nice and really useful :)**

  [1]: /code/serving-legacy-php-applications-using-apache-alongside-pow/
