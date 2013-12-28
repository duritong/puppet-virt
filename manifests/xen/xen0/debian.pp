# debian xen0/Dom0 specific things
class virt::xen::xen0::debian inherits virt::xen::xen0::base {
  # This package is i386 only
  # See also http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=379444
  if $::architecture == 'i386' {
    package{'libc6-xen':
      ensure => present
    }
  }

  Package['kernel-xen']{
    name => $::architecture ? {
      x86_64  => 'linux-image-xen-amd64',
      default => "linux-image-xen-${::architecture}",
    }
  }

  Package['xen']{
    name => 'xen-utils-common',
  }

  Package['xen-libs']{
    name => 'xen-utils-4.0'
  }

  Service['xend']{
    hasstatus => false,
  }

  File['xendomains_defaults']{
        path    => '/etc/default/xendomains',
        source  => "puppet:///modules/virt/xen/${::operatingsystem}/default/xendomains",
  }

  file {
    '/etc/ld.so.conf.d/nosegneg.conf':
      content => "hwcap 0 nosegneg\n",
      owner   => root,
      group   => 0,
      mode    => '0644';
    }
}

