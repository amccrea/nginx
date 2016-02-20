class nginx::add_repo {

    file { '/etc/yum.repos.d/nginx.repo':
        ensure => 'present',
        source => 'puppet:///modules/nginx/nginx_repo',
    }
}
