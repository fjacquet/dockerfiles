# docker build . -t consul --rm
# docker run -ti consul
FROM docker.io/library/alpine:3 AS builder

ENV CONSUL_VERSION=1.22.3

RUN apk add --no-cache curl unzip && \
    ARCH="$(uname -m)" && \
    case "${ARCH}" in \
        x86_64)  CONSUL_ARCH="amd64" ;; \
        aarch64) CONSUL_ARCH="arm64" ;; \
        *)       echo "Unsupported arch: ${ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL -o /tmp/consul.zip \
        "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${CONSUL_ARCH}.zip" && \
    unzip -d /tmp /tmp/consul.zip && \
    rm -f /tmp/consul.zip

FROM docker.io/library/alpine:3
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="consul" \
      org.opencontainers.image.description="HashiCorp Consul service mesh" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"

VOLUME /consul/data

# Server RPC
EXPOSE 8300
# Serf LAN and WAN
EXPOSE 8301 8301/udp 8302 8302/udp
# HTTP and DNS
EXPOSE 8500 8600 8600/udp

RUN addgroup consul && \
    adduser -S -G consul consul

RUN apk add --no-cache ca-certificates dumb-init su-exec libcap && \
    mkdir -p /consul/data /consul/config && \
    chown -R consul:consul /consul

COPY --from=builder /tmp/consul /bin/consul
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget -qO /dev/null http://localhost:8500/v1/agent/self || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["consul", "agent", "-dev", "-client", "0.0.0.0"]
