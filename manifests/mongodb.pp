class graylog_natgeo::mongodb{

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
