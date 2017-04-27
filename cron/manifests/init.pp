class cron::install {
	package {"crontabs":
		ensure => present,
	}
}

class cron::config {
	file {
		'/etc/crontab':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 644,
                source => 'puppet:///modules/cron/crontab';
		
		['/etc/cron.d','/etc/cron.daily','/etc/cron.hourly','/etc/cron.monthly','/etc/cron.weekly']:
                ensure => directory,
                owner => 'root',
                group => 'root',
                mode => 755;
		
		'/etc/cron.d/0hourly':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 644,
                source => 'puppet:///modules/cron/0hourly';
		
		'/etc/cron.d/raid-check':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => 'puppet:///modules/cron/raid-check';

		'/etc/cron.d/sysstat':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => 'puppet:///modules/cron/sysstat';

		'/etc/cron.daily/logcontrols':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 740,
                source => 'puppet:///modules/cron/logcontrols';
	
		'/etc/cron.daily/makewhatis.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/makewhatis.cron';

		'/etc/cron.daily/mlocate.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/mlocate.cron';

		'/etc/cron.daily/prelink':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/prelink';
		
		'/etc/cron.daily/readahead.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/readahead.cron';

		'/etc/cron.daily/rhsmd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 700,
                source => 'puppet:///modules/cron/rhsmd';

		'/etc/cron.daily/tmpwatch':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/tmpwatch';

		'/etc/cron.hourly/0anacron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/0anacron';

		'/etc/cron.monthly/readahead-monthly.cron':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/cron/readahead-monthly.cron';

		'/etc/cron.deny':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 600,
                source => 'puppet:///modules/cron/cron.deny';
        }
}

class cron::service {
	service { "crond":
		ensure => running,
		enable => true,	
	}
}

class cron {
	  include cron::install, cron::config, cron::service
  	Class['cron::install'] -> Class['cron::config'] ~> Class['cron::service']
}
