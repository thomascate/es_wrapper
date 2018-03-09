#
# Cookbook:: es_wrapper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

template '/etc/yum.repos.d/elastic.repo' do
  source 'elastic.repo.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

package 'java-1.8.0-openjdk' do
  action :install
end

package 'elasticsearch' do
  action :install
  version "6.2.2-1"
end

template '/etc/elasticsearch/jvm.options' do
  source 'jvm.options.erb'
  owner 'root'
  group 'elasticsearch'
  mode '0644'
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner 'root'
  group 'elasticsearch'
  mode '0640'
  variables :config => {
    "cluster" => {
      "name" => "CHFELSP"
    },
    "node" => { 
      "name" => node[:fqdn],
      "data" => true,
      "master" => true
    },
    "network" => {
      "host" => node['ipaddress'],
    },
    "path" => {
      "data" => "/var/lib/elasticsearch",
      "logs" => "/var/log/elasticsearch"
    },
    "discovery" => { "zen" => {
      "ping" => { 
        "unicast" => { "hosts" => node['es_wrapper']['hosts'] }
      },
      "minimum_master_nodes" => 2,
    } }
  }
end

template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
