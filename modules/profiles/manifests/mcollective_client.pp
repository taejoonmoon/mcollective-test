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
class profiles::mcollective_client {
	include profiles::mcollective

  include mcollective::client
  mcollective::plugin::client { 'package': }
  mcollective::plugin::client { 'puppet': }
  mcollective::plugin::client { 'filemgr': }
  mcollective::plugin::client { 'nettest': }
  mcollective::plugin::client { 'nrpe': }
  mcollective::plugin::client { 'service': }

	mcollective::userconfig { 'vagrant':
		logger_type => 'syslog',
		#logger_type => 'file',
		#log_level => 'debug',
	}
}
