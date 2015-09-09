class jenkins::install{

    Exec{
        path => ['/usr/bin', 'bin', '/usr/sbin'], provider => 'shell'
    }

    exec{'Download jenkins':
        cwd => '/opt',
		command => 'wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -',
		timeout => 0
    }
	
	exec{'Jenkins Extract':
        cwd => '/opt',
        command => 'sudo sh -c "echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list"',
        require => Exec['Download jenkins'],   
	}
	
	exec{'Update Jenkins':
		command => 'sudo apt-get update',
		require => Exec['Jenkins Extract'],
	}
	
	exec{'Install Jenkins':
        cwd => '/opt',
        command => 'sudo apt-get -y install jenkins',
		require => Exec['Update Jenkins'],
    }
	
	exec{'Stop Jenkins':
        cwd => '/opt',
        command => 'sudo service jenkins stop',
        require => Exec['Install Jenkins'],
    }
	
	exec{'Change Port Jenkins':
        cwd => '/opt',
        command => "sudo sed -i 's/8080/8083/g' /etc/default/jenkins",
        require => Exec['Stop Jenkins'],
    }
	
	exec{'Start Jenkins':
        cwd => '/opt',
        command => 'sudo service jenkins start',
        require => Exec['Change Port Jenkins'],
    }
}