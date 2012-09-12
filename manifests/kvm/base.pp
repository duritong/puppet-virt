class virt::kvm::base {
  package{'kvm':
    ensure => present,
  }

  if $operatingsystem == 'CentOS' and $lsbmajdistrelease > 5 {
    Package['kvm']{
      name => 'qemu-kvm'
    } 
  }
}
