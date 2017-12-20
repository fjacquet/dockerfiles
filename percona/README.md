# percona cluster  database

## Description

Latest version of percona database on centos 7 to provide a nice storage for redundant projects

## Running

Simple allow tcp port 3306 to go to whatever to get the access

## Volume

* /var/lib/mysql : MySQL data dir
* /var/log/mysql : MySQL log dir
* /var/sock/mysqld : MySQL socket dir
* /etc/mysql/conf.d : MySQL configuration directory (used to overwrite MySQL config)
* /etc/mysql/docker-default.d : MySQL configuration directory (used to overwrite MySQL config)

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
* DEBUG_COMPOSE_ENTRYPOINT (boolean)
* TIMEZONE : Set docker OS timezone example: Europe/Zurich
* MYSQL_SOCKET_DIR : Path inside the docker to the socket directory
* MYSQL_GENERAL_LOG : Turn on or off general logging

Please note :

* MYSQL_ALLOW_EMPTY_PASSWORD is NOT recommended *

## Usage

**1. Listen on loopback interface only**

```bash
$ docker run -i \
    -p 127.0.0.1:3306:3306 \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -t fjacquet/percona
```

Access MySQL from your host computer

```bash
$ mysql --user=root --password=my-secret-pw --host=127.0.0.1 -e 'show databases;'
```

**2. Enable logging**

Enable logging and mount the log directory to your host to ~tmp/mysql-log

```bash
$ docker run -i \
    -p 127.0.0.1:3306:3306 \
    -v ~tmp/mysql-log:/var/log/mysql \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -e MYSQL_GENERAL_LOG=1 \
    -t fjacquet/percona
```

 Access MySQL from your host computer

```bash
$ mysql --user=root --password=my-secret-pw --host=127.0.0.1 -e 'show databases;'
```

**3. Mount MySQL socket to the host**

Use MySQL socket for localhost connections through the socket. No need to expose the MySQL port to the host in this case.

```bash
$ docker run -i \
    -v ~tmp/mysql-sock:/var/sock/mysqld \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -t fjacquet/percona
```

 Access MySQL from your host computer via socket

```bash
$ mysql --user=root --password=my-secret-pw --socket=/var/sock/mysqld/mysqld.sock -e 'show databases;'
```

**4. Overwrite configuration**

You can also add any configuration settings prior startup to MySQL.

**Create local config with buffer overwrite**

```bash
$ printf "[mysqld]\n%s\n" "key_buffer = 500M" > ~/tmp/mysqld_config/buffer.cnf

$ docker run -i \
    -p 127.0.0.1:3306:3306 \
    -v ~/tmp/mysqld_config:/etc/mysql/conf.d \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
    -t fjacquet/percona
```