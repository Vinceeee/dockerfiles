# some commands mark down

- create service (simple)
> Usage:  docker service create [OPTIONS] IMAGE [COMMAND] [ARG...] [flag]
'''
docker service create  --name nginx-cluster --network=swarm_test nginx:alpine
'''

- set node labels ( which is for placement contraints )
> Usage:  docker node update [OPTIONS] NODE [flags]
'''
docker node update --label-add="type=storage" s1015
'''

- create service by placement contraints
'''
docker service create  --constraint node.labels.type==proxy --name nginx-cluster -p 8088:80 --network=swarm_test nginx:alpine
'''
