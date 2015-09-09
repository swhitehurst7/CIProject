class git::install {

  $packageUpdate = ['wget', 'build-essential', 'libssl-dev', 'libcurl4-gnutls-dev', 'libexpat1-dev', 'gettext', 'unzip']
  $downloadLink = "http://10.50.20.33:8080/aaron/downloads/git-2.5.0.tar.gz"
  $gitVersion = "git-2.5.0.tar.gz"

  Exec {
    path => ['/bin', '/usr/sbin', '/usr/bin']
  }->

  exec { "apt-get update" :
    command => "/usr/bin/apt-get update",
  }->

  package { "${packageUpdate}" :
    ensure => 'present',
  }->

  file { '/opt/git' :
    ensure => 'directory',
  }->

  exec { "wget git" :
    cwd => '/opt/git',
    command => 'wget "${downloadLink}",
  }->

  exec { "extract" :
    cwd => '/opt/git',
    command => 'tar -zxvf "${gitVersion}",
  }->

  exec { "install git" :
    cwd => '/opt/git-2.5.0',
    command => 'sudo make prefix=/usr/local all && sudo make prefix=/usr/local install',
  }
}
