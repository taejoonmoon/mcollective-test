#!/bin/sh
########### general
rpm -q puppetlabs-release || yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
rpm -q puppet || yum install -y puppet
grep "server=node0.example.net" /etc/puppet/puppet.conf || echo "    server=node0.example.net" >> /etc/puppet/puppet.conf
grep "^192.168.4.11" /etc/hosts || echo "192.168.4.11    node0.example.net" >> /etc/hosts
rpm -q vim-enhanced > /dev/null || yum -y install vim-enhanced
