include rvm

rvm::system_user { vagrant: ; }

rvm_system_ruby {
  'ruby-2.1.1':
    ensure      => 'present',
    default_use => true;
}

class { 'docker':
 dns => '8.8.8.8',
}
docker::image { 'base':
  require => Class['docker'],
}

# class { 'postgresql::server': }
# class { 'postgresql::server':
#  postgres_password          => 'vagrant',
# }

class setup_db {
  package { ['postgresql-9.1', 'postgresql-server-dev-9.1', 'postgresql-client-9.1', 'postgresql-contrib-9.1']:
    ensure => present,
  }
}

class { 'setup_db': }

class { '::ntp':
  restrict => ['127.0.0.1'],
  service_enable => true,
  service_ensure => 'running',
}

class systemd_packages {
  package { ['systemd-services', 'dh-systemd', 'libsystemd-journal0']:
    ensure => present,
  }
}

class { 'systemd_packages': }
