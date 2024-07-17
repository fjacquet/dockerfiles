# This is basic wordpress image dockerfile
# curl -LO http://wordpress.org/latest.tar.gz
# docker build . -t wordpress --compress --rm  --squash
# docker run -ti wordpress
FROM almalinux:9.3-minimal
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
RUN dnf -y update

RUN dnf -y install httpd php php-mysqlnd php-gd openssl psmisc tar && \
    dnf clean all && rm -rf /var/cache/yum

ADD scripts /scripts
RUN curl -LO http://wordpress.org/latest.tar.gz                         && \
    tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1       && \
    rm /latest.tar.gz                                                   && \
    chown -R apache:apache /var/www/                                    && \
    chmod 755 /scripts/*

EXPOSE 80
CMD ["/bin/bash", "/scripts/start.sh"]
