class build_packages {
  package { ['curl', 'git', 'build-essential', 'openssl', 'libgnutls-openssl27', 'libssl-dev', 'libreadline-dev', 'zlib1g-dev', 'libxml2', 'libxml2-dev', 'libxslt1-dev', 'nodejs']:
    ensure => present,
  }
}
