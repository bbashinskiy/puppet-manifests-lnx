class puppet::params {
	$puppetserver = "dee1ans013ccpra.cmsalz.ibm.allianz"
}

class puppet::install {
	package {"puppet":
		ensure => present,
	}
}

class puppet::config {
	include puppet::params
		
	file { "/etc/puppet/puppet.conf":
		ensure => present,
		content => template("puppet/puppet.conf.erb"),
		owner => "root",
		group => "root",
		mode    => "644",
	}
	
	file { "/etc/puppet/auth.conf":
                ensure => present,
                owner => "root",
                group => "root",
		            mode	=> "644",
		            source	=> "puppet:///modules/puppet/auth.conf"
        }
	
	file { "/etc/rsyslog.d/puppet.conf":
                ensure => present,
                owner => "root",
                group => "root",
                mode    => "644",
                source  => "puppet:///modules/puppet/puppet-syslog"
        }
	
	file { "/etc/logrotate.d/puppet":
		ensure	=> present,
		owner	=> "root",
		group	=> "root",
		mode	=> "644",
		source	=> "puppet:///modules/puppet/puppet-logrotate"
	}
	/*
	file_line { 'add pupssh user under protection from erec ldap':
                path  => '/opt/eregldap/uar/configure/protectedid.dat',
                line  => 'pupssh',
        }

	file_line { 'add ip and host name of puppet server to /etc/hosts':
                path  => '/etc/hosts',
                line  => '10.17.163.175 dee1ans013ccpra.cmsalz.ibm.allianz dee1ans013ccpra',
        }
	*/
}

class puppet::puppetssh {
        group { 'pupssh':
                          ensure => 'present',
                          gid    => '2222',
        }

		    user { 'pupssh':
			            ensure           => 'present',
                	gid              => '2222',
                	home             => '/home/pupssh',
                	password         => '!!',
                	password_max_age => '99999',
                	password_min_age => '0',
                	uid              => '2222',
                  shell            => '/bin/bash',
		    }

        file {
                '/home/pupssh':
                ensure => directory,
                owner => '2222',
                group => '2222';

                '/home/pupssh/.ssh':
                ensure => directory,
                owner => '2222',
                group => '2222',
                mode => 700;

                '/home/pupssh/.ssh/authorized_keys':
                ensure => present,
                owner => '2222',
                group => '2222',
                mode => 600,
                source => 'puppet:///modules/puppet/id_rsa.pub';
        }
}

class puppet::service {
	      service { "puppet":
		        ensure => running,
		        enable => true,
	      }
}

class puppet {
		include puppet::puppetssh, puppet::install, puppet::config, puppet::service
		Class['puppet::install'] -> Class['puppet::puppetssh'] -> Class['puppet::config'] ~> Class['puppet::service']
}
