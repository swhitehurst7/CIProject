class zabbix_server::key{

	Exec{
		path => ['/usr/bin', 'bin', 'usr/sbin'], provider -> 'shell'
	}

	exec{ 'Update_source':
		command => 'sudo sed -i -e "57ideb http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main" /etc/apt/sources.list',
	}
	
	exec{ 'Update_source_list':
		command => 'sudo sed -i -e "58ideb-source http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main" /etc/apt/sources.list'
		require => Exec['Update_source_list']
	}
	
	exec{ 'Create_key':
		command => 'sudo apt-key add /opt/puppet/modules/zabbix_server/files/Key1',
		require => Exec['Update_source_list']
	}
	
	exec{ 'Update_hosts':
		command => 'sudo sed -i -e "3i10.50.15.13 Master zabbix" /etc/hosts',
		require => Exec['Create_key']
	}
}