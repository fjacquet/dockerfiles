# docker build . -t postfix --rm
# docker run -ti postfix
FROM alpine:3
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="postfix" \
      org.opencontainers.image.description="Postfix mail transfer agent" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"
EXPOSE 25
RUN apk add --no-cache \
	bash \
	ca-certificates \
	libsasl \
	mailx \
	postfix \
	rsyslog \
	runit

COPY service /etc/service
COPY runit_bootstrap /usr/sbin/runit_bootstrap
COPY rsyslog.conf /etc/rsyslog.conf

HEALTHCHECK --interval=60s --timeout=5s --retries=3 \
    CMD postfix status || exit 1

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/sbin/runit_bootstrap"]
