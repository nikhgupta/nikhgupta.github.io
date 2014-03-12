---
layout: post
title: "Custom Filters using Ransacker in ActiveAdmin Interfaces"
date: 2014-03-12 08:47
comments: true
categories:
  - code
  - activeadmin
---

Oh, so, you have tried implementing custom filters in your shiny
[ActiveAdmin](active-admin) interface, and probably, have already started
despising the time you have wasted in searching for an answer? Yeah, it happened
to me, as well.

Anyways, this post contains my short notes on using `ransacker` to create
powerful search patterns in my [ActiveAdmin](active-admin) interfaces.
Definitely, `ransacker` is really powerful. You only need to convert the
incoming search filter (e.g. text or ids or anything else) to an equivalent
attribute in the database, and you are done :)

<!-- more -->

Lets, imagine that we have an [ActiveAdmin](active-admin) dashboard, with
a `User` resource. Our app distinguishes users based on some mysterious logic
as: `Active Users`, `Inactive Users`, and `New Users`. Perfect. But, now,
somehow, I need to filter my users as per this categorization (within AA). And,
this is where normal filtering methods stop working for me. Imagine that the
code present in the `User` model is somewhere along these lines:

```ruby
class User < ActiveRecord::Base

  # categorize a given user as: :new, :active or :inactive
  def categorize
    # .. mysterious code..
    # .. returns one of the symbols: :new, :active or :inactive.
  end

end
```

### Step 1: Define the search filter and inputs.

In order to filter our users based on the above categorization, we first need to
define our filter in AA. This is fairly easy:

```ruby
# app/admin/user.rb
filter :by_categorization_in, label: "Categorization", as: :select, collection: %w[ New Active Inactive ]
```

Yeah, that's it :)

But, the filter will not work, as of now, and if you try to visit your `users`
resource, it will spit out an error that says (something like):

```ruby
undefined method `by_categorization_in' for #<Ransack::Search:0x007fe2365288a0>'`
```

Obviously, we are yet to define how the filtering will take place.

### Step 2: Define the filtering method, a.k.a. ransacker

Alright, so the error says that the given filtering method could not be found,
and therefore, we will start with its implementation. [Ransack](ransack) is the
search library used by AA, and it provides a `ransacker` method that we can use
in our models to define custom search methods. Since, we defined our filter as
`by_categorization_in`, our ransacker method should be named as: `by_categorization`:

```ruby
# app/models/user.rb
class User < ActiveRecord::Base

  # categorize a given user as: :new, :active or :inactive
  def categorize
    # .. mysterious code..
    # .. returns one of the symbols: :new, :active or :inactive.
  end

  # define our custom search method
  ransacker :by_categorization, proc{ |v|
    # some code..
  } do |parent|
    # some other code..
  end
end
```

### Step 3: Define our filtering algorithm

So, finally, we define how the filter will actually work. This is fairly easy
step, as well. Notice the `proc` in the `ransacker` method above? Also, the
`parent` variable? Yeah, we need to use them to define which users will be
filtered and which will be displayed.

In the given `proc`, the variable `v` is nothing special, and simply, contains
the search term we are filtering upon. In our case, this will be one of the
`New`, `Active` or `Inactive` words. The purpose of the `proc` being to map this
variable to an equivalent attribute in the user's table. Therefore, we can do
something like:

```ruby
# app/models/user.rb
class User < ActiveRecord::Base

  # categorize a given user as: :new, :active or :inactive
  def categorize
    # .. mysterious code..
    # .. returns one of the symbols: :new, :active or :inactive.
  end

  # a class method that returns the users belonging to a given category.
  def self.in_category(category = :new)
    # .. could have been some really mysterious code, again..
    # .. but, then, I am nobody :( ..
    all.select{|user| user.categorize == category.to_s.underscore.to_sym }
  end

  # define our custom search method
  ransacker :by_categorization, proc{ |v|
    data = User.in_category(v).map(&:id)
    data = data.present? ? data : nil
  } do |parent|
    # some other code..
  end
end
```
I know that the above way to find out which user ids belong to a particular
category is really inefficient, but this is an example. Alright, so we made the
`proc` return some user IDs belonging to the category we were interested in.

Next is the `parent` variable, which probably is some weird ruby object, and to
be honest I am not entirely sure what all capabilities it provides (though, it
seems that I can use associations, fetch records for the given model, etc. using
this object). But, what we are really interested is in the `parent.table`
variable, which is an instance of the `Arel::Table` class, representing our
`users` table in the database. The purpose of this block is to obtain an
attribute from this table (a.k.a., an `Arel::Attributes::Attribute`), and match
the values returned by the `proc` above with the values for this attribute
across the whole `users` table. Values returned from the `proc` matching the
given attribute for any record in the database table (i.e. our `users` table)
will be returned and the rest entries/users will be filtered.

```ruby
# app/models/user.rb
class User < ActiveRecord::Base

  # categorize a given user as: :new, :active or :inactive
  def categorize
    # .. mysterious code..
    # .. returns one of the symbols: :new, :active or :inactive.
  end

  # a class method that returns the users belonging to a given category.
  def self.in_category(category = :new)
    # .. could have been some really mysterious code, again..
    # .. but, then, I am nobody :( ..
    all.select{|user| user.categorize == category.to_s.underscore.to_sym }
  end

  # define our custom search method
  ransacker :by_categorization, proc{ |v|
    data = User.in_category(v).map(&:id)
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end
end
```

Done! The above should provide us with everything that we need to filter out our
users based on their categorization. Happy ransacking :)

  [1]: http://activeadmin.info/
  [2]: https://github.com/activerecord-hackery/ransack
