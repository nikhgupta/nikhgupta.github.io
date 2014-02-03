---
layout: post
title: "wrapping long lines in ruby for display in source files"
date: 2014-01-31 02:42
comments: true
categories: code
---

While working on a gem, I needed to generate ruby classes on the fly. Yeah,
I know this should never be the case, unless I needed around 600+ classes (I was
converting schema.org schemas to ruby classes).

Now, this required me to add descriptive text inside these classes, but the text
was very long and I hated how the text overflowed the screen. I use vim, which
promptly highlights the 80-char column marker on my source files, and I wanted
this text to stick to that. Effectively, I wanted something like the following:

```ruby
module MyModule
  class MyClass
    describes "A really long text that respects the 80-char column marker and
    wraps nicely when it exceeds this length."
  end
end
```

<!-- more -->

I knew that Rails provided a nearly similar method with the name `word_wrap`,
and I tweaked it a bit to this:

```ruby
class String
  def wrap options = {}
    width = options.fetch(:width, 76)
    self.strip.split("\n").collect do |line|
      line.length > width ? line.gsub(/(.{1,#{width}})(\s+|$)/, "\\1\n") : line
    end.map(&:strip).join("\n")
  end

  def indent options = {}
    spaces = " " * options.fetch(:spaces, 4)
    self.gsub(/^/, spaces).gsub(/^\s*$/, '')
  end

  def indent_with_wrap options = {}
    spaces = options.fetch(:spaces, 4)
    width  = options.fetch(:width, 80)
    width  = width > spaces ? width - spaces : 1
    self.wrap(width: width).indent(spaces: spaces)
  end
end
```

The last method, i.e. `indent_with_wrap` is what I am interested in, really.
Now, this might not be the best implementation for what I want, but it works and
is self-explanatory to me.

So, now, I can create my ERB template like this to get the desired results:

```ruby
module <%= module_name %>
  class <%= class_name %>
    <%= "describes #{description}".indent_with_wrap spaces: 4, width: 80 %>
  end
end
```

This makes me a happy panda :)
