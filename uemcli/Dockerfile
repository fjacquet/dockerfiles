# This is EMC Unity Command line tools
# docker build . -t uemcli:4.2.1-2069 --rm
# docker run -ti uemcli:4.2.1-2069
# Note: --platform=linux/amd64 is required because the vendor RPM is x86_64-only

# Stage 1: Extract vendor RPM
# hadolint ignore=DL3029
FROM --platform=linux/amd64 almalinux:9 AS builder
COPY container-image-root /
RUN rpm -ivh UnisphereCLI-Linux-64-x86-en_US-4.2.1.1.2069-1.x86_64.rpm && \
    /opt/emc/uemcli/bin/setlevel.sh low

# Stage 2: Minimal runtime
# hadolint ignore=DL3029
FROM --platform=linux/amd64 almalinux:9
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
RUN dnf -y update && \
    dnf clean all && \
    rm -rf /var/cache/dnf
ENV PATH=/opt/emc/uemcli/bin/:$PATH
COPY --from=builder /opt/emc /opt/emc
CMD [ "/bin/bash" ]
