# This is basic wordpress image dockerfile
# docker build . -t wordpress --compress --rm  --squash
# docker run -ti wordpress
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>" 
RUN yum -y --setopt=tsflags=nodocs update  && yum clean all

RUN yum -y --setopt=tsflags=nodocs install httpd php php-mysql php-gd openssl psmisc tar && \
    yum clean all && rm -rf /var/cache/yum

ADD scripts /scripts
RUN curl -LO http://wordpress.org/latest.tar.gz                         && \
    tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1       && \
    rm /latest.tar.gz                                                   && \
    chown -R apache:apache /var/www/                                    && \
    chmod 755 /scripts/*

EXPOSE 80
CMD ["/bin/bash", "/scripts/start.sh"]
