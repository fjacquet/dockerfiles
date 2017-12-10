# This is a test snmp utils dockerfile
# docker build . -t snmp --compress --squash
# docker run -ti snmp --compress --squash
FROM centos:latest
MAINTAINER Frederic Jacquet <fred@ljf.ch>
# install main packages:
RUN yum install -y deltarpm net-snmp nmap net-snmp-utils  && yum -y update && yum clean all
#ENTRYPOINT [ "/"]
CMD [ "/bin/bash" ]
