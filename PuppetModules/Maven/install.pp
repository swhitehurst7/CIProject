class maven::install {

  $mavenDownload = "http://10.50.20.33:8080/aaron/downloads/apache-maven-3.3.3-bin.tar.gz"
  $mavenTarball = "apache-maven-3.3.3-bin.tar.gz"
  $mavenVersion = "apache-maven-3.3.3"

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
	command => 'wget "${mavenDownload}"',
  }
  
  exec { 'extract' :
    cwd '/opt/maven',
	command => 'tar -zxvf "${mavenTarball}"',
  }
  
  file { '/usr/bin/mvn' :
    ensure => 'link',
	target => '/opt/maven/"${mavenVersion}"/bin/mvn'
  }
  
  file { '/etc/profile.d/maven.sh' :
    ensure => 'present',
	content => 'export MAVEN_HOME=/opt/"${mavenVersion}"
	# export JAVA_HOME=/opt/jdk1.8.0_45
	# export JRE_HOME=/opt/jdk1.8.0_45/jre
	export PATH=$PATH:%JAVA_HOME%/bin:%JRE_HOME%/bin:%MAVEN_HOME%/bin
	export PATH',
  }
}
