class nginx::config {
  
    notify{'config.pp':}

    # Make a backup of original default config file
    # Place in dir above, b/c all files in conf.d are used
    file { '/etc/nginx/default.conf.orig':
        ensure  => present,
        source  => "/etc/nginx/conf.d/default.conf",
        require => Class['nginx::install'],
    }

    file_line { 'Set nginx to listen on port 8888':
        ensure  => present,
        path    => '/etc/nginx/conf.d/default.conf',
        line    => "    listen 8888;",
        match   => 'listen ',
        require => Class['nginx::install'],
    }

    $github_test_index = 'https://raw.githubusercontent.com/nwea-techops/tech_quiz/master/index.html'

    exec { 'retreive test index.html from NWEA test github repo':
        command => "/usr/bin/wget ${github_test_index}",
        creates => '/usr/share/nginx/html/index.html',
        require => Class['nginx::install'],
    }

}
