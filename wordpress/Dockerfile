# This is basic wordpress image dockerfile
# docker build . -t wordpress --rm
# docker run -ti wordpress
FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install httpd php php-mysqlnd php-gd openssl psmisc tar curl && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY scripts /scripts
RUN curl -LO https://wordpress.org/latest.tar.gz && \
    tar xzf /latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm /latest.tar.gz && \
    chown -R apache:apache /var/www/ && \
    chmod 755 /scripts/*

EXPOSE 80
CMD ["/bin/bash", "/scripts/start.sh"]
