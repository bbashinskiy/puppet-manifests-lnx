class snmp::install {
	package {"net-snmp":
		ensure => present,
	}
}

class snmp::config {
	file {
		'/etc/sysconfig/snmptrapd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmptrapd';

		'/etc/sysconfig/snmpd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmpd';
		
		'/etc/snmp/snmpd.conf':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmpd.conf';

		'/etc/snmp/snmptrapd.conf':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 640,
                source => 'puppet:///modules/snmp/snmptrapd.conf';

		'/etc/rc.d/init.d/snmptrapd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/snmp/snmptrapd-init';

		'/etc/rc.d/init.d/snmpd':
                ensure => present,
                owner => 'root',
                group => 'root',
                mode => 755,
                source => 'puppet:///modules/snmp/snmpd-init';	
        }
}

class snmp::service {
	service { "snmpd":
		ensure => running,
		enable => true,	
	}
}

class snmp {
		include snmp::install, snmp::config, snmp::service
		Class['snmp::install'] -> Class['snmp::config'] ~> Class['snmp::service']
}
