---
layout: post
title: ! 'XSLT: auto incrementing a variable'
description: "google-fu on a project"
tags: [debug, problems, google_fu]
category: code
published: true
kind: article
created_at: 2011-07-31 12:46:31 +05:30
---

Recently, while utilizing XSLT for one of my projects, I came across this
issue when I needed to auto-increment a variable for my records. After a bit
of Google searching, I came across a somewhat usable method, which I improved
upon to get this:

<!-- more -->

We first insert a node in our XSL under the node where we want the variable to
be auto-incremented:

``` xml Position The Variable start:1 mark:4-5
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<ul class="flickrGallery">
<xsl:variable name="my_var">
<xsl:value-of select="position()"/>
</xsl:variable>
<xsl:for-each select="//photo">
    ...
```

Now, we will actually be printing the value of this variable as below:

``` xml print the value of the variable
<xsl:attribute name="rel">flickr<xsl:copy-of select="$my_var" /></xsl:attribute>
```
