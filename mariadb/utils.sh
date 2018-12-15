#!/bin/bash

function create_keystone() {
    $KEYSTONE_BINDIP=$1
    $KEYSTONE_DBPASSWD=$2
    mysql -u root  -e"CREATE DATABASE keystone if not exists;"
    mysql -u root  -e"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'$KEYSTONE_BINDIP' IDENTIFIED BY '$KEYSTONE_DBPASSWD';"
}

if [[ $# -ne 2 ]]; then
    echo cao
    exit 1
fi

create_keystone $1 $2
