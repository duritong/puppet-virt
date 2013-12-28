# basic kvm stuff
class virt::kvm::base {
  package{'kvm':
    ensure => present,
  }

  if $::operatingsystem == 'CentOS' and $::operatingsystemmajrelease > 5 {
    Package['kvm']{
      name => 'qemu-kvm'
    }
  }
}
