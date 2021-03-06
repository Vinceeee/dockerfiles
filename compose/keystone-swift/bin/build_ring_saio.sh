#!/bin/bash

set -x
set -e

echo "build rings "

# HOSTS=storage1,storage2
HOSTS=0.0.0.0
DEVICES=swift1,swift2

builders="account.builder container.builder object.builder object-1.builder"

if [[ -z $RING_DIR ]]; then
    echo "No RING_DIR specified , exit."
    exit 1
fi

mkdir -p $RING_DIR
rm -rf $RING_DIR/*
cd $RING_DIR

# create swift ring builders
swift-ring-builder account.builder create $POWER $REPLICAS 1
swift-ring-builder container.builder create $POWER $REPLICAS 1
swift-ring-builder object.builder create $POWER $REPLICAS 1
swift-ring-builder object-1.builder create $POWER $REPLICAS 1

OLD_IFS=$IFS
IFS=,
i=1
for dev in $DEVICES;do
    for host in $HOSTS;do
        swift-ring-builder account.builder add --ip $host --region 1 --zone $i --port 6012 --device $dev --weight 100
        swift-ring-builder container.builder add --ip $host --region 1 --zone $i --port 6011 --device $dev --weight 100
        swift-ring-builder object.builder add --ip $host --region 1 --zone $i --port 6010 --device $dev --weight 100
        swift-ring-builder object-1.builder add --ip $host --region 1 --zone $i --port 6010 --device $dev --weight 100
    done
    let i+=1
done
IFS=$OLD_IFS

for each in $builders;
do
    swift-ring-builder $each rebalance
done
