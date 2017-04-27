class ssh::install {
	package {"openssh":
		ensure => present,
	}
}

class ssh::config {
	file {
		'/etc/ssh/sshd_config':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => "puppet:///modules/ssh/sshd_config";

		'/etc/ssh/ssh_config':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 644,
                source => "puppet:///modules/ssh/ssh_config";
		
		['/usr/sbin/sshd','/usr/libexec/openssh/ssh-keysign','/usr/libexec/openssh/sftp-server','/usr/bin/ssh-keyscan','/usr/bin/ssh-agent','/usr/bin/ssh-keygen','/usr/bin/ssh-add','/usr/bin/ssh','/usr/bin/sftp','/usr/bin/scp',]:
                owner   => 'root',
                group   => 'root',
                mode    => "g-w,o-w",
	}
}

class ssh::service {
	service { "sshd":
		ensure => running,
		enable => true,
	}
}

class ssh {
		include ssh::install, ssh::config, ssh::service
		Class['ssh::install'] -> Class['ssh::config'] ~> Class['ssh::service']
}
