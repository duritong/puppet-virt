class virt::libvirt::centos inherits virt::libvirt::base {
  file{'/etc/sysconfig/libvirt-guests':
    source => [
      "puppet:///modules/site_virt/${fqdn}/libvirt-guests",
      "puppet:///modules/site_virt/${domain}/libvirt-guests",
      "puppet:///modules/site_virt/libvirt-guests",
      "puppet:///modules/virt/${operatingsystem}/${lsbmajdistrelease}/libvirt-guests",
      "puppet:///modules/virt/${operatingsystem}/libvirt-guests"
    ],
    require => Package['libvirt'],
    notify => Service['libvirtd'],
    owner => root,
    group => 0,
    mode => 0644;
  }


}
