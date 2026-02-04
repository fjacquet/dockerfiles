# This is basic wordpress image dockerfile
# docker build . -t wordpress --rm
# docker run -ti wordpress
FROM almalinux:10 AS builder

# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install curl tar gzip && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN curl -LO https://wordpress.org/latest.tar.gz && \
    tar xzf /latest.tar.gz -C /tmp && \
    rm -f /latest.tar.gz

FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"

# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install httpd php php-mysqlnd php-gd openssl psmisc && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY --from=builder /tmp/wordpress/ /var/www/html/
COPY scripts /scripts
RUN chown -R apache:apache /var/www/ && \
    chmod 755 /scripts/*

EXPOSE 80
CMD ["/bin/bash", "/scripts/start.sh"]
