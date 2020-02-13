openstack flavor create --vcpus 8 --ram 18000 --disk 40 controller
openstack flavor set --property  capabilities:profile='controller' --property capabilities:boot_option='local' --property cpu_arch='x86_64' --property resources:CUSTOM_CONTROLLER='1' --property resources:DISK_GB='0' --property resources:MEMORY_MB='0' --property resources:VCPU='0' controller

openstack flavor create --vcpus 16 --ram 63000 --disk 300 computeovsdpdk
openstack flavor set --property  capabilities:profile='computeovsdpdk' --property capabilities:boot_option='local' --property cpu_arch='x86_64' --property resources:CUSTOM_COMPUTEOVSDPDK='1' --property resources:DISK_GB='0' --property resources:MEMORY_MB='0' --proper resources:VCPU='0' computeovsdpdk

openstack baremetal node set --property capabilities='profile:computeovsdpdk,boot_option:local,cpu_hugepages:true,cpu_txt:true,cpu_vt:true,cpu_aes:true,cpu_hugepages_1g:true' 305d043a-890f-4184-a977-d7a4c5fd964e
openstack baremetal node set --resource-class 'computeovsdpdk' 305d043a-890f-4184-a977-d7a4c5fd964e

openstack baremetal node set --property capabilities='profile:controller,boot_option:local,cpu_hugepages:true,cpu_txt:true,cpu_vt:true,boot_option:local,cpu_aes:true,cpu_hugepages_1g:true' 6c0ff600-d4fd-4b26-9398-3bca2ed61ff9
openstack baremetal node set --resource-class 'controller' 6c0ff600-d4fd-4b26-9398-3bca2ed61ff9

openstack overcloud roles generate -o single-nic/roles_data.yaml Controller ComputeOvsDpdk

openstack overcloud roles generate -o single-nic/roles_data.yaml Controller ComputeSriov

openstack flavor create --vcpus 16 --ram 63000 --disk 300 computesriov
openstack flavor set --property  capabilities:profile='computesriov' --property capabilities:boot_option='local' --property cpu_arch='x86_64' --property resources:CUSTOM_COMPUTESRIOV='1' --property resources:DISK_GB='0' --property resources:MEMORY_MB='0' --proper resources:VCPU='0' computesriov

openstack baremetal node set --property capabilities='profile:computesriov,boot_option:local,cpu_hugepages:true,cpu_txt:true,cpu_vt:true,cpu_aes:true,cpu_hugepages_1g:true' a5adc51d-b412-4c49-9490-07fbcfea78f8
openstack baremetal node set --resource-class 'computesriov' a5adc51d-b412-4c49-9490-07fbcfea78f8

