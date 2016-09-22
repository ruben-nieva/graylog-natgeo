class graylog_natgeo::master{

class { 'jdk_oracle': }

class { 'graylog::repository':
 version => '2.0'
}->

class { 'graylog::server':
 package_version => '2.0.0-5',
 config          => {
   'password_secret' => 'emHOAf1uvzlsJwvPfbhzk9RnzLLbpg01G2KMFkitftB8iIjBq2TuDK02TX2qFh3xAcPQDlKzEC0gnYty8Mk4nuN1vTiXGt2M',
   'root_password_sha2' => '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
   'is_master' =>  true,
   'root_timezone' =>  'America/Chicago',
   'message_journal_enabled'                            => true,
   'message_journal_dir'                                => '/var/lib/graylog-server/journal',
   'elasticsearch_cluster_name'                         => 'elasticsearch',
   'elasticsearch_network_host'                         => $hostname,
   'elasticsearch_discovery_zen_ping_multicast_enabled' => false,
   'elasticsearch_discovery_zen_ping_unicast_hosts'     => "graylog-elasticsearch01:9300, graylog-elasticsearch02:9300, graylog-elasticsearch03:9300",
   'elasticsearch_shards'                               => 4,
   'elasticsearch_replicas'                             => 1,
   'rest_listen_uri'                                    => 'http://0.0.0.0:12900/',
   'rest_transport_uri'                                 => "http://$ipaddress_eth1:12900",
   'web_listen_uri'                                     => 'http://0.0.0.0:9000',
   'mongodb_uri'                                        => 'mongodb://graylog-mongo01,graylog-mongo02,graylog-mongo03/graylog2',
   'mongodb_max_connections'                            => 1000,
   'mongodb_threads_allowed_to_block_multiplier'        => 5,
  }
 }

}
