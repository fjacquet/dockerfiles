FROM ubuntu:latest
MAINTAINER Frederic Jacquet <fred@ljf.ch>
# Set the working directory to /root
WORKDIR /root
ENV http_proxy ""
ENV ftp_proxy  ""
# Update apt-get
RUN apt-get update
## -------- vSphere -------- ##
# Install vCLI Pre-Reqs
RUN apt-get install -yq build-essential lsb e2fsprogs inetutils-ping ash git \
      expect kmod perl-doc  wget  uuid uuid-dev libssl-dev libffi-dev  \
      libxml2-dev libxslt-dev libxml-libxml-perl  libarchive-zip-perl  \
      libmodule-build-perl  libextutils-makemaker-cpanfile-perl  libuuid-perl  \
      libcrypt-ssleay-perl libclass-methodmaker-perl libdata-dump-perl  \
      libsoap-lite-perl libdevel-stacktrace-perl libclass-data-inheritable-perl \
       libconvert-asn1-perl libcrypt-openssl-rsa-perl libcrypt-x509-perl \
       libexception-class-perl libpath-class-perl  libsocket6-perl  \
      libio-socket-inet6-perl  libnet-inet6glue-perl python python-dev  \
      python-pip python-virtualenv  ruby-full gem  default-jre  \
       golang golang-context-dev
RUN apt-get clean

# Install vCLI https://developercenter.vmware.com/web/dp/tool/vsphere_cli/5.5
ADD VMware-vSphere-CLI-6.0.0-3561779.x86_64.tar.gz /tmp/
ADD VMware-ovftool-4.1.0-2459827-lin.x86_64.bundle /tmp/
ADD VMware-vix-disklib-6.0.2-3566099.x86_64.tar.gz /tmp/
ADD VMware_vRealize_CloudClient-4.2.0-4287344.zip /tmp/
RUN echo yes | cpan
RUN cpan install UUID::Random
RUN yes | /tmp/vmware-vsphere-cli-distrib/vmware-install.pl -d && rm -rf /tmp/vmware-vsphere-cli-distrib
# Install VMware OVFTool http://vmware.com/go/ovftool
RUN yes | /bin/bash /tmp/VMware-ovftool-4.1.0-2459827-lin.x86_64.bundle --required --console && rm -f /tmp/VMware-ovftool-4.1.0-2459827-lin.x86_64.bundle
# Install VDDK
#RUN yes | /tmp/vmware-vix-disklib-distrib/vmware-install.pl -d &&   rm -rf /tmp/vmware-vix-disklib-distrib
# Install Cloud Client https://my.vmware.com/group/vmware/get-download?downloadGroup=CLOUDCLIENT_420&productId=601
RUN unzip /tmp/VMware_vRealize_CloudClient-4.2.0-4287344.zip -d /root &&  rm -rf /tmp/VMware_vRealize_CloudClient-4.2.0-4287344.zip
# Add William Lams awesome scripts from vGhetto Script Repository
RUN mkdir /root/vghetto && git clone https://github.com/lamw/vghetto-scripts.git /root/vghetto
# Install pyVmomi (vSphere SDK for Python)
RUN git clone https://github.com/vmware/pyvmomi.git /root/pyvmomi
# Install rbVmomi & RVC & RaaS CLI
RUN gem install rbvmomi rvc  RaaS
## -------- vCloud Director -------- ##
# Install vcloud-tools
RUN gem install --no-rdoc --no-ri vcloud-tools
# Install vCloud SDK for Python
RUN easy_install -U pip
## -------- vCloud Air -------- ##
# Install vca-cli
RUN pip install vca-cli pyvcloud

## vRealize Management Suite ##
# Install govc CLI
ENV GOPATH /root/src/go
RUN mkdir -p $GOPATH $GOPATH/bin
ENV PATH $PATH:$GOPATH/bin
RUN wget https://github.com/vmware/govmomi/releases/download/v0.8.0/govc_linux_amd64.gz  -O /root/src/go/bin/govc.gz
RUN gunzip /root/src/go/bin/govc.gz
RUN chmod 755 /root/src/go/bin/govc
#RUN go get github.com/vmware/govmomi/govc

# Run Bash when the image starts
CMD ["/bin/bash"]