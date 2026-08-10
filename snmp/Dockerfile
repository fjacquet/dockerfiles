# This is a SNMP utils dockerfile
# docker build . -t snmp --rm
# docker run -ti snmp
FROM docker.io/library/almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="snmp" \
      org.opencontainers.image.description="SNMP network management utilities" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"
RUN dnf -y update && \
    dnf -y install net-snmp net-snmp-utils nmap && \
    dnf clean all && \
    rm -rf /var/cache/dnf
CMD ["/bin/bash"]
