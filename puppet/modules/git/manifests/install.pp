class git::install{

    Exec{
	    path => ['/usr/bin', 'bin', '/usr/sbin'], provider => 'shell'
	}

	exec{'Install Libs':
	    cwd => '/opt',
		command => 'sudo apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext \libz-dev libssl-dev'
	}
	
	exec{'Download Git':
		require => Exec['Install Libs'],
		cwd => '/opt',
		command => "sudo wget -nv http://${IP}/downloads/git-2.5.0.tar.gz -O git-2.5.0.tar.gz",
		timeout => 0
	}
	
	exec{'Extract Git':
        require => Exec['Download Git'],
        cwd => '/opt',
		command => "sudo tar zxvf git-2.5.0.tar.gz"
    }
	

}
