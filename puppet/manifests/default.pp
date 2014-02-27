$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'
$desired_ruby_version = '2.1'
# puppet setup
group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Built by SHI, powered by Vagrant, managed by Puppet.\n"
}

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}

class { 'apt_get_update':
  stage => preinstall
}

# --- SQLite -------------------------------------------------------------------

package { ['sqlite3', 'libsqlite3-dev']:
  ensure => installed;
}

# --- Packages -----------------------------------------------------------------
notify { "Installing utility packages": }
include utility
notify { "Installing build packages": }
include build_packages
notify { "Installing security packages": }
include security_packages
