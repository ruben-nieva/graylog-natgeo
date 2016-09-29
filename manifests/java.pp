class graylog_natgeo::java{

file { "java.list":
    ensure => present,
    source => 'puppet:///modules/graylog_natgeo/java.list',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
 }

 exec { "apt-get update":
    command => "/usr/bin/apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

 #Install Java
 exec { "accept_license":
    command => "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections",
    unless  => "dpkg -l | grep oracle-java8-installer",
    path    => "/bin:/usr/bin"
  } ->

  package {'oracle-java8-installer':
    ensure => installed,
  }


}
