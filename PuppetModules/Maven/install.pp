class maven::install {

  Exec {
    path => ['/bin ', '/usr/bin', '/usr/sbin']
  }

  package { 'wget' :
    ensure => 'present'
  }
  
  file { '/opt/maven' :
    ensure => 'directory'
  }
  
  exec { 'download' :
    cwd '/opt/maven',
	command => 'wget http://10.50.15.14:8080/aaron/downloads/apache-maven-3.3.3-bin.tar.gz',
  }
  
  exec { 'extract' :
    cwd '/opt/maven',
	command => 'tar -zxvf apache-maven-3.3.3-bin.tar.gz',
  }
  
  file { '/usr/bin/mvn' :
    ensure => 'link',
	target => '/opt/maven/apache-maven-3.3.3/bin/mvn'
  }
  
  file { '/etc/profile.d/maven.sh' :
    ensure => 'present',
	content => 'export MAVEN_HOME=/opt/apache-maven-3.3.3
	export JAVA_HOME=/opt/jdk1.8.0_45
	export JRE_HOME=/opt/jdk1.8.0_45/jre
	export PATH=$PATH:%JAVA_HOME%/bin:%JRE_HOME%/bin:%MAVEN_HOME%/bin
	export PATH',
}