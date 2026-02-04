# This is basic mariadb image dockerfile
# docker build . -t mariadb --rm
# docker run -ti mariadb
FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
EXPOSE 3306
# Place VOLUME statement below all changes to /var/lib/mysql
VOLUME /var/lib/mysql
# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install epel-release && \
    dnf -y install mariadb-server bind-utils pwgen psmisc hostname && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# Fix permissions to allow for running on openshift
COPY scripts/fix-permissions.sh /
COPY scripts/docker-entrypoint.sh /
RUN chmod +x /fix-permissions.sh /docker-entrypoint.sh && \
    ./fix-permissions.sh /var/lib/mysql/ && \
    ./fix-permissions.sh /var/log/mariadb/ && \
    ./fix-permissions.sh /var/run/

ENTRYPOINT ["/docker-entrypoint.sh"]
# By default will run as random user on openshift and the mysql user (27)
# everywhere else
USER 27
CMD ["mysqld_safe"]
