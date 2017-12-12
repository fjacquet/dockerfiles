# This is EMC Unity Command line tools
# docker build . -t uemcli:4.2.1-2069 --compress --squash
# docker run -ti uemcli:4.2.1-2069
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# install main packages:
ADD container-image-root /
ENV PATH /opt/emc/uemcli/bin/:$PATH
ENV LD_LIBRARY_PATH /opt/emc/uemcli/lib/:$LD_LIBRARY_PATH
RUN rpm -ivh UnisphereCLI-Linux-64-x86-en_US-4.2.1.1.2069-1.x86_64.rpm
RUN /opt/emc/uemcli/bin/setlevel.sh low
RUN rm UnisphereCLI-Linux-64-x86-en_US-4.2.1.1.2069-1.x86_64.rpm
#ENTRYPOINT [ "/"]
CMD [ "/bin/bash" ]
