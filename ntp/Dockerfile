# This is ISC Bind9 container image dockerfile
# it is IPv4 only
# docker build . -t ntp --compress --rm  --squash
# docker run -ti ntp
FROM centos:latest
MAINTAINER Frederic Jacquet <fred@ljf.ch>
# install main packages:
RUN yum install -y deltarpm ntp ntp-utils  && yum -y update && yum -y clean all && rm -rf /var/cache/yum
#ENTRYPOINT [ "/"]
ENTRYPOINT ["/usr/sbin/ntpd"]
CMD ["-n", "-b", "-g", "-l", "stdout"]
EXPOSE 123

LABEL RUN="docker run -d --cap-add='SYS_TIME' --name NAME IMAGE" \
      STOP="docker stop NAME" \
      name="ntpd daemon" 