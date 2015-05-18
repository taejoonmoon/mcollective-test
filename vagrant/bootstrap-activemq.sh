#!/bin/sh
########### middleware
rpm -q git > /dev/null || yum -y install git
[ -d /etc/puppet/.git ] || git clone https://github.com/taejoonmoon/mcollective-test /etc/puppet
[ -d /etc/puppet/modules/mcollective/.git ] || git clone https://github.com/taejoonmoon/puppet-mcollective /etc/puppet/modules/mcollective
rpm -q puppetlabs-release || yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
rpm -q puppet-server || yum install -y puppet-server
/etc/init.d/puppetmaster start
rpm -q java-1.8.0-openjdk || yum install -y java-1.8.0-openjdk

########### general
rpm -q puppetlabs-release || yum install -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
rpm -q puppet || yum install -y puppet
grep "server=node0.example.net" /etc/puppet/puppet.conf || echo "    server=node0.example.net" >> /etc/puppet/puppet.conf
grep "^192.168.4.11" /etc/hosts || echo "192.168.4.11    node0.example.net" >> /etc/hosts
# request puppet sign
# puppet agent --test --server node0.example.net
# sign puppet certificate
# puppet cert sign node2.example.net (in puppet ca server)
rpm -q vim-enhanced > /dev/null || yum -y install vim-enhanced
