#!/bin/bash

sudo puppet module install puppetlabs/postgresql
sudo puppet apply /vagrant/puppet/manifests/db.pp
