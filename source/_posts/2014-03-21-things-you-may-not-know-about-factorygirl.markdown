---
layout: post
title: "Things you may not know about FactoryGirl"
date: 2014-03-21 21:57
comments: true
categories:
  - code
  - rails
tags:
  - factory-girl
  - notes
---

OK, I have been doing a lot (and I mean, a lot) of work on Rails, recently.
I have always loved the simple expressive syntax of Ruby, anyway, so that does
not bother me.

Now, in one of the projects, I have been using [ActiveAdmin][active-admin], and
other awesome gems like [FactoryGirl][factory-girl], [RSpec][rspec],
[Cucumber][cucumber], etc. And, every now and then, I come across a concept or
feature about these gems that I was not aware about earlier. I wanted to quickly
jot down all these things, in a single place (for future reference). Now, many
of these things might not be new to you, but are to me and are of importance for
me. I am wondering if I should have used a different title for this post, now.

<!-- more -->

### Sequences

I knew about this feature (obviously). It is simple: if you need an attribute to
change everytime a new factory is built or created - use a sequence.

```ruby
sequence(:email) {|n| "email#{n}@factory.com" }
```

The above sequence will generate different emails each time the factory is
called upon, and thus, helps us in passing validations on unique attributes.

### Dependent Attributes

This is really cool. The value of one of the attributes can depend upon the
value of another attribute in our factory. Combined with on-the-fly attribute
declaration, we have a really powerful way to create/build factories:

```ruby
factory :user do
  username "username"
  url { username ? "http://facebook.com/#{username}" : nil }
  verified true
end
```

Now, when we build the `user` factory, we get a `username` and a corresponding
`url` for our User. But, we can pass a `username: nil` option to our factory,
and both our `username` and `url` fields will be set to `nil` :)

```ruby
user = FactoryGirl.build :user
#=> #<User id: nil, username: "username", url: "http://facebook.com/username", verified: true>
user = FactoryGirl.build :user, username: nil
#=> #<User id: nil, username: nil, url: nil, verified: true>
user = FactoryGirl.build :user, username: nil, verified: false
#=> #<User id: nil, username: nil, url: nil, verified: false>
```

### Callbacks and Transient Attributes

We can, even, define some virtual features on our factory. For example, we can
define a `with_<feature>` transient attribute for our factory, which decides if
a particular feature will be available in our factory or not. For example:

```ruby
factory :user do
  ignore do
    with_profile false
  end

  # ...
  # ...

  after :create do |user, evaluator|
    FactoryGirl.create :profile, user: user if evaluator.with_profile
  end
end
```

This will ensure that a `user` factory is created with an associated profile
when `with_profile: true` is passed as an option. Otherwise, a profile for that
user will not be created.

### Traits

Traits define a group of attributes on the concerned factory which form a part
of a particular behaviour. Now, I never had much use of this particular feature,
but I can see this feature is really really useful.

I won't go into much details of this feature, as it has been described pretty
well in the documentation (yes, I am aware, docs are pretty awesome, and this
post might be really useless).

  [active-admin]: http://github.com/gregbell/active_admin
  [rspec]: https://github.com/rspec/rspec-rails
  [cucumber]: https://github.com/cucumber/cucumber
  [factory-girl]: https://github.com/thoughtbot/factory_girl
