#!/usr/bin/env sh

docker run -d --privileged --restart=always --network=host --name=swift --hostname=swiftSAIO -v /srv/node:/srv/node -v /var/log:/var/log -v /sys/fs/cgroup:/sys/fs/cgroup:ro swift:2.17
