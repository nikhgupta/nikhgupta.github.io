---
layout: post
title: Bootstrapping
description: "tweaking our new system"
tags: [series, tutorials, tools, automation]
category: code
published: false
kind: article
created_at: 2011-12-26 12:46:31 +05:30
series:
  id: PDE312
  number: 2
---
Alright, we have a long way to go. We will be installing several packages, we will be setting up few development stacks, we will be configuring some files, and so on and on. But, first of all, we need to bootstrap our environment. By bootstrapping, I mean, a few tweaks here and there. Getting on with it:

Substitute a server name you prefer for your workstation in the following command, and also set a long pass phrase for your WorkStation SSH key. Don't worry, we will configure the environment so that you do not have to enter this pass phrase again and again, and that you be able to login passwordless while still being secure. Oh, and also, please make sure that you do not close the terminal you are working in until the step below have all been completed.
{% codeblock lang:bash %}servername="&lt;your_server_name&gt;"
passphrase="&lt;some_long_passphrase&gt;"{% endcodeblock %}

Next, we check up if the following command gives us the correct IP address for our workstation (local IP or DHCP). If not, please setup the IP with: <code>localip="&lt;your_ip_here&gt;"</code>
{% codeblock lang:bash %}localip="`ifconfig | sed -n 's/.*inet addr:\([0-9.]\+\)\s.*/\1/p' | grep -v 127.0.0.1`"
echo -e "Identified IP address: ${% endcodeblock %}

Once the above two are done, run the following commands (this will do some basic things, adjust your time zone, and then update your system):
{% codeblock lang:bash %}
sudo dpkg-reconfigure tzdata
sudo apt-get install ntp
sudo ntpdate ntp.ubuntu.com # Update time
sudo apt-get -y update
sudo apt-get -y upgrade
{% endcodeblock %}

Now, make sure that the terminal we are working has not been closed, and that the following commands are executed only once (especially those having word: 'tee' in them)
{% codeblock lang:bash %}
echo -e "\n${localip}\tlocalhost ${servername}\n" | sudo tee -a /etc/hosts
echo "${servername}" | sudo tee /etc/hostname
sudo hostname -F /etc/hostname
ssh-keygen -t rsa -C "workstation ssh key" -N "${passphrase}" -v -f "$HOME/.ssh/${servername}"
sudo apt-get install keychain
echo -e "\n\n\n# Perfect Development Environment : http://wp.me/p1JkAV-4x" | tee -a $HOME/.bashrc
echo -e "pde_servername='${servername}'\npde_localip='${localip}'" | tee -a $HOME/.bashrc
echo -e "`which keychain` $HOME/.ssh/${servername} > /dev/null 2>&1\nsource $HOME/.keychain/$HOSTNAME-sh > /dev/null 2>&1" | tee -a $HOME/.bashrc
source $HOME/.bashrc
{% endcodeblock %}
