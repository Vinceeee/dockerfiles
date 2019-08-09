## swift 沙盒环境

该compose将在本机创建六个容器:
 - init-swift-ring: 创建swift环
 - proxy: swift代理节点1
 - storage1: swift存储节点1

### 0. 环境准备：

自动安装: 
Centos 7 的用户可执行`sh init-env.sh`,即可自动安装docker以及docker-compose

手动安装：
准备docker以及docker-compose，docker的安装可以参考 [阿里云docker-ce安装](https://yq.aliyun.com/articles/110806)。docker-compose则只需要直接下载二进制文件到$PATH目录中即可。（对于X86的 linux环境，可执行： `sudo curl http://mirrors.aliyun.com/docker-toolbox/linux/compose/1.21.2/docker-compose-Linux-x86_64 -o /usr/bin/docker-compose && sudo chmod +x /usr/bin/docker-compose `）

### 1. 准备docker-compose
修改 compose文件以下两项为本地绑定ip(可通过`ip route`或 `ifconfig` 查找)。
```
      - KEYSTONE_BIND_IP=$LOCAL_BIND_IP
      - SWIFT_ENDPOINT=$LOCAL_BIND_IP
```

###2. 启动沙盒环境
执行`docker-compo up -d`

3. 安装swiftclient到本地 `pip install python-swiftclient`

4. 配置账户信息,开始使用swift,默认会创建home用户,其openrc.sh如下(记得修改${LOCAL_BIND_IP}):
```
export OS_USERNAME=home
export OS_PASSWORD=123456
export OS_PROJECT_NAME=home
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://${LOCAL_BIND_IP}:5000/v3
export OS_IDENTITY_API_VERSION=3
```

修改LOCAL_BIND_IP后,并运行,则可在容器外部访问swift对象存储


###3. Test

```bash
# Check whether swift proxy is available
curl -v -H 'X-Storage-User: test:tester' -H 'X-Storage-Pass: testing' http://127.0.0.1:8080/auth/v1.0
swift -A http://127.0.0.1:8080 -U test:tester -K testing stat  # test stat
swift -A http://127.0.0.1:8080 -U test:tester -K testing upload abc /etc/yum.repos.d # test upload
```
