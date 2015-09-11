class nexus::install (
  $version = '2.11.4-01',
) {
  Exec {
    path     => ['/bin', '/usr/bin', '/usr/sbin'],
    provider => 'shell',
  }
  
  #package {'default-jre':
  #  ensure => installed,
  #}
  
  #package {'default-jdk':
  #  ensure => installed,
  #}
  
  file {'/usr/local/nexus-2.11.4-01-bundle.tar.gz':
    ensure => present,
    source => 'puppet:///modules/nexus/nexus-2.11.4-01-bundle.tar.gz',
  } ->
  exec {'extract nexus':
    cwd     => '/usr/local',
    command => "tar zxvf nexus-${version}-bundle.tar.gz",
    creates => '/usr/local/nexus-2.11.4-01',
  } ->
  file {'/usr/local/nexus-2.11.4-01':
    ensure => link,
    target => 'nexus',
  } ->
  file {'/usr/local/nexus-2.11.4-01':
    owner => 'user',
  } ->
  file {'/usr/local/sonatype-work':
    owner => 'user',
  }
}
