#! /bin/sh
#
# init-env.sh
# Copyright (C) 2019 vince <vince@node51>
#
# Distributed under terms of the MIT license.
#

set -e

# step 1: 安装必要的一些系统工具
yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装 Docker-CE
yum makecache fast
yum -y install docker-ce
# Step 4: 设置国内镜像源
mkdir -p /etc/docker    
tee /etc/docker/daemon.json <<-'EOF'
{
      "registry-mirrors": ["https://registry.docker-cn.com"]
  }
EOF
systemctl enable docker
systemctl start docker

curl http://mirrors.aliyun.com/docker-toolbox/linux/compose/1.21.2/docker-compose-Linux-x86_64 -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
echo "docker & docker-compose installed"
