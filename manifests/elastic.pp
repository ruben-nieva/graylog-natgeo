class graylog_natgeo::elastic{

class { 'jdk_oracle': }

$elastic_unicast_hosts = hiera_array("ilm_elastic::${::environment}::elastic_hosts")
$elastic_version = hiera("ilm_elastic::${::environment}::version", '2.3.5')

$elastic_cluster_name = hiera("ilm_elastic::${::environment}::cluster_name")

 class { 'elasticsearch':
  ensure => 'present',
  manage_repo  => true,
  repo_version => '2.x',
  version => $elastic_version,
  config => {
 	'cluster.name' => $elastic_cluster_name,
 	'discovery.zen.ping.unicast.enabled' => 'false',
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
