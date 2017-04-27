class sec::config {
	file { 
		'/etc/security/opasswd':
			owner	=> "root",
			group	=> "root",
			mode	=> "600";

		'/etc/shadow':
      owner   => "root",
      group   => "root",
      mode    => "600";

		'/etc/pam.d':
			ensure  => directory,
      owner   => "root",
      group   => "root",
      mode    => "755";

		'/etc/pam.d/system-auth-ac':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/system-auth-ac";

		'/etc/pam.d/system-auth':
                        ensure => link,
                        target => 'system-auth-ac';

		'/etc/pam.d/passwd':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/passwd";

		'/etc/pam.d/login':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/login";

		'/etc/pam.d/password-auth-ac':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/password-auth-ac";
		
		'/etc/pam.d/password-auth':
                        ensure => link,
                        target => 'password-auth-ac';

		'/etc/pam.d/other':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/other";

		'/etc/pam.d/sshd':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/sshd";

		'/etc/pam.d/su':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/su";

		'/etc/login.defs':
                        ensure  => present,
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        source  => "puppet:///modules/sec/login.defs";
        }
}

class sec {
    include sec::config
}
