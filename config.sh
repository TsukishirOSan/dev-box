#!/bin/bash

sudo puppet module install puppetlabs/postgresql
sudo puppet module install maestrodev/rvm

sudo puppet apply /vagrant/puppet/manifests/config.pp
