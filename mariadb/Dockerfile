# This is basic httpd image dockerfile
# docker build . -t mariadb --compress --rm  --squash
# docker run -ti mariadb
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>" 

EXPOSE 3306
# Place VOLUME statement below all changes to /var/lib/mysql
VOLUME /var/lib/mysql

RUN yum -y update && yum -y install --setopt=tsflags=nodocs epel-release && \ 
    yum -y install --setopt=tsflags=nodocs mariadb-server bind-utils pwgen psmisc hostname && \ 
    yum -y erase vim-minimal && yum clean all && rm -rf /var/cache/yum


# Fix permissions to allow for running on openshift
COPY scripts/fix-permissions.sh /
COPY scripts/docker-entrypoint.sh /
RUN chmod +x /fix-permissions.sh /docker-entrypoint.sh
RUN ./fix-permissions.sh /var/lib/mysql/   && \
    ./fix-permissions.sh /var/log/mariadb/ && \
    ./fix-permissions.sh /var/run/

ENTRYPOINT ["/docker-entrypoint.sh"]
# By default will run as random user on openshift and the mysql user (27)
# everywhere else
USER 27
CMD ["mysqld_safe"]