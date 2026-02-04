# maria database

## Description

MariaDB database server on AlmaLinux 10 to provide storage for the test WordPress container

## Running

Simple allow tcp port 3306 to go to whatever to get the access

## Volume

/var/lib/mysql  can be overridden to provide custom content.

## Parameters

Need to provide environment variables :

* MYSQL_ROOT_PASSWORD
* MYSQL_ALLOW_EMPTY_PASSWORD
* MYSQL_DATABASE

Should also provides :

* MYSQL_USER
* MYSQL_PASSWORD

Can also provides :

* MYSQL_COLLATION
* MYSQL_CHARSET

Please note :

* MYSQL_ALLOW_EMPTY_PASSWORD is NOT recommended *
