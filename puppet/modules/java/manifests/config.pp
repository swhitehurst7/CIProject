class java::config{

    Exec { 
		path => ["/usr/bin", "bin", "/usr/sbin"], provider => 'shell'
	}
	
    file{'/etc/profile.d/java.sh':
		require => Exec['Java Extract'],
	    ensure => present,
        content => 'JAVA_HOME=/opt/jdk1.8.0_45
		export JAVA_HOME
		PATH=$PATH:$PATH:$JAVA_HOME/bin
		JRE_HOME=/opt/jdk1.8.0_45/jre
		export JRE_HOME
		PATH=$PATH:$PATH:JRE_HOME/bin',
		mode => 755
    }
		
	exec{'install java':
	    command => 'sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_45/bin/java 1',
	    require => File['/etc/profile.d/java.sh']
	}
}