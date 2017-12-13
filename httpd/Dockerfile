# This is basic httpd image dockerfile
# docker build . -t httpd --compress --rm  --squash
# docker run -ti httpd
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>" 
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all
EXPOSE 80 
# Simple startup script to avoid some issues observed with container restart 
COPY scripts/run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
CMD ["/run-httpd.sh"]