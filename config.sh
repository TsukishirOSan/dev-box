#!/bin/bash

# bring everything up to speed
sudo apt-get update
sudo apt-get --yes upgrade

# install puppet modules
sudo puppet module install puppetlabs/postgresql --force
sudo puppet module install maestrodev/rvm --force
sudo puppet module install garethr/docker --force

sudo puppet apply /vagrant/puppet/manifests/config.pp

sudo apt-get --yes autoremove
sudo apt-get --yes clean

figlet 'Ready to go!'
