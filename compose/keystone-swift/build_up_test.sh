#! /bin/sh
#
# build_up_test.sh
# Copyright (C) 2019 vince <vince@cl1010>
#
# Distributed under terms of the MIT license.
#


docker system prune
docker volume prune

docker-compose build
docker-compose up -d
