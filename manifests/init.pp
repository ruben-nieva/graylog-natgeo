# Class: graylog
class graylog {

# Install Java
class { 'graylog::java': }

# Install Elasticsearch
#class { 'graylog::elastic': }

# Install Mongodb
#class { 'graylog::mongodb': }


}
