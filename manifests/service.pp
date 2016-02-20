class nginx::service {

    notify{'service.pp':}

    service {'nginx':
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => [ Class['nginx::install'],
                     Class['nginx::config'],
                     Class['nginx::firewall'] ],
    }
}
