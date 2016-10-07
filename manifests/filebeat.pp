class graylog_natgeo::filebeat{

class { 'filebeat':
  outputs => {
    'logstash'     => {
     'hosts' => '172.28.128.31:5045',
    },
  },
}

filebeat::prospector { 'elastic-log':
  paths    => [
    '/var/log/elasticsearch/*/*.log*',
  ],
  doc_type => 'elastic-log',
  input_type => 'log',
}

filebeat::prospector { 'auth-log':
  paths    => [
    '/var/log/auth.log',
  ],
  doc_type => 'auth-log',
}

}
