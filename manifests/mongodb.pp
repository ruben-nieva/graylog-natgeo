class graylog_natgeo::mongodb (
$script = 'disable-transparent-hugepages'
){

$path = "/etc/init.d"
$disable_hugepages = "$path/$script"

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
  version => '3.0.4'
}->

class {'::mongodb::server':
  replset => 'rsmain',
  replset_config => { 'rsmain' => { ensure  => present, members => ['graylog-mongo01:27017', 'graylog-mongo02:27017', 'graylog-mongo03:27017']  }  },
  bind_ip => ['0.0.0.0']
}->

class {'::mongodb::client':}


}
