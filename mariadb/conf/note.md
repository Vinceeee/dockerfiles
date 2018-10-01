# mariadb galera setup

- 配置文件准备好(同步到各个数据库)
- 第一台galera启动的时候要加参数 --wrsep-new-cluster
- galera同步端口不是3306,而是4567,需要打开4567端口的访问权限（both tcp and udp)
