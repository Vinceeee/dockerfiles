#!/bin/bash

set -e

# run this image locally:
# docker run -d  -e SWIFT_LOOP=2G -e SWIFT_REPLICAS=2 --privileged --network=host --name=swift --hostname=swift1 -v /sys/fs/cgroup:/sys/fs/cgroup:ro

function entrypoint_for_saio() {
    devices=$SWIFT_DEVICES
    OLD_IFS=$IFS
    IFS=,
    mkdir -p /srv/node
    for dev in $devices;do
        mkdir -p /srv/node/$dev
    done
    IFS=$OLD_IFS
    chown -R swift:swift /var/cache /srv/node /etc/swift
}

function entrypoint_for_storage() {
    devices=$SWIFT_DEVICES
    OLD_IFS=$IFS
    IFS=,
    mkdir -p /srv/node
    for dev in $devices;do
        mkdir -p /srv/node/$dev
    done
    IFS=$OLD_IFS

    chown -R swift:swift /var/cache /srv/node /etc/swift
    rm -rf /etc/swift/proxy*
}

function entrypoint_for_proxy() {
    cd /etc/swift
    rm -rf account* container* object*
    chown -R swift:swift /var/cache  /etc/swift
}


mkdir -p $RING_DIR
sed -i "s?swift_dir = .*?swift_dir = ${RING_DIR}?g" /etc/swift/*.conf
sed -i "s?# swift_dir = .*?swift_dir = ${RING_DIR}?g" /etc/swift/*.conf
# build some cache
mkdir -p /var/cache/swift

echo "working on $SWIFT_TYPE initialization"
entrypoint_for_$SWIFT_TYPE

exec "$@"
