1. 修改 compose文件以下两项为本地ip。
```
      - KEYSTONE_BIND_IP=192.168.10.10
      - SWIFT_ENDPOINT=192.168.10.10:8080
```

2. 执行`docker-compo up -d`

3. 安装swiftclient到本地 `pip install python-swiftclient`

4. 配置账户信息
