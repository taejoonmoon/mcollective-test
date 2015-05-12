#hiera_include('classes')

node default {
	host { 'puppetserver_ip_00':
		name => 'node0.example.net',
		ip => '192.168.4.11',
		host_aliases => 'node0',
	}
	host { 'puppetserver_ip_01':
		name => 'node1.example.net',
		ip => '192.168.4.12',
		host_aliases => 'node1',
	}

	class { '::mcollective':
		hosts => ['node0.example.net','node1.example.net'],
		client_password => 'secret',
		server_password => 'secret',
		broker_password => 'secret',
		psk_key => 'secret1111111112222222222222222221',
		connector_ssl => true,	
		connector_ssl_type => 'trusted',	
		security_provider	=> 'ssl',
	}
	#include mcollective::server
	class { '::mcollective::server':
		resource_type_whitelist => 'package,service',
		authorization_enable	=> true,
		authorization_default_policy	=> 'default_deny',
		audit_logfile => hiera('mcollective::server::audit_logfile'),
		#security_provider	=> 'ssl',
	}

  mcollective::plugin::actionpolicy { 'default_deny':
    default => 'deny',
  }

  mcollective::plugin::actionpolicy { 'puppet':
    default => 'allow',
  }

#  mcollective::plugin::actionpolicy { 'service':
#    default => 'allow',
#  }


	include mcollective::facts
	mcollective::plugin::agent { 'package': }
	mcollective::plugin::agent { 'puppet': }
	mcollective::plugin::agent { 'filemgr': }
	mcollective::plugin::agent { 'nettest': }
	mcollective::plugin::agent { 'nrpe': }
	mcollective::plugin::agent { 'service': }
}

node 
	'node0.example.net',
	'node1.example.net'
	inherits default {
	#include mcollective::middleware
	class { 'mcollective::middleware':
		jetty_password => 'secret',
		use_jmx => true,
		keystore_password => "qtP+wmVAaCDWYSjDNIVKYYnISTA",
		truststore_password => "ajJgv53WDzvgSA+6IcQIm7eiBeU",
	}
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

	mcollective::userconfig { 'mco_test':
		logger_type => 'syslog',
		#log_level => 'debug',
	}

}

#node 'node1.example.net' inherits default {
#	#include mcollective::middleware
#	class { 'mcollective::middleware':
#		jetty_password => 'secret',
#		use_jmx => true,
#	}
#	include mcollective::client
#	mcollective::plugin::client { 'package': }
#	mcollective::plugin::client { 'puppet': }
#	mcollective::plugin::client { 'filemgr': }
#	mcollective::plugin::client { 'nettest': }
#	mcollective::plugin::client { 'nrpe': }
#	mcollective::plugin::client { 'service': }
#}
