#!/bin/bash

# bring everything up to speed
#sudo apt-get update
#sudo apt-get --yes upgrade

# install puppet modules
# packages=(puppetlabs/stdlib puppetlabs/apt puppetlabs/postgresql maestrodev/rvm garethr/docker);
# for package in packages; do
#     sudo puppet module install $package --force
# done

sudo puppet module install puppetlabs/stdlib --force
sudo puppet module install puppetlabs/apt --force
#sudo puppet module install puppetlabs/postgresql --force
sudo puppet module install maestrodev/rvm --force
sudo puppet module install garethr/docker --force

sudo puppet apply /vagrant/puppet/manifests/config.pp
echo
echo "Adding vagrant PostgreSQL user"
echo vagrant | sudo -u postgres -S /usr/bin/env psql -U postgres -a -c 'DROP ROLE IF EXISTS vagrant; CREATE ROLE vagrant LOGIN SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;'
echo
echo "Cleaning up"
echo
sudo apt-get --yes autoremove
sudo apt-get --yes clean

figlet 'Ready to go!'
