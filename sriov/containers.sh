#!/bin/bash

SERVICES=\
/usr/share/openstack-tripleo-heat-templates/environments/services

openstack overcloud container image prepare   \
  --namespace docker-registry.engineering.redhat.com/rhosp13  \
  --push-destination=192.168.24.1:8787 \
  -e ${SERVICES}/neutron-sriov.yaml \
  --prefix "openstack-" \
  --roles-file /home/stack/roles_data.yaml \
  --tag 2019-10-31.1 \
  --output-env-file=/home/stack/overcloud_images.yaml \
  --output-images-file=/home/stack/local_registry_images.yaml
