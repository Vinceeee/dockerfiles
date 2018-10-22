#!/usr/bin/env sh

function create_keystone
{
    $KEYSTONE_DBPASSWD=$1
    $KEYSTONE_DBPASSWD=$1
    mysql -u root -e"CREATE DATABASE keystone if not exists;"
    mysql -u root -e"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'$BIND_IP' IDENTIFIED BY '$KEYSTONE_DBPASSWD';"
}

create_keystone $1
