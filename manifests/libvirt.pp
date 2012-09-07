class virt::libvirt {
  case $::operatingsystem {
    debian: { include virt::libvirt::debian }
    ubuntu: { include virt::libvirt::ubuntu }
    centos: { include virt::libvirt::centos }
    default: { include virt::libvirt::base }
  }
}
