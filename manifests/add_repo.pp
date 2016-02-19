class nginx::add_repo {
    notify{ 'adding repo':}
    file { '/etc/yum.repos.d/nginx.repo':
        ensure => 'present',
        source => 'puppet:///modules/nginx/nginx_repo',
    }
}
