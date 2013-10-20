---
layout: post
title: Introduction to Puppet
description: "installing puppet on master and client servers"
tags: [automation, tutorials, tools]
published: true
category: code
kind: article
comments: true
created_at: 2011-12-23 12:46:31 +05:30
---

This post details the steps/instructions to install the puppet and also,
connect the client to the master.

**These instructions are for my own record keeping purposes.**

<!-- more -->

- On **Master** and **Client**:

``` bash
# update our ubuntu
sudo apt-get update

# install ruby and ruby-dev
sudo apt-get install irb libopenssl-ruby libreadline-ruby ruby ruby-dev

# install and update rubygems
cd /usr/local/src
sudo wget http://production.cf.rubygems.org/rubygems/rubygems-1.5.2.tgz
sudo tar -xzf rubygems-1.5.2.tgz
cd rubygems-1.5.2
sudo ruby setup.rb
sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.8 1
sudo gem update --system

# install puppet
gem install puppet --no-ri --no-rdoc
```

- Make sure that the client and the master can ping each other on network, or
  better yet setup SSH access from/to master.

- On **Master**:

``` bash
# download puppet configuration
cd /etc
sudo wget http://bitfieldconsulting.com/files/powering-up-with-puppet.tar.gz
sudo tar -xzf powering-up-with-puppet.tar.gz

# start puppet daemon, along with users
sudo puppet master --mkusers --verbose --no-daemonize
# file ownership fix, if required
chown -R puppet:puppet /var/lib/puppet

# start puppet master
sudo puppet master

# check puppet
sudo puppet agent --test --server=`hostname`
```

- On **Client**:

``` bash
# connect with mast to get certificate
puppet agent --server=&lt;puppetmaster&gt; --waitforcert 60 --test
```

- On **Master**:

``` bash
# check the cert requests and grant cert to client
sudo puppetca list
sudo puppetca sign &lt;puppetclient&gt;
```
