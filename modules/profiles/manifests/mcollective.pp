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
class profiles::mcollective {
  ## common mcollective config
  class { '::mcollective':
    hosts => hiera('mcollective::hosts'),
    client_password => hiera('mcollective::client_password'),
    server_password => hiera('mcollective::server_password'),
    broker_password => hiera('mcollective::broker_password'),
    psk_key => hiera('mcollective::psk_key'),
    connector => hiera('mcollective::connector'),
    connector_ssl => hiera('mcollective::connector_ssl'),
    connector_ssl_type => hiera('mcollective::connector_ssl_type'),
    security_provider  => hiera('mcollective::security_provider'),
  }

  # common mcollective server config
  class { '::mcollective::server':
    logger_type => hiera('mcollective::server::logger_type'),
    #log_level => hiera('mcollective::server::log_level'),
    #resource_type_whitelist => hiera('mcollective::server::resource_type_whitelist'),
    audit_logfile => hiera('mcollective::server::audit_logfile'),
    authorization_enable => hiera('mcollective::server::authorization_enable'),
    #authorization_default_policy => hiera('mcollective::server::authorization_default_policy'),
  }
#  mcollective::plugin::actionpolicy { 'default_deny':
#    default => 'allow',
#  }
#  mcollective::plugin::actionpolicy { 'puppet':
#    default => 'allow',
#  }
#  mcollective::plugin::actionpolicy { 'service':
#    default => 'allow',
#  }
  include mcollective::facts

############# Please fix bug
#mcollective::client::package::ensure: 'absent'

  # Agent plugins to install
  mcollective::plugin::agent { 'package': }
  mcollective::plugin::agent { 'puppet': }
  mcollective::plugin::agent { 'filemgr': }
  mcollective::plugin::agent { 'nettest': }
  mcollective::plugin::agent { 'nrpe': }
  mcollective::plugin::agent { 'service': }

}
