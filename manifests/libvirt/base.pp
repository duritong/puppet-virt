# basic stuff for a libvirt host
class virt::libvirt::base {
  require rubygems::xmlsimple
  package{ [ 'libvirt', 'python-virtinst', 'ruby-libvirt', 'virt-top' ]:
    ensure => installed,
  }

  if ($::operatingsystem == 'CentOS') and versioncmp($::operatingsystemmajrelease,'6') > 0 {
    Package['ruby-libvirt']{
      name => 'rubygem-ruby-libvirt'
    }
    Package['python-virtinst']{
      name => 'virt-install'
    }
  }

  file{'/etc/libvirt/libvirtd.conf':
    source  => [
      "puppet:///modules/site_virt/libvirt/configs/${::fqdn}/libvirtd.conf",
      "puppet:///modules/site_virt/libvirt/configs/${::domain}/libvirtd.conf",
      "puppet:///modules/site_virt/libvirt/configs/${::operatingsystem}/${::operatingsystemmajrelease}/libvirtd.conf",
      "puppet:///modules/site_virt/libvirt/configs/${::operatingsystem}/libvirtd.conf",
      'puppet:///modules/site_virt/libvirt/configs/libvirtd.conf',
      "puppet:///modules/virt/libvirt/configs/${::operatingsystem}/${::operatingsystemmajrelease}/libvirtd.conf",
      "puppet:///modules/virt/libvirt/configs/${::operatingsystem}/libvirtd.conf"
    ],
    require => Package['libvirt'],
    notify  => Service['libvirtd'],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }

  service{'libvirtd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['libvirt'],
  }

  file{
    '/usr/local/sbin/guest_starter':
      source  => 'puppet:///modules/virt/libvirt/guest_starter',
      require => Package['libvirt'],
      owner   => root,
      group   => 0,
      mode    => '0700';
    '/usr/local/sbin/generate_random_macaddress':
      source  => 'puppet:///modules/virt/libvirt/random_mac_address.rb',
      owner   => root,
      group   => 0,
      mode    => '0755';
  }
}
