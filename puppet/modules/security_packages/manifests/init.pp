class security_packages {
  package { ['checksecurity', 'harden-clients', #'harden-servers', 'bcrypt',
             'nmap', 'logcheck', 'logcheck-database', 'mlocate', 'debsums',
             'openssl-blacklist', 'openssl-blacklist-extra',]: # 'openssh-blacklist-extra',]:
    ensure => present
  }

  ######################################################################
  # #make sure these get removed                                       #
  # package {['nfs-common', 'portmap', 'rpcbind', 'locate', 'xinetd']: #
  #   ensure => purged                                                 #
  # }                                                                  #
  ######################################################################
}
