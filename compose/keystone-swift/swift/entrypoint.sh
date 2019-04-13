#!/bin/bash

#set -e

# run this image locally:
# docker run -d  -e SWIFT_LOOP=2G -e SWIFT_REPLICAS=2 --privileged --network=host --name=swift --hostname=swift1 -v /sys/fs/cgroup:/sys/fs/cgroup:ro

POWER=$SWIFT_POWER
REPLICAS=$SWIFT_REPLICAS
devices=$SWIFT_DEVICES
builders="account.builder container.builder object.builder object-1.builder"

if [[ -f /etc/swift/*.builder  ]];then
    echo "Rings are existed , skip bulding rings."
    exec "$@"
fi

mkdir -p /srv/node
# if LOOP is 0 , use devices provided in SWIFT_DEVICES
# if LOOP is 1 , use devices in looping
if [[ $SWIFT_LOOP -eq 1 ]];then
    devices=""
    for each in `seq $SWIFT_REPLICAS`;do
        devices=${devices}"swift${each} "
    done
else 
    for dev in $devices;do
        mkdir -p /srv/node/$dev
        mount /dev/$dev /srv/node/$dev
        if [[ $? -ne 0 ]];then
            echo "error in mounting devices."
            exit 8
        fi
    done
fi
chown -R swift:swift /srv/node

cd /etc/swift
rm -f *.builder *.ring.gz backups/*.builder backups/*.ring.gz

# create swift ring builders
swift-ring-builder account.builder create $POWER $REPLICAS 1
swift-ring-builder container.builder create $POWER $REPLICAS 1
swift-ring-builder object.builder create $POWER $REPLICAS 1
swift-ring-builder object-1.builder create $POWER $REPLICAS 1

for dev in $devices;do
    mkdir -p /srv/node/$dev
    swift-ring-builder account.builder add r1z1-0.0.0.0:6012/$dev 1
    swift-ring-builder container.builder add r1z1-0.0.0.0:6011/$dev 1
    swift-ring-builder object.builder add r1z1-0.0.0.0:6010/$dev 1
    swift-ring-builder object-1.builder add r1z1-0.0.0.0:6010/$dev 1
done

for each in $builders;
do
    swift-ring-builder $each rebalance
done

# build some cache
mkdir -p /var/cache/swift
chown -R swift:swift /var/cache /srv/node /etc/swift

#swift-init all start

exec "$@"
