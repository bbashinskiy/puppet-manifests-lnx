class perm::config {
	file {
		'/etc':
          ensure => directory,
		      mode => 'o-w',
		      recurse => true;

		['/tmp','/var/tmp']:
          ensure => directory,
          mode => '1777';

		['/var']:
          ensure => directory,
          mode => 'o-w';
  }

	exec {'/tmp File Permissions LINUX-MULTI':
		      command => 'find /tmp -type f -perm -o=wx -exec chmod -x,o-w {} \;',
		      onlyif => 'test $(find /tmp -type f -perm -o=wx|wc -l) -gt 0',
		      path => '/bin:/usr/bin',
	}

	exec {'/var File Permissions LINUX-MULTI':
          command => 'find /var -type f -perm -o=wx -exec chmod -x,o-w {} \;',
          onlyif => 'test $(find /var -type f -perm -o=wx|wc -l) -gt 0',
          path => '/bin:/usr/bin',
  }

	exec {'/usr/local File Permissions LINUX-MULTI':
          command => 'find /usr/local -type f -perm -o=wx -exec chmod -x,o-w {} \;',
          onlyif => 'test $(find /usr/local -type f -perm -o=wx|wc -l) -gt 0',
          path => '/bin:/usr/bin',
  }

	exec {'/usr Permissions LINUX-MULTI':
          command => 'find /usr -type f -perm -o=wx -exec chmod -x,o-w {} \;',
          onlyif => 'test $(find /usr -type f -perm -o=wx|wc -l) -gt 0',
          path => '/bin:/usr/bin',
  }
}

class perm {
		include perm::config
}
