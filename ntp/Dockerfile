# This is ISC NTP container image dockerfile
# docker build . -t ntp --rm
# docker run -ti ntp
FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf install -y chrony && \
    dnf clean all && \
    rm -rf /var/cache/dnf
ENTRYPOINT ["/usr/sbin/chronyd"]
CMD ["-d", "/etc/chrony.conf"]
EXPOSE 123
LABEL run="docker run -d --cap-add='SYS_TIME' --name NAME IMAGE" \
      stop="docker stop NAME" \
      name="ntpd daemon"
