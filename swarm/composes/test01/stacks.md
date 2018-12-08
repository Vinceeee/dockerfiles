# 使用docker stack 启动 docker-compose 文件 （ docker swarm 与 docker-compose 结合 )

- 准备好docker-compose.yaml 文件，特别地，每个服务有deploy层。

- docker stack deploy -c yaml $(cluster-name)
