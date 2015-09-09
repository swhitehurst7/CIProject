class maven::config(
  $mvn_home = '/opt/apache-maven-3.3.3' )
{

  Exec{
    path => ["/usr/bin", "/bin", "/usr/sbin"]
  }

  file { '/etc/profile.d/maven.sh' :
      require   => Exec ['extract mvn'],
      ensure    => present,
      content => 'export MAVEN_HOME=/opt/apache-maven-3.3.3/bin
	  export M2=$MAVEN_HOME/bin
      export PATH=$M2/bin:$PATH',
	  mode    => 755						
  }
  
  
  exec{'install mvn':
	    command => 'sudo update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.3.3/bin/mvn 2',
	    require => File['/etc/profile.d/maven.sh']
	}
	
}