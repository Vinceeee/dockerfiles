#!/usr/bin/env sh

set -e
# build up mysql configuration at first

chown -R keystone:keystone /etc/keystone

su -s /bin/sh -c "keystone-manage db_sync" keystone
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password ADMIN_PASS \
 --bootstrap-admin-url http://$KEYSTONE_DB_IP:5000/v3/ \
 --bootstrap-internal-url http://$KEYSTONE_DB_IP:5000/v3/ \
 --bootstrap-public-url http://$KEYSTONE_DB_IP:5000/v3/ \
 --bootstrap-region-id RegionOne

exec "$@"
