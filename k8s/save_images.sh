#!/usr/bin/env sh

# save all images
# 列出所有镜像
# 删除第一行表头信息
# 获取第一、二、三列数据，以空格隔开
docker images | sed '1d' | awk '{print $1 " " $2 " " $3}' > mydockersimages.list
