openstack overcloud deploy \
 --templates -r /home/stack/roles_data.yaml \
 -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
 -e /home/stack/nic-configs/network-environment.yaml \
 -e /home/stack/overcloud_images.yaml \
 -e /usr/share/openstack-tripleo-heat-templates/environments/disable-telemetry.yaml \
 -e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-sriov.yaml \
 -e /usr/share/openstack-tripleo-heat-templates/environments/host-config-and-reboot.yaml \
 --ntp-server clock.redhat.com 2>&1 | tee deploy2_1.log
