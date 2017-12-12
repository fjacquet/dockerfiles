# This is EMC VNX Command line tools
# docker build . -t vnxcli:7.33-84 --compress --squash
# docker run -ti vnxcli:7.33-84
FROM centos:latest
LABEL maintainer Frederic Jacquet <fred@ljf.ch>
# install main packages:
ADD container-image-root /
ENV PATH /opt/Navisphere/bin:$PATH
RUN yum install -y deltarpm && yum -y update && yum clean all
RUN rpm -ivh NaviCLI-Linux-64-x86-en_US-7.33.9.1.84-1.x86_64.rpm
RUN /setlevel.sh
RUN rm /NaviCLI-Linux-64-x86-en_US-7.33.9.1.84-1.x86_64.rpm
#ENTRYPOINT [ "/"]
CMD [ "/bin/bash" ]
