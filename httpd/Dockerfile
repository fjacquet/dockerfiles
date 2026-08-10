# This is basic httpd image dockerfile
# docker build . -t httpd --rm
# docker run -ti httpd
FROM docker.io/library/almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="httpd" \
      org.opencontainers.image.description="Apache HTTP Server" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"
VOLUME ["/var/www/html"]
RUN dnf -y update && \
    dnf -y install httpd curl && \
    dnf clean all && \
    rm -rf /var/cache/dnf
EXPOSE 80
COPY scripts/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["/run-httpd.sh"]
