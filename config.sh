#!/bin/bash

# bring everything up to speed
#sudo apt-get update
#sudo apt-get --yes upgrade

# install puppet modules
# packages=(puppetlabs/stdlib puppetlabs/apt puppetlabs/postgresql maestrodev/rvm garethr/docker);
# for package in packages; do
#     sudo puppet module install $package --force
# done

echo <<EOF >> /etc/security/limits.conf
# added for fluentd purposes
root soft nofile 65536
root hard nofile 65536
* soft nofile 65536
* hard nofile 65536
EOF

sudo puppet module install puppetlabs/stdlib --force
sudo puppet module install puppetlabs/apt --force
sudo puppet module install puppetlabs/ntp --force
#sudo puppet module install puppetlabs/postgresql --force
sudo puppet module install maestrodev/rvm --force
sudo puppet module install garethr/docker --force

sudo puppet apply /vagrant/puppet/manifests/config.pp
echo
echo "Adding vagrant PostgreSQL user"
echo vagrant | sudo -u postgres -S psql -U postgres -a -c "DROP ROLE IF EXISTS vagrant; CREATE ROLE vagrant LOGIN SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION PASSWORD 'vagrant';"
echo
echo "Making unicode the default encoding for databases"
sudo -u vagrant psql -d postgres -U vagrant -a -c "UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';"
sudo -u vagrant psql -d postgres -U vagrant -a -c "DROP DATABASE template1;"
sudo -u vagrant psql -d postgres -U vagrant -a -c "CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';"
sudo -u vagrant psql -d postgres -U vagrant -a -c "UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';"
echo
echo "Freezing default encoding, this could take a moment!"
sudo -u vagrant psql -d postgres -U vagrant -a -c "\c template1; VACUUM FREEZE;"
echo "Finally done!"
echo
echo "Setting up logging"
echo
/usr/local/rvm/bin/rvm-shell -l -c "gem install fluentd --no-ri --no-rdoc"
echo
echo "Cleaning up"
echo
sudo apt-get --yes autoremove
sudo apt-get --yes clean


figlet 'Ready to go!'
