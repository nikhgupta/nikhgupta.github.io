---
layout: post
title: Bootstrapping my Rails application
description: things I follow when creating a new Rails application
category: code
tags: [rails, notes]
published: true
kind: article
comments: true
created_at: 2012-03-20 12:46:31 +05:30
---

This post details my starting steps with a new [Rails](http://rubyonrails.org)
project, and is only kept here to remind me of various tasks that I,
generally, like to do at this time. Many of these steps might be redundant or
even, obsolete by the time you lay yours eyes on this post :)

<!-- more -->

##### Install Rails

``` bash
rails new my_app -T -d mysql -j jquery
```

##### Initialize a git repository

``` bash
cd my_app
git flow init -d # initialize git work-flow
git add .
git commit -am "Installed Rails"
git flow feature start prepare_base
```

##### Create a RVM configuration file

``` bash
rvm use 1.9.3@rails --rvmrc
```

##### Add some starting gems to Gemfile

``` ruby
gem 'haml'
# gem 'kaminari'
# gem 'devise'
# gem 'capistrano'
# gem 'unicorn'

group :test, :development do
  gem 'turn'
  gem 'haml-rails'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  # gem 'guard-unicorn'
  gem 'ruby_gntp'
  gem 'minitest'
  gem 'launchy'
end
```

##### Run Bundle Install

``` bash
bundle install
```

##### Add database settings in config/database.yml

``` bash
rake db:create:all
```

##### Change Home Page

``` bash
rails generate controller home index
rm -rf public/index.html
find . -type f -iname "*.erb" -delete # remove all erb files since we are using haml
# add 'root :to => "Home#index"' in config/routes.rb
```

##### Lets, make some generations, huh.

``` bash
rails generate rspec:install
rails generate cucumber:install --capybara
guard init rspec && guard init cucumber
```

##### Make some changes to the `features/support/env.rb` file:

``` ruby
require 'cucumber/rails'
require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'
require "factory_girl/step_definitions"
Capybara.default_selector  = :css
Capybara.javascript_driver = :webkit
ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation
```

##### Lets, add some Cucumber Tests (`features/test.feature` file):

``` ruby
Feature: Testing Configuration
  In order to have a base for my new application
  As a developer
  I want to test the configuration settings for this application

  Scenario: Test Home Page
    Given I am on the home page
    Then  I should see "Home#index"
```

##### And, the corresponding steps in `features/step_definitions/test_steps.rb` file:

``` ruby
Given /^I am on the home page$/ do
  visit "/"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end
```

##### Open a iTerm2 tab each for the following processes:

``` bash
# default tab
guard
tail -fn0 log/test.log
rails console
tail -fn0 log/development.log
rails server
```

##### Merge our feature into development

``` bash
git commit -am "finished with preparing base"
git flow feature finish prepare_base
```
