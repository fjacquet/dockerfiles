# This is EMC VNX Command line tools
# docker build . -t vnxcli:7.33-84 --compress --squash --rm
# docker run -ti vnxcli:7.33-84
FROM almalinux:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
RUN dnf -y update
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL maintainer "Frederic Jacquet <fred@ljf.ch>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="VNX cli" \
    org.label-schema.description="a small container to manage DELL EMC VNX" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="e.g. https://github.com/microscaling/microscaling" \
    org.label-schema.vendor="e.g. ACME Inc" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
# install main packages:
ADD container-image-root /
ENV PATH /opt/Navisphere/bin:$PATH
RUN dnf install -y libnsl  && dnf clean all
RUN rpm -ivh NaviCLI-Linux-64-x86-en_US-7.33.9.1.84-1.x86_64.rpm
RUN /setlevel.sh
RUN rm /NaviCLI-Linux-64-x86-en_US-7.33.9.1.84-1.x86_64.rpm
#ENTRYPOINT [ "/"]
CMD [ "/bin/bash" ]
