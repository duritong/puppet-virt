class virt::kvm::base {
  package{ [ 'kvm', 'qemu-kvm']:
    ensure => present,
  }

  if $operatingsystem == 'CentOS' && $lsbmajdistrelease == '5' {
    Package['qemu-kvm']{
      name => 'kvm-qemu-img'
    } 
  }
}
