class graylog_natgeo::mongodb{

class { '::mongodb::globals':
  manage_package_repo => true,
  version => '3.0.4'
} ->
class { '::mongodb::server':
  smallfiles => true,
  bind_ip    => ['0.0.0.0'],
  replset    => 'rsmain'
} ->
mongodb_replset {'rsmain':
  members => ['graylog-mongo01:27017', 'graylog-mongo02:27017', 'graylog-mongo03:27017' ],
}

#class {'::mongodb::client':}

}
