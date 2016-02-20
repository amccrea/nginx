class nginx {
    include nginx::add_repo
    include nginx::install
    include nginx::config
    include nginx::firewall
    include nginx::service

    Class['nginx::add_repo'] ->
    Class['nginx::install']  -> 
    Class['nginx::config']   -> 
    Class['nginx::firewall'] -> 
    Class['nginx::service']
}
