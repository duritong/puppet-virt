Facter.add('virtual_guests_count') do
	confine :virtual => [ :xen0 ]
	setcode do
    # cache the list for other facts
    system('((/usr/bin/find /var/cache/virsh_list.state -mmin -5 2>&1 | /bin/grep -qE \'^\/var\/cache\/virsh_list\.state$\') && [ `/bin/cat /var/cache/virsh_list.state | /usr/bin/wc -l` -gt 1 ]) || /usr/bin/virsh list | egrep -v \'(^.*Id.*Name.*State$|^-*$|Domain-0|^$)\' > /var/cache/virsh_list.state')
    return 0 unless File.exist?('/var/cache/virsh_list.state')
    File.read('/var/cache/virsh_list.state').split("\n").length
	end
end

