class virt::xen {
  case $::virtual {
    'xen0': { include virt::xen::xen0 }
    'xenu': { include virt::xen::xenu }
    'xenhvm': {
      # this currently happens in qubes vms
    }
    default: { fail("No such xen mode known") }
  }
}
