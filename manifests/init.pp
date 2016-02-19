class nginx {
    include nginx::add_repo
    include nginx::install
    include nginx::config
    include nginx::firewall
    include nginx::service
}
