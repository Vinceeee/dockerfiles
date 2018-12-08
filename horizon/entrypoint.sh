#!/usr/bin/env sh

systemctl enable httpd.service memcached.service
sed "1iWSGIApplicationGroup %{GLOBAL}" /etc/httpd/conf.d/openstack-dashboard.conf

exec "$@"
