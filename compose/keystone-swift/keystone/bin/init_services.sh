#!/bin/bash
source /opt/admin-openrc.sh


function gen_openrc() {
    user=$1
    project=$2
    passwd=$3
    echo "
    export OS_USERNAME=$user
    export OS_PASSWORD=$passwd
    export OS_PROJECT_NAME=$project
    export OS_USER_DOMAIN_NAME=Default
    export OS_PROJECT_DOMAIN_NAME=Default
    export OS_AUTH_URL=http://keystone:5000/v3
    export OS_IDENTITY_API_VERSION=3
    " > /share/$user-openrc.sh
}

function add_users() {

    openstack project create home
    openstack user create home --password 123456 --project home
    openstack role add admin --user home --project home
    gen_openrc home home 123456
    openstack user create tang --password 123456 --project home
    openstack role add member --user tang --project home
    gen_openrc tang home 123456

    openstack ec2 credentials create --user tang > /share/tang-ec2.key
    openstack ec2 credentials create --user home > /share/home-ec2.key
}

if [[ -f /root/.init_checked ]]; then
    echo "projects are initialized , skipped."
    exit 0
fi

# execute project initialization (Only Swift)
openstack project create service
openstack user create swift --password 123456 --project service
openstack role add admin --user swift --project service
openstack service create object-store --name swift \
                                     --description "Swift Service"
openstack endpoint create --region RegionOne object-store public http://$SWIFT_ENDPOINT/v1/AUTH_%\(tenant_id\)s
openstack endpoint create --region RegionOne object-store admin http://$SWIFT_ENDPOINT/
openstack endpoint create --region RegionOne object-store internal http://$SWIFT_ENDPOINT/v1/AUTH_%\(tenant_id\)s


touch /root/.init_checked
echo "projects are initialized ."


echo "initialize user/project ."
add_user

exit 0
