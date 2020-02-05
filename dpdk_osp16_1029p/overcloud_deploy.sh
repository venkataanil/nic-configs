#!/bin/bash

openstack overcloud deploy \
--timeout 1200 \
--templates /usr/share/openstack-tripleo-heat-templates \
--stack overcloud \
--libvirt-type kvm \
--ntp-server clock1.rdu2.redhat.com \
-r /home/stack/single-nic/roles_data.yaml \
-e /home/stack/virt/config_lvm.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/host-config-and-reboot.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovs.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovs-dpdk.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-sriov.yaml \
-e /usr/share/openstack-tripleo-heat-templates/environments/disable-telemetry.yaml \
-e /home/stack/single-nic/network-environment.yaml \
-e /home/stack/virt/inject-trust-anchor.yaml \
-e ~/containers-prepare-parameter.yaml \
--log-file overcloud_deployment_61.log
