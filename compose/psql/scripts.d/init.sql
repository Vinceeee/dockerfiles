/*
 * init.sql
 * Copyright (C) 2019 vince <vince@tang-pc>
 *
    init a galera user for gluster health check
    only grant read privileges
 * Distributed under terms of the MIT license.
 */

/* 
CREATE USER "test" with password '123456';
*/
CREATE USER "test";
ALTER USER "test" password '123456';
CREATE DATABASE db_test ENCODING 'utf8' OWNER "test";
