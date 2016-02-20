class nginx::service {

    service {'nginx':
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => [ Class['nginx::config'],
                     Class['nginx::firewall'] ],
    }
}
