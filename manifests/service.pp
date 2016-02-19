class nginx::service {

    notify{'service.pp':}

    service {'nginx':
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Class['nginx::add_repo'],
        require => Class['nginx::install'],
        require => Class['nginx::config'],
        require => Class['nginx::firewall'],
    }
}
