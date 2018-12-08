#!/usr/bin/env sh

ADMINOPENRC="/opt/admin-openrc.sh"

if [[ ! -f $ADMINOPENRC ]];then
    echo "file $ADMINOPENRC nout found."
    exit 8
fi

source $ADMINOPENRC

# create user for swift
openstack user create swift --password swift
# create project for swift
openstack project create swift
# create service for swift
openstack service create --name swift --type object-store --description "Swift Object Store Service"
# grant admin authority for user swift to access swift service 
openstack role add --project swift --user swift admin
openstack endpoint create object-store admin  http://192.168.10.106:8080/v1 --region RegionOne
openstack endpoint create object-store internal http://192.168.10.106:8080/v1/AUTH_%\(tenant_id\)s --region RegionOne
openstack endpoint create object-store public http://192.168.10.106:8080/v1/AUTH_%\(tenant_id\)s --region RegionOne
