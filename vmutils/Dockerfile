# This is VMware Command line tools and contrib
# docker build . -t vmutils --compress --rm --squash
# docker run -ti vmutils
FROM ubuntu:bionic
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# Set the working directory to /root
WORKDIR /root
VOLUME "/root/src"
ENV http_proxy ""
ENV ftp_proxy ""
ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ADD VMware-vSphere-CLI-6.5.0-4566394.x86_64.tar.gz /tmp/
ADD VMware-ovftool-4.2.0-5965791-lin.x86_64.bundle /tmp/
ADD VMware-vix-disklib-6.5.2-6195444.x86_64.tar.gz /tmp/
ADD VMware_vRealize_CloudClient-4.4.0-5511232.zip /tmp/
ADD compchecker_v1_8951845.zip /tmp/

RUN apt-get -y update 
RUN apt-get install -yq gnupg2 curl
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list |tee /etc/apt/sources.list.d/microsoft.list
RUN apt-get -y update 

RUN apt-get install -yq build-essential e2fsprogs inetutils-ping ash git \
	expect kmod perl-doc uuid uuid-dev libssl-dev libffi-dev \
	libxml2-dev libxslt-dev libxml-libxml-perl libarchive-zip-perl \
	libmodule-build-perl libextutils-makemaker-cpanfile-perl libuuid-perl \
	libcrypt-ssleay-perl libclass-methodmaker-perl libdata-dump-perl \
	libsoap-lite-perl libdevel-stacktrace-perl libclass-data-inheritable-perl \
	libconvert-asn1-perl libcrypt-openssl-rsa-perl libcrypt-x509-perl \
	libexception-class-perl libpath-class-perl libsocket6-perl \
	libio-socket-inet6-perl libnet-inet6glue-perl ruby-full gem \
	golang golang-context-dev python3 bash python3-dev python3-pip \
	libc-dev gcc openssl libssl-dev powershell-preview 

RUN curl https://communities.cisco.com/servlet/JiveServlet/download/74217-3-149644/ucspowertoolcore.zip -o /tmp/ucspowertoolcore.zip 
# Install vCLI https://developercenter.vmware.com/web/dp/tool/vsphere_cli/6.5
RUN echo yes | cpan && cpan install UUID::Random
RUN yes | /tmp/vmware-vsphere-cli-distrib/vmware-install.pl -d && rm -rf /tmp/vmware-vsphere-cli-distrib
# Install VMware OVFTool http://vmware.com/go/ovftool
RUN yes | /bin/bash /tmp/VMware-ovftool-4.2.0-5965791-lin.x86_64.bundle --required --console && rm -f /tmp/VMware-ovftool-4.2.0-5965791-lin.x86_64.bundle
# Install VDDK
RUN mv /tmp/vmware-vix-disklib-distrib/ /root/src && rm -rf /tmp/vmware-vix-disklib-distrib
# Install Cloud Client https://my.vmware.com/group/vmware/get-download?downloadGroup=CLOUDCLIENT_420&productId=601
RUN unzip /tmp/VMware_vRealize_CloudClient-4.4.0-5511232.zip -d /root && rm -rf /tmp/VMware_vRealize_CloudClient-4.4.0-5511232.zip
# Install ESXi Compliancy Checker Flings
RUN unzip /tmp/compchecker_v1_8951845.zip -d /root && rm -rf /tmp/compchecker_v1_8951845.zip 
# Add William Lams awesome scripts from vGhetto Script Repository
RUN mkdir /root/vghetto && git clone https://github.com/lamw/vghetto-scripts.git /root/vghetto
# Install rbVmomi & RVC & RaaS CLI
RUN gem install rbvmomi rvc RaaS
# Install vcloud-tools
RUN gem install --no-rdoc --no-ri vcloud-tools
# Install govc CLI
RUN go get github.com/vmware/govmomi/govc
# Install vca-cli & python modules
RUN pip3 install vca-cli pyvcloud pyVim pyvmomi crypto pyopenssl
# Install PowerCLI
RUN apt-get -y upgrade && apt-get clean
RUN rm -rf /var/lib/apt/lists*
RUN ln -s /usr/bin/pwsh-preview /usr/bin/pwsh
RUN mkdir -p /root/.local/share/powershell/Modules && unzip /tmp/ucspowertoolcore.zip -d /root/.local/share/powershell/Modules && rm -rf /tmp/ucspowertoolcore.zip 
RUN pwsh -ex unrestricted -noni -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name AWSPowerShell 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name CredentialManager
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name IsilonPlatform 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name JiraPS
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name Pester
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name posh-git
RUN pwsh -ex unrestricted -noni -Command Install-Module -name PoSH-SSH 
RUN pwsh -ex unrestricted -noni -Command Install-Module -name PSExcel 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name PSLogging
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name PSScriptAnalyzer
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name PowerNSX 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name Unity-Powershell 
RUN pwsh -ex unrestricted -noni -Command Install-Module -name VMware.PowerCLI
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name VPLEX-Powershell 
RUN echo "alias start-ucs=pwsh –NoExit –File ~/.local/share/powershell/Modules/Start-UcsPowerTool.ps1" >> ./.bashrc 

# Run Bash when the image starts
CMD ["/bin/bash"]