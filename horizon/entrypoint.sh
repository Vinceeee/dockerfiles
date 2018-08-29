#!/usr/bin/env sh

# build up mysql configuration at first

if [[ -z $MYSQL_CONF ]];then
    echo "No MYSQL-CONF, failed to config, please specify MYSQL_CONF as enviornmental variable"
    exit 8
fi


keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
 --bootstrap-admin-url http://192.168.56.106:5000/v3/ \
 --bootstrap-internal-url http://192.168.56.106:5000/v3/ \
 --bootstrap-public-url http://192.168.56.106:5000/v3/ \
 --bootstrap-region-id RegionOne
