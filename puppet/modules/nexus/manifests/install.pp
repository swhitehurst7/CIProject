class nexus::install (
  $version = '2.11.4-01',
) {
  Exec {
    path     => ['/bin', '/usr/bin', '/usr/sbin'],
    provider => 'shell',
  }

  file {'/usr/local/nexus-2.11.4-01-bundle.tar.gz':
    ensure => present,
    source => 'puppet:///modules/nexus/nexus-2.11.4-01-bundle.tar.gz',
  } ->
  exec {'extract nexus':
    cwd     => '/usr/local',
    command => "tar zxvf nexus-${version}-bundle.tar.gz",
    creates => '/usr/local/nexus-2.11.4-01',
  } ->
  exec {'nexus permissions update':
    command => 'chmod -R 777 /usr/local/nexus-2.11.4-01',
  } ->
  exec {'sonatype permissions update':
    command => 'chmod -R 777 /usr/local/sonatype-work',
  } ->
  exec {'start Nexus service':
    user    => 'vagrant',
    command => '/usr/local/nexus-2.11.4-01/bin/nexus start',
  }
}
