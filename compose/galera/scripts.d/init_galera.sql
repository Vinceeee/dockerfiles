/*
 * init_galera.sql
 * Copyright (C) 2019 vince <vince@tang-pc>
 *
    init a galera user for gluster health check
    only grant read privileges
 * Distributed under terms of the MIT license.
 */

CREATE USER 'galera'@'%' IDENTIFIED BY 'galera';
CREATE DATABASE IF NOT EXISTS db_galera;
GRANT  SELECT on db_galera.* TO 'galera'@'%';
