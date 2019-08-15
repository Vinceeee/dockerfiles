#!/bin/bash

set -x
set -e

function check_ring() {
    ring_dir=$RING_DIR
    for (( i = 0; i < 100; i++ )); do
        if [[ -f $ring_dir/account.ring.gz && -f $ring_dir/container.ring.gz && -f $ring_dir/object.ring.gz ]]; then
            echo "ring are all ready , raising swift services"
            break
        fi
        echo "waiting for ring built ..."
        sleep 10s
    done
}

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
    if [[ $SWIFT_LOOP -eq 1 ]]; then
        sed -i "s/# mount_check.*/mount_check = false/g" /etc/swift/*.conf
    fi
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
    if [[ $SWIFT_LOOP -eq 1 ]]; then
        sed -i "s/# mount_check.*/mount_check = false/g" /etc/swift/*.conf
    fi
}

function entrypoint_for_proxy() {
    cd /etc/swift
    rm -rf account* container* object*
    chown -R swift:swift /var/cache  /etc/swift
}


check_ring
mkdir -p $RING_DIR
sed -i "s?swift_dir = .*?swift_dir = ${RING_DIR}?g" /etc/swift/*.conf
sed -i "s?# swift_dir = .*?swift_dir = ${RING_DIR}?g" /etc/swift/*.conf
# build some cache
mkdir -p /var/cache/swift

echo "working on $SWIFT_TYPE initialization"
entrypoint_for_$SWIFT_TYPE

exec "$@"
