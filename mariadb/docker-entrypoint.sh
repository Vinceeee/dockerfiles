#!/bin/bash
echo "start mysql ..."

/etc/init.d/mysql start

exec "$@"
