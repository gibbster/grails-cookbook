#
# Cookbook Name:: development
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"

case node["platform"]
when "ubuntu"
  #sudo apt-add-repository ppa:groovy-dev/grails
  #sudo apt-get update
  #sudo apt-get install grails
  package 'python-software-properties'
  apt_repository "grails" do
    uri "http://ppa.launchpad.net/groovy-dev/grails/ubuntu "
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "02A9EC29"
    action :add
    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end

['unzip'].each do |pkg|
    package pkg do
        :install
    end
end

package 'grails' do
  version "#{node['grails']['version']}"
  action :install
end