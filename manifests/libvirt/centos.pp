class virt::libvirt::centos inherits virt::libvirt::base {
  file{'/etc/sysconfig/libvirt-guests':
    source => [
      "puppet:///modules/site_virt/libvirt/configs/${fqdn}/libvirt-guests",
      "puppet:///modules/site_virt/libvirt/configs/${domain}/libvirt-guests",
      "puppet:///modules/site_virt/libvirt/configs/libvirt-guests",
      "puppet:///modules/virt/libvirt/configs/${operatingsystem}/${lsbmajdistrelease}/libvirt-guests",
      "puppet:///modules/virt/libvirt/configs/${operatingsystem}/libvirt-guests"
    ],
    require => Package['libvirt'],
    notify => Service['libvirtd'],
    owner => root,
    group => 0,
    mode => 0644;
  }
}
