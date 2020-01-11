#!/bin/bash

host=$(hostname).vagrant.local
sudo cp /vagrant/hosts /etc/hosts
sudo wget https://apt.puppetlabs.com/puppet6-release-xenial.deb
sudo dpkg -i puppet6-release-xenial.deb
sudo apt update
sudo apt-get -y install puppetserver
sudo cp /vagrant/puppetmaster.conf /etc/puppetlabs/puppet/puppet.conf
sudo cp /vagrant/autosign.conf /etc/puppetlabs/puppet/autosign.conf
sudo /opt/puppetlabs/bin/puppetserver ca setup
sudo systemctl enable puppetserver
sudo systemctl start puppetserver
sudo /opt/puppetlabs/bin/puppet module install 'puppetlabs/mysql'
sudo /opt/puppetlabs/bin/puppet module install 'puppetlabs/apache'
sudo /opt/puppetlabs/bin/puppet module install 'puppetlabs/apt'
sudo /opt/puppetlabs/bin/puppet module install 'puppet/php'
sudo /opt/puppetlabs/bin/puppet module install 'puppet/archive'
