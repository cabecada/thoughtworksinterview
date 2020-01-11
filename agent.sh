#!/bin/bash

self=$(hostname)
master=node-1.vagrant.local

sudo cp /vagrant/hosts /etc/hosts
sudo wget https://apt.puppetlabs.com/puppet6-release-xenial.deb
sudo dpkg -i puppet6-release-xenial.deb
sudo apt-get update
sudo apt-get -y install puppet-agent
sudo cp /vagrant/puppetagent.conf /etc/puppetlabs/puppet/puppet.conf
sudo sed -i -e "s/AGENT/${self}/g" -e "s/MASTER/${master}/g" /etc/puppetlabs/puppet/puppet.conf
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
