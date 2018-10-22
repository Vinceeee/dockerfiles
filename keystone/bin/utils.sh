#!/usr/bin/env sh

function create_project() {
    username=$1
    password=$2
    projectname=$3
    role=$4
    if [[ -z $role ]];
        role="user"
    fi

    openstack user create $username --password $password
    openstack project create $username --password $password
    openstack role add --project $projectname --user $username $role

}

function create_service() {
    exit 0
}

function create_endpoint() {
    exit 0
}
