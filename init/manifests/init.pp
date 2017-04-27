class init::config {
	file {
		'/etc/rc.d':
                ensure => directory,
		mode => 'g-w,o-w',
		owner => 'root',
                group => "$groupperm",
		recurse => true;

		'/etc/inittab':
                ensure => present,
		owner => 'root',
		group => "$groupperm",
                mode => 'g-w,o-w',
		source  => "puppet:///modules/init/$initfname";

		'/etc/init.d':
    ensure => 'link',
    target => '/etc/rc.d/init.d',
}

class init {
	  include init::config
}
