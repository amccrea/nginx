class nginx::install {

    package { 'nginx':
        ensure  => 'installed',
        require => Class['nginx::add_repo']
    }
}
