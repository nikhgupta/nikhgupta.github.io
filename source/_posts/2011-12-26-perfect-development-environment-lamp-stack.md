---
layout: post
title: LAMP Stack
description: "getting LAMP to work in our environment"
tags: [series, tutorials, tools, automation]
category: code
published: false
kind: article
created_at: 2011-12-26 12:46:31 +05:30
series:
  id: PDE312
  number: 7
---
<h2>Apache + MySQL + PHP5 + PhpMyAdmin + IonCube Loaders</h2>
We will first install apache, mysql, php5, and phpmyadmin (I use a complete php stack which includes suhosin, phpunit, etc):
{% codeblock lang:bash %}sudo apt-get install apache2 apache2-threaded-dev apache2-suexec \
mysql-client mysql-server sqlite3 php5 php5-dev php-pear php5-cgi php5-imagick \
php5-curl php5-xmlrpc php5-xsl php5-suhosin php5-imap php5-xdebug \
phpunit phpmyadmin{% endcodeblock %}

Now, we need to update our pear packages, etc.
{% codeblock lang:bash %}sudo pear config-set php_ini /etc/php5/apache2/php.ini
sudo pecl config-set php_ini /etc/php5/apache2/php.ini
sudo pear channel-update pear.php.net
sudo pear upgrade-all{% endcodeblock %}

I, also, need IonCube loaders for certain projects. So, lets install our IonCube loaders:
{% codeblock lang:bash %}if [ ! -f /usr/local/ioncube/ioncube_loader_lin_5.3.so ]; then
pushd /tmp
wget http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar zxvf ioncube_loaders_lin_x86.tar.gz
sudo mv ioncube /usr/local/
echo 'zend_extension=/usr/local/ioncube/ioncube_loader_lin_5.3.so' | sudo tee /etc/php5/conf.d/ioncube.ini
popd
fi{% endcodeblock %}

Now, lets enable some of the Apache Modules:
{% codeblock lang:bash %}sudo a2enmod php5 auth_basic cgi dav mime mime_magic rewrite ssl \
suexec include proxy proxy_http vhost_alias auth_mysql
sudo service apache2 restart{% endcodeblock %}

Alright, so lets see if our Apache is actually working. Go to <a href="http://localhost/" target="_blank">localhost</a>. You should see the familiar Apache welcome message: <strong>It Works
</strong>Oh, and when we are at it, lets also check our PhpMyAdmin. Go to <a href="http://something.localhost/phpmyadmin/" target="_blank">phpmyadmin</a>. If it asks you for login, you are all set. If instead, rather than opening a web page, it downloads some file or asks you for downloading a file, your php files are not being parsed on server, and you should do the following:

{% codeblock lang:bash %}sudo apt-get install  libapache2-mod-php5
sudo a2enmod php5
sudo service apache2 restart{% endcodeblock %}

Now, if you have noticed I have installed <code>php5-xdebug</code> package. It offers several features, but the one I use most frequently is the overloading of <code>var_dump</code> function. Lets check if its working fine.
{% codeblock lang:bash %}echo "<?php var_dump(array("something"=>"nothing")); phpinfo(); ?>" | sudo tee /var/www/index.php
[ -f /var/www/index.html ] && sudo mv /var/www/index.html /var/www/index.html.orig{% endcodeblock %}
Once done, open <a href="http://localhost">localhost</a>. You should see a nice pretty 'dump' of the above array, and also the well-known 'phpinfo'. For the lazies, the array should like below:
{% codeblock lang:text %}
array
  'something' => string 'nothing' (length=7)
{% endcodeblock %}
If that dump (the array) does not look so pretty (with colors, and proper formatting), give the commands below (and verify again):
{% codeblock lang:bash %}sudo sed -i /etc/php5/apache2/php.ini -e 's/html_errors = Off/html_errors = On/g'
sudo service apache2 restart{% endcodeblock %}

Lets, configure our Apache just a little bit (we will do the rest of the tasks via automated scripts such as setting up virtualhosts etc):
{% endcodeblock %}

Lets configure apache to create wild-card domains like <code>*.localhost</code>. Add the following lines to <code>/etc/apache2/sites-available/localhost</code> file.
{% codeblock lang:text %}<VirtualHost *:80>
  ServerAdmin webmaster@localhosthost
  ServerName root.localhost
  ServerAlias www.root.localhost
  DocumentRoot /var/www

  ErrorLog ${APACHE_LOG_DIR}/error.log
  LogLevel warn
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
<VirtualHost *:80>
  ServerAdmin webmaster@localhosthost
  ServerName www.localhost
  ServerAlias *.localhost
  VirtualDocumentRoot /var/www/%1

  ErrorLog ${APACHE_LOG_DIR}/error.log
  LogLevel warn
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>{% endcodeblock %}
Also, add the following lines to: <code>/etc/apache2/sites-available/pma</code> file.
{% codeblock lang:text %}<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  ServerName pma
  ServerAlias phpmyadmin mysql
  Redirect / http://mysql.localhost/phpmyadmin

  ErrorLog ${APACHE_LOG_DIR}/error.log
  LogLevel warn
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>{% endcodeblock %}

Finally, run the following commands to enable these sites:
{% codeblock lang:bash %}sudo a2ensite localhost
sudo a2ensite pma
sudo service apache2 restart{% endcodeblock %}

Now, you can access the PHPMyAdmin interface at: <a href="http://mysql.localhost/phpmyadmin">mysql.localhost/phpmyadmin</a> or simply: <a href="http://pma/">http://pma/</a>. Furthermore, you can simply create a folder such as <code>/var/www/wordpress</code> and access the corresponding site at: <a href="http://wordpress.localhost/">wordpress.localhost</a> - that is the magic of wildcard domains :)
On a sidenote, we will make sure that all the websites owned by a particular user are owned by him, and contained inside a particular directory.
{% codeblock lang:bash %}sudo mkdir -p /var/www/`whoami`
sudo chown -R `whoami`:`whoami` /var/www/`whoami`{% endcodeblock %}

<h3>Setting Up WordPress</h3>
Lets set up WordPress at <a href="http://wordpress.localhost/">wordpress.localhost</a> in the directory: <code>/var/www/wordpress</code>
{% codeblock lang:bash %}sudo mkdir -p /var/www/wordpress
sudo chown -R `whoami`:`whoami` /var/www/wordpress
cd /var/www/wordpress
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv ./wordpress/* ./
rmdir wordpress/
rm latest.tar.gz{% endcodeblock %}

Now, we need to setup our databasae. We can either use <a href="http://pma/">PhpMyAdmin</a> or we can use the command line for this purpose. Once, the database is setup, we can run the installation using: <a href="http://wordpress.localhost/">WordPress Installation</a>

<h3>THINGS TO DO</h3>
<ul>
  <li>Create a script or something to test various features of LAMP Stack, we just installed.</li>
</ul>
