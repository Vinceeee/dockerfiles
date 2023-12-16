# 一些dockerfiles

## centos systemd

```dockerfile

FROM centos:7.5.1804
MAINTAINER "491323832@QQ.com"
ENV container docker
# remove basic systemd 
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service  ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# use host cgroup
VOLUME [ "/sys/fs/cgroup"  ]
CMD ["/usr/sbin/init"]

```


## gitlab

```bash

docker run \
    --detach \
    --publish 8443:443 \
    --publish 8080:80 \
    --name gitlab \
    --restart unless-stopped \
    --volume /mnt/sda1/gitlab/etc:/etc/gitlab \
    --volume /mnt/sda1/gitlab/log:/var/log/gitlab \
    --volume /mnt/sda1/gitlab/data:/var/opt/gitlab \
    beginor/gitlab-ce:11.3.0-ce.0

```

## drone

```bash
DRONE_GOGS_SERVER=http://192.168.10.10:10080
DRONE_SERVER_HOST=192.168.10.10:8888
DRONE_SERVER_PROTO=http

docker run \
    --volume=/var/run/docker.sock:/var/run/docker.sock \
    --volume=drone:/data \
    --env=DRONE_GIT_ALWAYS_AUTH=false \
    --env=DRONE_GOGS=true \
    --env=DRONE_GOGS_SERVER=${DRONE_GOGS_SERVER} \
    --env=DRONE_RUNNER_CAPACITY=2 \
    --env=DRONE_SERVER_HOST=${DRONE_SERVER_HOST} \
    --env=DRONE_SERVER_PROTO=${DRONE_SERVER_PROTO} \
    --env=DRONE_TLS_AUTOCERT=false \
    --publish=8888:80 \
    --publish=8443:443 \
    --restart=always \
    --detach=true \
    --name=drone \
    drone/drone:1
```


## jenkins

```bash

  docker run  -u root  --rm  -d  --name jenkins  -p 8080:8080  -p 50000:50000  -v ./jenkins-data:/var/jenkins_home  -v /var/run/docker.sock:/var/run/docker.sock jenkinsci/blueocean

```


## Nexus3 (Yum/Pypi/Docker/Maven Registry)

```bash
# simple version
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
# persistence
docker volume create --name nexus-data
docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
```



#asdfasdfsdaf[]
asdfsadfds






asdfsdfsadf
