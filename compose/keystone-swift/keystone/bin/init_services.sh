#!/bin/bash

if [[ -f /root/.init_checked ]]; then
    echo "projects are initialized , skipped."
    exit 0
fi

# execute project initialization (Only Swift)
source /opt/admin-openrc.sh
openstack project create service
openstack user create swift --password 123456 --project service
openstack role add admin --user swift --project service
openstack service create object-store --name swift \
                                     --description "Swift Service"
openstack endpoint create --region RegionOne object-store public http://swift:8080/v1/AUTH_%\(tenant_id\)s
openstack endpoint create --region RegionOne object-store admin http://swift:8080/
openstack endpoint create --region RegionOne object-store internal http://swift:8080/v1/AUTH_%\(tenant_id\)s


touch /root/.init_checked
echo "projects are initialized ."

exit 0
