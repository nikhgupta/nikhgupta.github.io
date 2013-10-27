---
layout: post
title: "Custom Domains on Github Pages without fucking up your Emails"
date: 2013-10-27 16:18
comments: true
categories: code
---

As stated in my post titled [Back with a Bang!](/personal/back-with-a-bang/)
(that title, still, amuses me), I have moved from
[WordPress](http://wordpress.org) to using [Octopress](http://octopress.org) on
Github pages. I was happy with my new blogging configuration, and I think, I am
on schedule with my post updates, till date. However, in making the switch,
I messed up my email configuration while setting up custom domain for this blog.
And, I was not even aware my emails were bouncing off, silently.

<!-- more -->

The `nikhgupta.com` domain is registered on [Namecheap](http://namecheap.com)
(which has been my reliable domain manager, since the very start), and is hosted
on [DigitalOcean](http://digitalocean.com) (which is an amazin' host and my
recommendation, these days). I am using [ZPanel](http://zpanelcp.com), since
cPanel is not a necessity for me (I would, rather, install the bare minimum on
my servers).

I must say that this silent bouncing of my emails was my own idiocy, and
therefore, I am writing this post to help anyone who may have gone through the
same.

## Custom Domain on Github Pages

This has, already, been discussed on [this Github Help page](https://help.github.com/articles/setting-up-a-custom-domain-with-pages),
and therefore, I will not go in details. For summary:

- Create a repository on GitHub with the name of `username.github.com`.
- Next, clone the Octopress (or Jekyll) repository, and make changes, as
  required. My source for the website is in `source` branch, which is pushed to
  the same branch on Github, while my website (real HTML pages) are pushed to
  the `master` branch on Github. This is all managed by Octopress, by default.
- Once we push the site (or run `bundle exec rake gen_deploy` if using
  Octopress), our site will be viewable at `http://username.github.com`.
- Next, we add a file named `CNAME` to our `source` directory. This file is
  a simple text file that just contains one line, the domain name you wish to
  use. In my case, `nikhgupta.com`.
- Change the DNS settings for your domain to point to GitHub’s servers. Since,
  I was using the root domain name, I had to create `A` records for the `@` and
  `www` entries, and point them to Github's IP (`204.232.175.78`).

## Ensuring that Email configuration works

Did you notice that last step? This is where I messed up my email
configuration. The `MX` records in my DNS settings for this domain, were
pointing to `mail.nikhgupta.com`, which in turn was pointing to `@` entry.

Now, that is what is wrong! The `@` entry was initially pointing to my server's
IP address, which meant that the incoming mails were being processed by my
server.

When I changed the `@` entry to point to Github's server, I made Github
responsible for managing my mails. Shit! Here is a snapshot for the change,
I made:

{% img center /images/nikhgupta-dns-a-records-digitalocean.png %}

Anyways, now, that I am aware of what is wrong, it is a simple fix. I made the
`MX` records to point to `mail.nikhgupta.com` (this was the default), but also
made `mail` A-record to point to my server's IP address (by adding an `A`
record.)

Below are snapshots for my `A` and `MX` records, in their current state:

{% img center /images/nikhgupta-dns-a-records.png %}
{% img center /images/nikhgupta-dns-mx-records.png %}

Now, I only had to wait to let the DNS propogate, and my emails were right back
to where they belonged. :)
