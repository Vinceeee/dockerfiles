# Run centos-base by this command below :

    sudo docker run -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp/$(mktemp -d):/run  --name myboy01 -d local/c7-systemd:latest

# note:
- 挂载 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp/$(mktemp -d):/run
- 必须后台运行
