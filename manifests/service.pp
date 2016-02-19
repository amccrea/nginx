class nginx::service {

    notify{'service.pp':}

    service {'nginx':
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => [ Class['ngins::add_repo'],
                     Class['ngins::install'],
                     Class['ngins::config'],
                     Class['nginx::firewall'] ],
    }
}
