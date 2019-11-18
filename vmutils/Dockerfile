# This is VMware Command line tools and contrib
# docker build . -t vmutils --compress --rm --squash
# docker run -ti vmutils
FROM  ubuntu:18.04
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# Set the working directory to /root
WORKDIR /root
VOLUME "/root/src"
ENV http_proxy ""
ENV ftp_proxy ""
ENV TZ=Europe/Zurich

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt -y update && apt install --no-install-recommends --yes -q gnupg2 curl golang inetutils-ping \
    make gcc unzip kmod python3 python3-pip python3-wheel python3-setuptools libssl-dev ruby-full git libz-dev && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list |tee /etc/apt/sources.list.d/microsoft.list && \
    apt -y update && apt install --no-install-recommends --yes -q powershell && \
    mkdir -p /root/.local/share/powershell/Modules  &&  \
    apt clean && apt autoremove --purge && rm -rf /var/lib/apt/lists*

ADD compchecker_v1_10066133.zip /tmp/
ADD VMware_vRealize_CloudClient-4.7.0-13182508.zip /tmp/
ADD VMware-ovftool-4.3.0-13981069-lin.x86_64.bundle /tmp/
ADD VMware-vix-disklib-6.7.0-8173251.x86_64.tar.gz /tmp/
RUN yes | /bin/bash /tmp/VMware-ovftool-4.3.0-13981069-lin.x86_64.bundle --required --console && rm -f /tmp/VMware-ovftool-4.3.0-13981069-lin.x86_64.bundle  && \
    mv /tmp/vmware-vix-disklib-distrib /root/src/ && rm -rf /tmp/VMware-vix-disklib-distrib && \
    unzip /tmp/VMware_vRealize_CloudClient-4.7.0-13182508.zip -d /root && rm -rf /tmp/vmware_vrealize_cloudclient-4.7.0-13182508.zip && \
    unzip /tmp/compchecker_v1_10066133.zip -d /root && rm -rf /tmp/compchecker_v1_10066133.zip && \
    mkdir /root/vghetto && git clone https://github.com/lamw/vghetto-scripts.git /root/vghetto && \
    pwsh -ex unrestricted -noni -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted && \
    pwsh -ex unrestricted -noni -Command Install-Module -Name AWSPowerShell,Az,Cisco.HXPowerCLI,Cisco.IMC,Cisco.UCS.Core,Cisco.UCSManager,Cody.PureStorage.Pure1,CredentialManager,IsilonPlatform,JiraPS,Pester,Posh-Cisco,posh-git,PoSH-SSH,PowerNSX,PSExcel,PSLogging,PSMultiLog,PSScriptAnalyzer,Unity-Powershell,VMware.PowerCLI,VPLEX-Powershell

# Install rbVmomi & RVC & RaaS CLI & vcloud-tools govc CLI  vca-cli & python modules
RUN gem install --no-rdoc --no-ri vcloud-tools rbvmomi rvc RaaS && \
    go get github.com/vmware/govmomi/govc && \
    pip3 install vca-cli pyvcloud pyVim pyvmomi crypto pyopenssl


# Install vCLI https://developercenter.vmware.com/web/dp/tool/vsphere_cli/6.5
#  VMware OVFTool http://vmware.com/go/ovftool,  VDDK,
#  Cloud Client https://my.vmware.com/group/vmware/geexit-download?downloadGroup=CLOUDCLIENT_420&productId=601
#  ESXi Compliancy Checker Flings
# Add William Lams awesome scripts from vGhetto Script Repository


# Run Bash when the image starts
CMD ["/usr/bin/pwsh"]
