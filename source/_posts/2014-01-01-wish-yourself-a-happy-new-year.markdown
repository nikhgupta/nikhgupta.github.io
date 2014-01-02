---
layout: post
title: "wish yourself a happy new year"
date: 2014-01-01 01:19
comments: true
categories: code
---

> Well, before you do that, I will do it from my side: `Happy new year to you!`

So, I was just working on somethings, and found this nice little code snippet
that was totally appropriate for this event.

<!-- more -->

Ruby
----

If you are a fan of the ruby (like me), define a function with the following
definition (try, using `irb` for this purpose):

``` ruby
def encode(str); str.chars.map(&:ord).inject(:+); end
```

The above function does the following:

- accept a string as an input
- break it into its constituent characters
- convert these characters to their ascii integer value
- sum up all the integer values and return that sum

Nothin' great about that function, right?  
Now, try this in your `irb` session:

``` ruby
encode "Happy new year to you!"
```

You will see that the above function is quite intelligent in itself.

> That little function is empowered with an artificial intelligence by its code,
> without any complex mechanisms :)

Oh, and here is an alternative:

``` ruby
Happy = Time
Happy.new.year
```


Python
------

If you are a python fan, instead, try this:

``` python
encode = lambda str: sum(ord(c) for c in str)
encode("Happy new year to you!")
```
