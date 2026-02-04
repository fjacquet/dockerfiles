# This is ISC NTP container image dockerfile
# docker build . -t ntp --rm
# docker run -ti ntp
FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="ntp" \
      org.opencontainers.image.description="NTP time synchronization daemon using chrony" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles" \
      run="docker run -d --cap-add='SYS_TIME' --name NAME IMAGE" \
      stop="docker stop NAME" \
      name="ntpd daemon"
RUN dnf -y update && \
    dnf install -y chrony && \
    dnf clean all && \
    rm -rf /var/cache/dnf
EXPOSE 123

HEALTHCHECK --interval=60s --timeout=5s --retries=3 \
    CMD chronyc tracking || exit 1

ENTRYPOINT ["/usr/sbin/chronyd"]
CMD ["-d", "/etc/chrony.conf"]
