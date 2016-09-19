class graylog::elastic{

 class { 'jdk_oracle': }

 class { 'elasticsearch':
  ensure => 'present',
  manage_repo  => true,
  repo_version => '2.x',
  version => '2.3.5',
  config => {
 	'cluster.name' => 'elasticsearch',
 	'discovery.zen.ping.unicast.enabled' => 'false',
 	'discovery.zen.ping.unicast.hosts'  => ['graylog-elasticsearch01', 'graylog-elasticsearch02', 'graylog-elasticsearch03'],
 	'network.host' => $hostname,
 	'http.port' => '9200',
  'datadir'   => '/var/lib/elasticsearch-data',
  },
 }

elasticsearch::instance { 'es-01': }

elasticsearch::plugin{ 'mobz/elasticsearch-head':
  module_dir => 'head',
  instances => [ 'es-01' ],
}

elasticsearch::plugin{ 'royrusso/elasticsearch-HQ':
  module_dir => 'hq',
  instances => [ 'es-01' ],
}


}
