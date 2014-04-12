---
layout: post
title: "learning python - screen scraping with Scrapy"
date: 2014-04-11 08:33
comments: true
categories: code
published: false
---

So, as explained in my [last post][last-post], I am learning to code in Python
gradually. My first attempt with the installation went smoothly, and anyways,
I was expecting it to be just that easy.

To start with my learning process, I went to the [NewCoder](http://newcoder.io)
website and picked up the [Scraper](scraper-tut) tutorial to follow up with. It
was nicely written, and is definitely a thing to learn if I am going to write my
code in Python. I enjoy screen scraping because of the vast data it provides, at
ease - though, I have always tried to be compliant to the webmasters! Anyways,
this post documents my notes and understanding from that tutorial.

<!-- more -->

Bootstraping Scrapy Project
---------------------------

The scraper tutorial is based on the [Scrapy](http://scrapy.org) web scraping
framework, which really seems to awesome, considering that this may be the sole
web scraper framework that is production-ready.

- Creating the virtual enviroment, and installing Scrapy:

```bash
virtualenv ScrapeProj
cd ScrapeProj
. bin/activate
pip install Scrapy
```

  [last-post]:   http://nikhgupta.com/code/a-rubyists-attempt-on-working-with-python-setup-and-first-notes/
  [scraper-tut]: http://newcoder.io/scrape/intro/
