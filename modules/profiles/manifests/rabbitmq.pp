# Location: /etc/puppet/modules/<MODULE>/manifests/<FILENAME>.pp
# $Id$
#
# == Class: example_class
#
# Full description of class example_class here.
#
# === Parameters
#
# === Variables
#
# === Authors
#
# author <author@cdnetworks.com>
#
# Refer to the Style Guide in the WIKI: 
# http://wiki.cdnetworks.com/confluence/display/~daehyung.lee/Puppet+Style+Guide+for+SYSENG
class profiles::rabbitmq {
  include profiles::mcollective
  class { 'mcollective::middleware':
    #directory => hiera('mcollective::middleware::directory'),
    #config_file => hiera('mcollective::middleware::config_file'),
    #user => hiera('mcollective::middleware::user'),
    #service => hiera('mcollective::middleware::service'),
    directory => '/etc/rabbitmq',
    config_file => 'rabbitmq.config',
    user => 'rabbitmq',
    service => 'rabbitmq-server',
  }
}
