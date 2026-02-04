# docker build . -t consul --rm
# docker run -ti consul
FROM alpine:3
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"

ENV CONSUL_VERSION=1.22.3

VOLUME /consul/data

# Server RPC
EXPOSE 8300
# Serf LAN and WAN
EXPOSE 8301 8301/udp 8302 8302/udp
# HTTP and DNS
EXPOSE 8500 8600 8600/udp

RUN addgroup consul && \
    adduser -S -G consul consul

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates curl dumb-init su-exec libcap && \
    ARCH="$(uname -m)" && \
    case "${ARCH}" in \
        x86_64)  CONSUL_ARCH="amd64" ;; \
        aarch64) CONSUL_ARCH="arm64" ;; \
        *)       echo "Unsupported arch: ${ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL -o /tmp/consul.zip \
        "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${CONSUL_ARCH}.zip" && \
    unzip -d /bin /tmp/consul.zip && \
    rm -f /tmp/consul.zip && \
    mkdir -p /consul/data /consul/config && \
    chown -R consul:consul /consul

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["consul", "agent", "-dev", "-client", "0.0.0.0"]
