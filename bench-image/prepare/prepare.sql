/*
 * prepare.sql
 * Copyright (C) 2019 vince <vince@tang-pc>
 *
 * Distributed under terms of the MIT license.
 */

CREATE TABLE `sbtest` (
`id` int(10) unsigned NOT NULL auto_increment,
`k` int(10) unsigned NOT NULL default '0',
`c` char(120) NOT NULL default '',
`pad` char(60) NOT NULL default '',
PRIMARY KEY  (`id`),
KEY `k` (`k`)
);
