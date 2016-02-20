class nginx::firewall {

    service {'iptables':
        ensure => 'running',
    }

    exec {"Add 8888 to list of bindable http ports, see README":
        path    => ['/bin','/sbin'],
        command => 'semanage port -a -t http_port_t  -p tcp 8888',
        unless  => 'semanage port -l | grep http_port_t | grep 8888 >/dev/null',
    }

    firewall { '100 allow access for nginx to 8888':
        ensure => present,
        proto  => 'tcp',
        state  => 'NEW',
        dport  => '8888',
        action => 'accept',
    }
}
