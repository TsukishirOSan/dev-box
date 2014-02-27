class utility {
  package { ['bzip2', 'inotail', 'less', 'reportbug', 'xz-utils', 'zsh', 'pv']:
    ensure => present,
  }
}


