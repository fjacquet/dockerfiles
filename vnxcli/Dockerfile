# This is EMC VNX Command line tools
# docker build . -t vnxcli:7.33-84 --rm
# docker run -ti vnxcli:7.33-84
# Note: --platform=linux/amd64 is required because the vendor RPM is x86_64-only

# Stage 1: Extract vendor RPM
# hadolint ignore=DL3029
FROM --platform=linux/amd64 almalinux:9 AS builder
COPY container-image-root /
# hadolint ignore=DL3041
RUN dnf install -y libnsl && dnf clean all && rm -rf /var/cache/dnf
RUN rpm -ivh NaviCLI-Linux-64-x86-en_US-7.33.9.1.84-1.x86_64.rpm && \
    /setlevel.sh

# Stage 2: Minimal runtime
# hadolint ignore=DL3029
FROM --platform=linux/amd64 almalinux:9
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="VNX cli" \
    org.label-schema.description="a small container to manage DELL EMC VNX" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf install -y libnsl && \
    dnf clean all && \
    rm -rf /var/cache/dnf
ENV PATH=/opt/Navisphere/bin:$PATH
COPY --from=builder /opt/Navisphere /opt/Navisphere
CMD [ "/bin/bash" ]
