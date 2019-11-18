# This is a test snmp utils dockerfile
# docker build . -t snmp --compress --squash
# docker run -ti snmp --compress --squash
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# install main packages:
RUN yum install -y --setopt=tsflags=nodocs deltarpm net-snmp nmap net-snmp-utils  && \
    yum -y update && \
    yum clean all  & rm -rf /var/cache/yum 
#ENTRYPOINT [ "/"]
CMD [ "/bin/bash" ]
