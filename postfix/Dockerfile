# docker build . -t postfix --rm
# docker run -ti postfix
FROM alpine:3
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>"
EXPOSE 25
# hadolint ignore=DL3018
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

STOPSIGNAL SIGKILL

ENTRYPOINT ["/usr/sbin/runit_bootstrap"]
