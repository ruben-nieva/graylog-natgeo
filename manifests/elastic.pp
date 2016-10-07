class graylog_natgeo::elastic{

class { 'jdk_oracle': }

$elastic_unicast_hosts = hiera_array("ilm_elastic::elastic_hosts::${::environment}")
$elastic_version = hiera("ilm_elastic::version::${::environment}", '2.3.5')

 class { 'elasticsearch':
  ensure => 'present',
  manage_repo  => true,
  repo_version => '2.x',
  version => $elastic_version,
  config => {
 	'cluster.name' => 'elasticsearch',
 	'discovery.zen.ping.unicast.enabled' => 'false',
 	#'discovery.zen.ping.unicast.hosts'  => ['graylog-elasticsearch01', 'graylog-elasticsearch02', 'graylog-elasticsearch03'],
  'discovery.zen.ping.unicast.hosts'  => $elastic_unicast_hosts,
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
