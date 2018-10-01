#!/usr/bin/env sh
set -e

function create_master(){
    echo "create master node"
    mysql -u root -e"grant replication slave on *.* to 'root'@'192.168.10.11' identified by '234567';"
}

function create_slaver(){
    echo "create slaver node"
}

function create_keystone
{
    dbhost=$1
    mysql -u root -e"CREATE DATABASE keystone if not exists;"
    mysql -u root -e"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'$dbhost' IDENTIFIED BY 'KEYSTONE_DBPASS';"
}

mkdir -p /var/lib/mysql /var/log/mariadb
chmod -R mysql:mysql /var/lib/mysql /var/log/mariadb
systemctl start mariadb
