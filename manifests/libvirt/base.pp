# basic stuff for a libvirt host
class virt::libvirt::base {
  require rubygems::xmlsimple
  package { ['libvirt', 'virt-install', 'virt-top']:
    ensure => installed,
  } -> service { 'libvirtd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  } -> file {
    '/usr/local/sbin/guest_starter':
      source  => 'puppet:///modules/virt/libvirt/guest_starter',
      require => Package['libvirt'],
      owner   => root,
      group   => 0,
      mode    => '0700';
  }
}
