class utility {
  package { ['bzip2', 'inotail', 'less', 'reportbug', 'xz-utils', 'pv', 'figlet']:
    ensure => present,
  }
}


