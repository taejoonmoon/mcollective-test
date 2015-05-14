#hiera_include('classes')

node default {
	host { 'puppetserver_ip_00':
		name => 'node0.example.net',
		ip => '192.168.4.11',
		host_aliases => 'node0',
	}
	host { 'puppetserver_ip_01': name => 'node1.example.net',
		ip => '192.168.4.12',
		host_aliases => 'node1',
	}
	file { '/usr/local/bin/pa':
		mode  => 0755,
		content => "sudo /usr/bin/puppet agent --test",
	}

}

node 'node0.example.net' inherits default {
	include profiles::activemq
	include profiles::mcollective_client
}

node 'node1.example.net' inherits default {
	include profiles::activemq
}

node 'node2.example.net' inherits default {
	include profiles::mcollective
}
