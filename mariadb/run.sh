#!/usr/bin/env sh

docker run -d --network=host --privileged --name mariadb --hostname=mariadb -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /docker-share:/docker-share -p 3306:3306 mariadb:mine
