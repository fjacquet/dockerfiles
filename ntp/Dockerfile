# This is ISC NTP container image dockerfile
# docker build . -t ntp --compress --rm  --squash
# docker run -ti ntp
FROM almalinux:9.3-minimal
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# install main packages:
RUN dnf -y update
RUN dnf install -y chrony \
      && dnf -y clean all
#ENTRYPOINT [ "/"]
# CMD ["/bin/bash"]
ENTRYPOINT ["/usr/sbin/chronyd"]
CMD ["-d", "/etc/chrony.conf "]
EXPOSE 123

LABEL RUN="docker run -d --cap-add='SYS_TIME' --name NAME IMAGE" \
      STOP="docker stop NAME" \
      name="ntpd daemon"