class nginx::config {
  
    file_line { 'Set nginx to listen on port 8888':
        ensure  => present,
        path    => '/etc/nginx/conf.d/default.conf',
        line    => "    listen 8888;",
        match   => 'listen ',
    }

    $github_test_index = 'https://raw.githubusercontent.com/nwea-techops/tech_quiz/master/index.html'

    exec { 'retreive index.html from NWEA test github repo':
        cwd     => "/usr/share/nginx/html/",
        command => "/usr/bin/rm index.html; /usr/bin/wget ${github_test_index}",
    }

}
