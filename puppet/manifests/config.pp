include rvm

rvm::system_user { vagrant: ; }

rvm_system_ruby {
  'ruby-2.1.1':
    ensure      => 'present',
    default_use => true;
  'ruby-2.1.0':
    ensure      => 'present',
    default_use => false;
}


class { 'docker':
  dns => '8.8.8.8',
}
docker::image { 'base':
  require => Class['docker'],
}

#class { 'postgresql::server': }
#class { 'postgresql::server':
#  postgres_password          => 'vagrant',
#}

class setup_db {
  package { ['postgresql-9.1', 'postgresql-client-9.1', 'postgresql-contrib-9.1']:
    ensure => present,
  }
}

class { 'setup_db': }
