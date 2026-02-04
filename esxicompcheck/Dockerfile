# This is VMware ESXi compatibility checker
# docker build . -t esxicompcheck --rm
# docker run -ti esxicompcheck
FROM almalinux:10 AS builder
WORKDIR /root

# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install python3 python3-devel python3-pip unzip && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY compchecker-v1-20210219.zip /root/
# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir --prefix=/usr/local pyVim pyvmomi crypto pyopenssl && \
    unzip /root/compchecker-v1-20210219.zip && \
    rm -f /root/compchecker-v1-20210219.zip

FROM almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
WORKDIR /root
VOLUME "/root/src"

# hadolint ignore=DL3041
RUN dnf -y update && \
    dnf -y install python3 && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /root/compchecker-v1-20210219 /root/compchecker-v1-20210219

CMD ["/bin/bash"]
