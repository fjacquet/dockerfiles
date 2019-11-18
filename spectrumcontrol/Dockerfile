# This is IBM Storage VASA provider
# docker build . -t scbe:3.2.1 --compress --squash
# docker run -ti scbe:3.2.1
FROM centos:latest
LABEL maintainer Frederic Jacquet <fred@ljf.ch>
VOLUME [ "/sys/fs/cgroup" ]
# install main packages:
ADD container-image-root/IBM_Spectrum_Control_Base_Edition-3.2.1-9432-x86_64.tar.gz /tmp

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
# RUN  systemctl enable rabbitmq
RUN chmod 755 /setup.sh && /setup.sh
#ENTRYPOINT [ "/"]
CMD ["/usr/sbin/init"]