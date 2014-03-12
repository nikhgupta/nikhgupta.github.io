---
layout: post
title: "Installing a RubyOnRails application on your own Server"
date: 2014-02-13 00:10
comments: true
categories: tutorials
published: false
---

Many a times, our clients do not want us to have a peek inside their servers,
and want to know how they can install the nice new little application that we
have created using RubyOnRails on their server. I respect that part, and I just
wish their was a magic button they could just click and get their applications
deployed. (Yes, I am aware about one-click deployments, but that involves
persuading the client to trust these services, and etc.)

While writing the documentation for a client on installing a RubyOnRails
application on their server, I thought why not write the instructions on the
blog and save a little time in future, as well. This post assumes that the
server is a Ubuntu based machine, and similar process can be used for most
Debian systems. For other systems, simple changes in the commands like `yum`
instead of `apt` should suffice.

<!-- more -->

### Updating our system

Just to make sure everything works nicely, we will update our system, first.

```bash
sudo apt-get update
```

### Installing Ruby and Rails

First, we need to ensure that the server has ruby and rails enabled. To check
the current status, you can run the following two commands, and ensure that both
the commands output atleast some text, which means that the respective
executables are installed.

```bash
ruby -v
rails -v
```

Now, we will use [RVM][1] to install Ruby and Rails in this tutorial (though,
I personally, prefer [rbenv][2], but often, I want my production servers to be
able to use the awesome powers provided by RVM).

```bash
sudo apt-get install curl
\curl -L https://get.rvm.io | bash -s stable
```

After it is done installing, load RVM. You may first need to exit out of your
shell session and start up a new one.

`source ~/.rvm/scripts/rvm`

In order to work, RVM has some of its own dependancies that need to be
installed. To automatically install them:

`rvm requirements`

You may need to enter your root password to allow the installation of these
dependencies.
On occasion the `zlib` package may be reported as missing. The RVM page describes
the issue and the solution in greater detail [here][3].

Having done that, we can easily install Ruby using the following
commands:

```bash
rvm install 2.0.0
rvm use 2.0.0 --default
rvm rubygems current
```

Now, assuming that the URL for the git repository is stored in a `$GITHUB_URL`
variable in your shell, you can clone the git repository using:

```bash
git clone $GITHUB_URL
```

Now, `cd` into the newly created directory, and run bundle command to install
the gems required by our application. This should also install Rails for us.
Next, create a new database for use by this application, either using cPanel
(which, should not be the case here, since we are using Ubuntu), or plain
command line.


  [1]:
  [2]:
  [3]: https://rvm.io/packages/zlib/
