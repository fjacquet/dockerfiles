# This is basic httpd image dockerfile
# docker build . -t httpd --rm
# docker run -ti httpd
FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
VOLUME ["/var/www/html"]
# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install httpd && \
    dnf clean all && \
    rm -rf /var/cache/dnf
EXPOSE 80
COPY scripts/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
CMD ["/run-httpd.sh"]
