# This is a SNMP utils dockerfile
# docker build . -t snmp --rm
# docker run -ti snmp
FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install net-snmp net-snmp-utils nmap && \
    dnf clean all && \
    rm -rf /var/cache/dnf
CMD ["/bin/bash"]
