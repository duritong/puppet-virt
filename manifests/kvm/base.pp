# basic kvm stuff
class virt::kvm::base {
  package{'kvm':
    ensure => present,
  }

  if ($::operatingsystem == 'CentOS') and versioncmp($::operatingsystemmajrelease,'5') > 0 {
    Package['kvm']{
      name => 'qemu-kvm'
    }
  }
}
