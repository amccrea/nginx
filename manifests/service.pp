class nginx::service {

    service {'nginx':
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
    }
}
