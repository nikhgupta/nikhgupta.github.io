---
layout: post
title: Rails Stack
description: "getting Rails to work in our environment"
tags: [series, tutorials, tools, automation]
category: code
published: false
kind: article
created_at: 2011-12-26 12:46:31 +05:30
series:
  id: PDE312
  number: 8
---
<h2>RVM (Single User) + nginx + rubies + rails + unicorn + passenger + thin + mongrol</h2>
OK, this is where it gets fascinating - a Rails Stack :)

<h3>Global Gems</h3>
Before we install ruby or rvm, I prefer to setup some Global Gems - these are the gems that will be installed whenever a ruby is installed (in rvm or when the system ruby is installed). I am a gem-lover and hence, I do use a lot of gems as "global gems". You can edit the list below to your taste. You should enter the following command again, if you get an error on "Installing Rubies in RVM" step.
{% endcodeblock %}

<h3>Setting up System Ruby</h3>
We first start with installing a system ruby. I prefer to install the system ruby with aptitude packages. Thereafter, we install rubygems and update the system gems.
{% codeblock lang:bash %}
sudo apt-get install libruby ruby ruby-dev ri rubygems
sudo gem update --system
sudo gem install $global_gems
{% endcodeblock %}

<h3>Setting up RVM</h3>
Great. Now, lets install RVM (Single User). <a href="http://beginrescueend.com/rvm/">RVM</a> is a great tool for managing rubies and switching them on project by project basis.
{% codeblock lang:bash %}
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> $HOME/.bashrc
source $HOME/.bashrc
{% endcodeblock %}

So, RVM is now installed. We should test if all went nice or not. Type the command below and you should get <code>rvm is a function</code> as the output.
{% endcodeblock %}

A note about the .bashrc warning. The rvm install troubleshooting notes explain how to change your bash profile to work with rvm. In a few linux distributions, the default .bashrc contains the following line:
{% endcodeblock %}
<code>[ -z "$PS1" ]</code> is true if the string "$PS1" has zero length (a non-interactive shell). rvm needs to load for both interactive and non-interactive shells which is why it strongly is recommended to alter this file.

To upgrade RVM in future, you can say:
{% endcodeblock %}

<h3>Installing Rubies in RVM</h3>
Lets, install some rubies. I prefer Ruby 1.8.7, Ruby 1.9.2 and Ruby Enterprise Edition (REE).
{% codeblock lang:bash %}
if [ -z "${global_gems}" ]; then
echo "YOU SHOULD RE-DECLARE THE 'global_gems' VARIABLE."
else
echo "${global_gems}" | sed -e "s/ /\n/g" | tee $HOME/.rvm/gemsets/global.gems >/dev/null
rvm install 1.8.7,1.9.2,ree
fi
{% endcodeblock %}
But, Ruby 1.9.2 (and/or REE) on Ubuntu may give some errors when installing due to its security policies, so lets first install these dependencies, just in case, and then install Ruby 1.9.2 with appropriate flags (replace with '1.9.2' with 'ree' if that is what is having a problem)
{% codeblock lang:bash %}
rvm pkg install readline
rvm pkg install iconv
rvm pkg install openssl
rvm pkg install zlib
rvm pkg install autoconf
rvm pkg install ncurses
rvm install 1.9.2 --with-readline-dir=$rvm_usr_path --with-iconv-dir=$rvm_usr_path --with-zlib-dir=$rvm_usr_path --with-openssl-dir=$rvm_usr_path
{% endcodeblock %}

Alright, lets just check up what rubies we have installed, and whether they are all playing nicely. We iterate through all rubies RVM has installed for us, and then display the ruby version number for that ruby. This should verify the particular ruby installs, a bit.
{% endcodeblock %}

Lets, setup Ruby 1.9.2 as our default Ruby.
{% endcodeblock %}

Furthermore, if you have installed <a href="http://wp.me/p1JkAV-55">Dot Files</a> as per the instructions on that page, you can pretty up your prompt to display the currently selected ruby:
{% endcodeblock %}

<h3>Installing Rails and Creating Gemsets</h3>
Lets, install Rails and create Gemsets for each of our Ruby+Rails requirements. We will install latest rails for each of our ruby and <code>rails -v=2.3.14</code> for our <code>ruby 1.8.7</code>. <a href="https://github.com/thoughtbot/suspenders">Suspenders</a> from THoughtBot is a really nice gem. We will install it to each of our rails (v3.1) gemset.
{% codeblock lang:bash %}
for ruby in `rvm list strings`; do
rvm gemset use rails --create && gem install rails && \
[ "${ruby}" != "ruby-1.9.2-p290" ] && gem install rdoc-data && rdoc-data --install
rvm gemset use rails31 --create && gem install rails -v=3.1 && \
gem install suspenders && [ "${ruby}" != "ruby-1.9.2-p290" ] && \
gem install rdoc-data && rdoc-data --install
[ "${ruby}" == "ruby-1.8.7-p352" ] && \
rvm use 1.8.7@rails2 --create && gem install rails -v=2.3.14
done
{% endcodeblock %}

<h3>Installing Redmine</h3>
Create a separate RVM Gemset to handle our Redmine application:
{% codeblock lang:bash %}mkdir -p ~/workspace/rails/redmine
cd ~/workspace/rails/redmine
rvm use 1.8.7@redmine --create --rvmrc{% endcodeblock %}
Download our Redmine Version (1.3 at the moment and Gemfile for this version to install required gems)
{% codeblock lang:bash %}svn co http://redmine.rubyforge.org/svn/branches/1.3-stable .
wget https://raw.github.com/nikhgupta/miscfiles/master/Redmine-1.3-Gemfile -O Gemfile
bundle install{% endcodeblock %}
Now, create a database for Redmine (I prefer MySQL) and then, edit the <code>config/database.yml</code> file to reflect the database settings.
{% codeblock lang:bash %}cp config/database.yml.example config/database.yml
nano config/database.yml{% endcodeblock %}
Next, we run some simple commands to create our session secret, fill our database, etc.
{% codeblock lang:bash %}rake generate_session_store
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake redmine:load_default_data
mkdir tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets
ruby script/server webrick -e production{% endcodeblock %}

Above should start the server and you should be able to see your Redmine Installation at: <a href="http://0.0.0.0:3000">port 3000</a>
