class graylog_natgeo::mongodb {

$disable_hugepages = '/etc/init.d/disable-transparent-hugepages'

$version = hiera('ilm_mongo::version')
$replset_members = hiera_array('ilm_mongo::replset_members')

file { "$disable_hugepages":
    ensure => present,
    source => 'puppet:///modules/graylog_natgeo/disable-transparent-hugepages',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
 }

exec {"run_on_boot_up":
  require => File[$disable_hugepages],
  command => "update-rc.d disable-transparent-hugepages defaults",
  path    => '/usr/sbin:/usr/bin/:/bin/:/sbin/',
}

exec {"disable hugepages":
  require => File[$disable_hugepages],
  command => "$disable_hugepages start",
  path    => '/usr/sbin:/usr/bin/:/bin/:/sbin/',
}

class {'::mongodb::globals':
  manage_package_repo => true,
  version => $version
}->

class {'::mongodb::server':
  replset => 'rsmain',
  #replset_config => { 'rsmain' => { ensure  => present, members => ['graylog-mongo01:27017', 'graylog-mongo02:27017', 'graylog-mongo03:27017']  }  },
  replset_config => { 'rsmain' => { ensure  => present, members => $replset_members }  },
  bind_ip => ['0.0.0.0']
}->

class {'::mongodb::client':}


}
