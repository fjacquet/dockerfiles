# This is EMC VNX Command line tools
# docker build . -t vnxcli:7.33-84 --rm
# docker run -ti vnxcli:7.33-84
# Note: --platform=linux/amd64 is required because the vendor RPM is x86_64-only

# Stage 1: Extract vendor RPM
FROM --platform=linux/amd64 docker.io/library/almalinux:9 AS builder
COPY container-image-root /
RUN dnf install -y libnsl && dnf clean all && rm -rf /var/cache/dnf
RUN rpm -ivh NaviCLI-Linux-64-x86-en_US-7.33.9.1.84-1.x86_64.rpm && \
    /setlevel.sh

# Stage 2: Minimal runtime
FROM --platform=linux/amd64 docker.io/library/almalinux:9
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="vnxcli" \
      org.opencontainers.image.description="Dell EMC VNX CLI management tools" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"
RUN dnf -y update && \
    dnf install -y libnsl && \
    dnf clean all && \
    rm -rf /var/cache/dnf
ENV PATH=/opt/Navisphere/bin:$PATH
COPY --from=builder /opt/Navisphere /opt/Navisphere
CMD [ "/bin/bash" ]
