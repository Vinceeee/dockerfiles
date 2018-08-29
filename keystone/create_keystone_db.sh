#!/usr/bin/env sh

CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
    IDENTIFIED BY 'KEYSTONE_DBPASS';
