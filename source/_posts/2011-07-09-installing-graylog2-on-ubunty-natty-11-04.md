---
layout: post
title: Install Graylog2 on Ubuntu 11.04
description: "amazing piece of software with breath-taking installation procedures"
tags: [graylog2, tutorial, ubuntu]
category: code
kind: article
created_at: 2011-07-09 12:46:31 +05:30
published: true
comments: true
flickr:
  photosets: [72157627195814991]
---

Alright, so I wanted to install a [Graylog2](http://graylog2.org) server on my
Ubuntu Natty for managing various system logs, custom tasks output, and
specially capturing [Rails](http://rubyonrails.org) exceptions.  Configuring
a Graylog2 instance to run on Ubuntu was bit of a daunting task, but I,
finally, have it - installed, running and logging :) And, I must say, this is
a beauty - the dashboard, the filters, analytics and what not - in a very
clean, elegant Rails UI - heavily pink in color ;)

We need Java since Graylog2 server utilizes the awesome performce of it. We
need MongoDB for thats the database our logs would be saved into. And,
o'course, we need Ruby to run our web interface.

<!-- more -->

### Installing Java &amp; MongoDB

Java and MongoDB are both available via APT/Synaptic.

``` bash
sudo apt-get update
sudo apt-get install openjdk-6-jre mongodb
```

### Installing Graylog2 Server

The commands below will download the graylog2 server, unzip it and copy the
configuration file, as needed. Finally, it will run MongoDB shell.

``` bash
cd $HOME
mkdir -p $HOME/.graylog2
cd $HOME/.graylog2
wget https://github.com/downloads/Graylog2/graylog2-server/graylog2-server-0.9.5p1.tar.gz
tar xzf graylog2-server-0.9.5p1.tar.gz
sudo cp $HOME/.graylog2/graylog2-server/graylog2.conf.example /etc/graylog2.conf
mongo
```

Once we have the shell, type the following commands to configure a database to
be used by Graylog2 Server.

``` bash
use graylog2
db.addUser("graylog2", "password")
exit
```

Now, open your favorite editor and edit the `etc/graylog2.conf` file with root
access. Change the configuration in there to match the MongoDB, you just
created. Typically, it would be:

``` ini
mongodb_useauth = true
mongodb_user = graylog2
mongodb_password = password
mongodb_host = 127.0.0.1
# mongodb_replica_set = localhost:27017,localhost:27018,localhost:27019
mongodb_database = graylog2
mongodb_port = 27017
```

Once, everything above is configured, we can start our graylog2 server, using:

``` bash
sudo java -jar /home//.graylog2/graylog2-server/graylog2-server.jar
```

Hopefully, if you received no error, we can proceed with installing Graylog2 Web Interface.

### Installing Ruby

Ruby can be installed in many ways. However, I prefer installing Ruby via RVM
and utilizing 1.8.7-p334 branch with Graylog2.  I leave the task of installing
Ruby to the reader.

### Installing Graylog2 Web Interface

Lets, download the Graylog2 web interface, and run `bundle install` so as to
install all the gems needed.

``` bash
cd $HOME/.graylog2
wget https://github.com/downloads/Graylog2/graylog2-web-interface/graylog2-web-interface-0.9.5p2.tar.gz
tar xzf graylog2-web-interface-0.9.5p2.tar.gz
cd graylog2-web-interface-0.9.5p2
(rvm use 1.8.7@graylog2)
(rvmsudo) gem install bundler
(rvmsudo) bundle install
```

Finally, add the MongoDB configuration to the Web interface (edit `config/mongoid.yml`)

``` yaml
production:
host: localhost
port: 27017
Username: graylog2
Password: password
database: graylog2
```

Now, you can run the web interface with Rails command:

``` bash
rails server -e production
```

You should now be able to run: `http://localhost:3000` and see your Graylog2 Web Interface.

### Automating (always-running) Graylog2 instance

You may, optionally, want to keep the Graylog2 interface always running, while
the above commands will need you to run an instance of graylog2 server and web
interface everytime. Therefore, you can follow the steps below to configure
the Graylog2 instance as always-on.

### Use [Passenger](http://www.modrails.com/)

To avoid starting the web interface everytime, you can use Passenger gem by
ModRails. Configuring the passenger server is covered in a lot more details in
the documentations and hence, I am not covering that specific part.

### Use StartUp scripts

With Ubuntu, you can use startup scripts to run some particular scripts when
the system is started, saving you from running those `sudo service .. start`
commands after logging in, etc.

### Graylog2 StartUp Script

Create a file: `/etc/init.d/graylog2-server` and copy the contents below, in
it.

{% gist 7079116 %}

Now, register the Graylog2-server Init script with startup, and run an instance:

``` bash
sudo update-rc.d graylog2-server defaults
sudo service graylog2-server start
```

**This should get you up and running with a Graylog2 instance. Happy,
loggin!**
