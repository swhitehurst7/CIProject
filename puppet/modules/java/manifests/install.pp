class java::install{

    Exec{
        path => ['/usr/bin', 'bin', '/usr/sbin'], provider => 'shell'
    }

    exec{'Download Java':
        cwd => '/opt',
		command => "wget http://${IP}/downloads/jdk-8u45-linux-x64.tar.gz",
		timeout => 0
    }
	
	exec{'Java Extract':
        cwd => '/opt',
        require => Exec['Download Java'],
        command => "sudo tar zxvf jdk-8u45-linux-x64.tar.gz"
    }
}