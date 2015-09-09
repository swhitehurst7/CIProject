class java::install {

$downloadJava = "http://10.50.20.33:8080/aaron/downloads/jdk-8u45-linux-x64.tar.gz"
$javaVersion = "jdk-8u45-linux-x64.tar.gz"
$jdkFile = "jdk1.8.0_45"

  Exec { 
    path => ['/bin', '/usr/bin', '/usr/sbin']  
  }
  
  exec { "apt-get update" :
    command => 'sudo apt-get update'
  }
  
  package { 'wget':
    ensure => 'present',
  }
  
  package { 'tar':
    ensure => 'present',
  }
  
  file { '/opt/java' :
    ensure => 'directory',
  }->
  
  exec { 'download_jdk':
    cwd     => '/opt/java',
    command => 'sudo wget "${downloadJava}"',
  }-> 
  
  exec { 'extract':
    cwd     => '/opt/java',
    command => 'sudo tar zxvf "${javaVersion}"',
  }->

  exec { 'installalts':
    cwd     => '/opt/java/"${jdkFile}"/',
    command => 'sudo update-alternatives --install /usr/bin/java java /opt/"${jdkFile}"/bin/java 2',	
  }->  


  exec { 'updatealts':
    cwd     => '/opt/java/"${jdkFile}"/',
    command => 'update-alternatives --config java',	
  }->  

  file { "/etc/environment" :
    content => "export JAVA_HOME=/opt/"${jdkFile}"'
export JRE_HOME=/opt/"${jdkFile}"/jre
PATH=$PATH:%JAVA_HOME%/bin:%JRE_HOME%/bin',
export PATH",
  }  


}
