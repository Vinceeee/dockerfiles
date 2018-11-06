#!/bin/bash


# build up mysql configuration at first
CREDENTIAL="/etc/keystone/credential-keys"
FERNET="/etc/keystone/fernet-keys"

# if credential is existed , skip initialization
if [[ -d $CREDENTIAL && -d $FERNET ]];then
    echo "keystone has been already start-up ."
    ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/
    exec "$@"
fi

if [[ -z $MYSQL_HOST || -z $DB_PASSWD ]];then
    echo "error : no enviroment variable 'MYSQL_HOST' or 'DB_PASSWD' "
    exit 8
fi

sed -i "s/<MYSQL_HOST>/$MYSQL_HOST/g" /etc/keystone/keystone.conf
sed -i "s/<DB_PASSWD>/$DB_PASSWD/g" /etc/keystone/keystone.conf


chown -R keystone:keystone /etc/keystone

su -s /bin/sh -c "keystone-manage db_sync" keystone
if [[ $? -ne 0 ]];then
    echo "error in db_sync"
    tail /var/log/keystone/keystone.log
    exit 1
fi

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

# bootstrap endpoint
keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
 --bootstrap-admin-url http://$KEYSTONE_BIND_IP:5000/v3/ \
 --bootstrap-internal-url http://$KEYSTONE_BIND_IP:5000/v3/ \
 --bootstrap-public-url http://$KEYSTONE_BIND_IP:5000/v3/ \
 --bootstrap-region-id RegionOne

ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/

echo "keystone initialization completed."

exec "$@"
