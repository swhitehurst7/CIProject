class zabbix_server::install{
	$Name = '"zabbix"'
	$Host = '"localhost"'
	$Password = '"netbuilder"'
    $User = "mysql -u root -e 'create user $Name@$Host identified by $Password'"
	$Privileges = "mysql -u root -e 'grant all privileges on zabbix.* to $Name@$Host'"

    Exec{
      path => ['/usr/bin', 'bin', 'usr/sbin'], provider => 'shell',
  }
  
    exec{'Update':
      command => 'sudo apt-get -y update',
	  require => Exec['Update_hosts'],
	}
 
	exec{ 'Install_server':
		command => 'sudo DEBIAN_FRONTEND=noninteractive aptitude install -y zabbix-server-mysql',
		require => Exec['Update']
	}
	
	exec{ 'Install':
		command => 'sudo apt-get install -y php5-mysql zabbix-frontend-php',
		require => Exec['Install_server']
	}

	exec{ 'Server_password':
		command => "sudo sed -i -e '116iDBPassword=netbuilder' /etc/zabbix/zabbix_server.conf",
		require => Exec['Install']
	}
	
	exec{ 'Gunzip':
		cwd     => '/usr/share/zabbix-server-mysql',
		command => 'sudo gunzip *.gz',
		require => Exec['Server_password']
	}
	
	exec{ 'Create_sql_user':
		command => "$User",
		require => Exec['Gunzip']
	}
	
	exec{'Create_sql_database':
		command => 'mysql -u root -e "create database zabbix"',
		require => Exec['create_sql_user']
	}
	
	exec{ 'Create_sql_privileges':
		command => "$Privileges",
		require => Exec['Create_sql_database']
	}
	
	exec{ 'Refresh_privileges':
		command => 'mysql -u root -e "flush privileges"',
		require => Exec['Create_sql_privileges']
	}
	
	exec{ 'schema.sql':
		cwd     => 'usr'share/zabbix-server-mysql',
		command => 'mysql -u zabbix -p zabbix < schema.sql',
		require => Exec['Refresh_privileges']
	}
	
	exec{ 'images.sql':
		cwd     => 'usr/share/zabbix-server-mysql',
		command => 'mysql -u zabbix -p zabbix < images.sql',
		require => Exec['schema.sql']
	}
	
	exec{ 'data.sql':
		cwd     => 'usr/share/zabbix-server-mysql',
		command => 'mysql -u zabbix -p zabbix < data.sql',
		require => Exec['images.sql']
	}
	
	exec{ 'Copy_config':
		command => 'sudo cp /usr/share/doc/zabbix-frontend-php/examples/zabbix.conf.php.example /etc/zabbix/zabbix.cong,php',
		require => Exec['data.sql']
	}
	
	exec{ 'Change_password':
		command => 'sudo sed -i "s/zabbix_password/netbuilder/g" /etc/zabbix/zabbix.conf.php',
		require => Exec['Copy_config']
	}
	
	exec{ 'Copy_apache':
		command => 'sudo cp /usr/share/doc/zabbix-frontend-php/examples/apache.conf /etc/apache2/conf-available/zabbix.conf',
		require => Exec['Change_password']
	}
	
	exec{ 'Integrate_zabbix_apache':
		command => 'sudo a2econf zabbix.conf',
		require => Exec['Copy_apache']
	}
	
	exec{ 'Apache_alias':
		command => 'sudo a2enmod alias',
		require => Exec['Integrate_zabbix_apache']
	}
	
	exec{ 'Apache_stop':
		command => 'sudo /etc/init.d/apache2 stop',
		require => Exec['Apache_alias']
	}
	
	exec{ 'Apache_restart':
		command => 'sudo /etc/init.d/apache2 restart',
		require => Exec['Apache_stop']
	}
	
	exec{ 'Zabbix_setup':
		command => 'sudo sed -i 's/no/yes/g' /etc/default/zabbix-server',
		require => Exec['Apache_restart']
	}
	
	exec{ 'Zabbix_start':
		command => 'sudo service zabbix-server start',
		require => Exec['Zabbix_setup']
	}
	
}  