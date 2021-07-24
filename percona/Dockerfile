# This is basic httpd image dockerfile
# docker build . -t percona --compress --rm  --squash
# docker run -ti percona
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"

###
### Envs
###
RUN dnf -y update
# Version
# Check for Updates:
# https://dev.mysql.com/downloads/repo/dnf/
ENV dnf_REPO_URL="https://repo.percona.com/yum/percona-release-latest.noarch.rpm"

# User/Group
ENV MY_USER="mysql"
ENV MY_GROUP="mysql"
ENV MY_UID="48"
ENV MY_GID="48"

# Files
ENV MYSQL_BASE_INCL="/etc/my.cnf.d"
ENV MYSQL_CUST_INCL1="/etc/mysql/conf.d"
ENV MYSQL_CUST_INCL2="/etc/mysql/docker-default.d"
ENV MYSQL_DEF_DAT="/var/lib/mysql"
ENV MYSQL_DEF_LOG="/var/log/mysql"
ENV MYSQL_DEF_PID="/var/run/mysqld"
ENV MYSQL_DEF_SCK="/var/sock/mysqld"

ENV MYSQL_LOG_SLOW="${MYSQL_DEF_LOG}/slow.log"
ENV MYSQL_LOG_ERROR="${MYSQL_DEF_LOG}/error.log"
ENV MYSQL_LOG_QUERY="${MYSQL_DEF_LOG}/query.log"

###
### Install
###
RUN groupadd -g ${MY_GID} -r ${MY_GROUP} && \
	adduser ${MY_USER} -u ${MY_UID} -M -s /sbin/nologin -g ${MY_GROUP}

RUN \
	dnf -y install  --setopt=tsflags=nodocs epel-release && \
	dnf -y install  --setopt=tsflags=nodocs ${dnf_REPO_URL} && \
	dnf clean all

RUN dnf -y  --setopt=tsflags=nodocs update && dnf -y  --setopt=tsflags=nodocs install \
	percona-server-server

RUN \
	dnf -y autoremove && \
	dnf clean metadata && \
	dnf clean all && \
	dnf -y install  --setopt=tsflags=nodocs hostname && \
	dnf clean all


##
## Configure
##
RUN \
	rm -rf ${MYSQL_BASE_INCL} && \
	rm -rf ${MYSQL_CUST_INCL1} && \
	rm -rf ${MYSQL_CUST_INCL2} && \
	rm -rf ${MYSQL_DEF_DAT} && \
	rm -rf ${MYSQL_DEF_SCK} && \
	rm -rf ${MYSQL_DEF_PID} && \
	rm -rf ${MYSQL_DEF_LOG} && \
	\
	mkdir -p ${MYSQL_BASE_INCL} && \
	mkdir -p ${MYSQL_CUST_INCL1} && \
	mkdir -p ${MYSQL_CUST_INCL2} && \
	mkdir -p ${MYSQL_DEF_DAT} && \
	mkdir -p ${MYSQL_DEF_SCK} && \
	mkdir -p ${MYSQL_DEF_PID} && \
	mkdir -p ${MYSQL_DEF_LOG} && \
	\
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_BASE_INCL} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_CUST_INCL1} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_CUST_INCL2} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_DAT} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_SCK} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_PID} && \
	chown -R ${MY_USER}:${MY_GROUP} ${MYSQL_DEF_LOG} && \
	\
	chmod 0775 ${MYSQL_BASE_INCL} && \
	chmod 0775 ${MYSQL_CUST_INCL1} && \
	chmod 0775 ${MYSQL_CUST_INCL2} && \
	chmod 0775 ${MYSQL_DEF_DAT} && \
	chmod 0775 ${MYSQL_DEF_SCK} && \
	chmod 0775 ${MYSQL_DEF_PID} && \
	chmod 0775 ${MYSQL_DEF_LOG}

RUN \
	echo "[client]"                                         > /etc/my.cnf && \
	echo "socket = ${MYSQL_DEF_SCK}/mysqld.sock"           >> /etc/my.cnf && \
	\
	echo "[mysql]"                                         >> /etc/my.cnf && \
	echo "socket = ${MYSQL_DEF_SCK}/mysqld.sock"           >> /etc/my.cnf && \
	\
	echo "[mysqld]"                                        >> /etc/my.cnf && \
	echo "skip-host-cache"                                 >> /etc/my.cnf && \
	echo "skip-name-resolve"                               >> /etc/my.cnf && \
	echo "datadir = ${MYSQL_DEF_DAT}"                      >> /etc/my.cnf && \
	echo "user = ${MY_USER}"                               >> /etc/my.cnf && \
	echo "port = 3306"                                     >> /etc/my.cnf && \
	echo "bind-address = 0.0.0.0"                          >> /etc/my.cnf && \
	echo "socket = ${MYSQL_DEF_SCK}/mysqld.sock"           >> /etc/my.cnf && \
	echo "pid-file = ${MYSQL_DEF_PID}/mysqld.pid"          >> /etc/my.cnf && \
	echo "general_log_file = ${MYSQL_LOG_QUERY}"           >> /etc/my.cnf && \
	echo "slow_query_log_file = ${MYSQL_LOG_SLOW}"         >> /etc/my.cnf && \
	echo "log-error = ${MYSQL_LOG_ERROR}"                  >> /etc/my.cnf && \
	echo "!includedir ${MYSQL_BASE_INCL}/"                 >> /etc/my.cnf && \
	echo "!includedir ${MYSQL_CUST_INCL1}/"                >> /etc/my.cnf && \
	echo "!includedir ${MYSQL_CUST_INCL2}/"                >> /etc/my.cnf


##
## Bootstrap Scipts
##
COPY ./scripts/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

##
## Ports
##
EXPOSE 3306


##
## Volumes
##
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /var/sock/mysqld
VOLUME /etc/mysql/conf.d
VOLUME etc/mysql/docker-default.d


##
## Entrypoint
##
ENTRYPOINT ["/docker-entrypoint.sh"]