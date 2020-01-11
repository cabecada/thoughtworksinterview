# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"
  config.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
  end

  (1..3).each do |i|
    config.vm.define "node-#{i}" do |n|
      if i == 1
        n.vm.provision "shell", path: "master.sh"
      else 
        n.vm.provision "shell", path: "agent.sh"
      end
      n.vm.hostname = "node-#{i}"
      n.vm.network "private_network", ip: "172.20.1.#{i+100}"
    end
  end

end
