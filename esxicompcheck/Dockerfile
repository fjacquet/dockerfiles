# This is VMware Command line tools and contrib
# docker build . -t esxicompcheck --compress --rm --squash
# docker run -ti esxicompcheck
FROM photon:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# Set the working directory to /root
WORKDIR /root
VOLUME "/root/src"
ENV http_proxy ""
ENV ftp_proxy  ""

# Install prereq
ADD compchecker-v1-20210219.zip /root/
#RUN tdnf update -y
# RUN tdnf install -y python3 python3-xml bash python3-devel unzip linux-headers libc-devel gcc openssl openssl-devel libffi-devel
RUN tdnf install -y python3 python3-xml  python3-devel unzip
#gcc openssl openssl-devel libffi-devel bash
RUN python3 -m ensurepip && pip3 install --upgrade pip && pip3 install pyVim pyvmomi crypto pyopenssl
RUN unzip /root/compchecker-v1-20210219.zip && rm /root/compchecker-v1-20210219.zip


# Run Bash when the image starts
CMD ["/bin/bash"]
