# This is a test snmp utils dockerfile
# docker build . -t snmp --compress --squash
# docker run -ti snmp --compress --squash
FROM photon:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# install main packages:
RUN tdnf update -y
RUN tdnf install -y  net-snmp nmap && tdnf clean all  && rm -rf /var/cache/yum
#ENTRYPOINT [ "/"]
CMD [ "/bin/bash" ]
