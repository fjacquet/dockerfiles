# This is basic wordpress image dockerfile
# docker build . -t wordpress --rm
# docker run -ti wordpress
FROM almalinux:10 AS builder

RUN dnf -y update && \
    dnf -y install curl tar gzip && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN curl -LO https://wordpress.org/latest.tar.gz && \
    tar xzf /latest.tar.gz -C /tmp && \
    rm -f /latest.tar.gz

FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="wordpress" \
      org.opencontainers.image.description="WordPress CMS with Apache and PHP" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"

RUN dnf -y update && \
    dnf -y install httpd php php-mysqlnd php-gd openssl psmisc curl && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY --from=builder /tmp/wordpress/ /var/www/html/
COPY scripts /scripts
RUN chown -R apache:apache /var/www/ && \
    chmod 755 /scripts/*

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["/bin/bash", "/scripts/start.sh"]
