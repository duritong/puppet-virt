# basic stuff for xen0/Dom0
class virt::xen::xen0::base {
  package{ ['xen', 'xen-libs', 'kernel-xen']:
    ensure => present,
  }

  service{'xend':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['kernel-xen'],
  }

  file{'xendomains_defaults':
    owner => root,
    group => 0,
    mode  => '0644';
  }

  service{'xendomains':
    enable    => true,
    require   => Package['kernel-xen'],
  }

  file{'/etc/xen/xend-config.sxp':
    source  => [ "puppet:///modules/site_virt/xen/${::fqdn}/config/xend-config.sxp",
                "puppet:///modules/site_virt/xen/config/${::domain}/xend-config.sxp",
                "puppet:///modules/site_virt/xen/config/${::operatingsystem}.${::operatingsystemmajrelease}/xend-config.sxp",
                "puppet:///modules/site_virt/xen/config/${::operatingsystem}/xend-config.sxp",
                'puppet:///modules/site_virt/xen/config/xend-config.sxp',
                "puppet:///modules/virt/xen/config/${::operatingsystem}/xend-config.sxp",
                'puppet:///modules/virt/xen/config/xend-config.sxp' ],
    notify  => Service['xend'],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
}
