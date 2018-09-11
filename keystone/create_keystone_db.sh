#!/usr/bin/env sh

CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'192.168.10.106' \
    IDENTIFIED BY 'KEYSTONE_DBPASS';
