class nginx::install {

    notify{'install.pp':}

    package { 'nginx':
        ensure  => 'installed',
        require => Class['nginx::add_repo']
    }
}
