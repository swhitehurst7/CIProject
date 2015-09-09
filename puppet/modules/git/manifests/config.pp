class git::config{

    Exec {
	    path => ["/usr/bin", "bin", "/usr/sbin"], provider => 'shell' 
    }

	exec{'Make Prefix All':
		require => Exec['Extract Git'],
		cwd => '/opt/git-2.5.0',
		command => "sudo make prefix=/usr/local all",
		timeout => 0
	}

	exec{'Make Prefix Install':
		require => Exec['Make Prefix All'],
		cwd => '/opt/git-2.5.0',
		command => "sudo make prefix=/usr/local install",
		timeout => 0
	}
	
}