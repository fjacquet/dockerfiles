# This is VMware Command line tools and contrib
# docker build . -t vmutils --compress --rm --squash
# docker run -ti vmutils
FROM  ubuntu:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# Set the working directory to /root
WORKDIR /root
VOLUME "/root/src"
ENV http_proxy ""
ENV ftp_proxy ""
ENV TZ=Europe/Zurich
RUN apt -y update && apt -y upgrade
RUN apt -y install curl gnupg2
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list |tee /etc/apt/sources.list.d/microsoft.list
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt -y update && apt install --yes inetutils-ping make gcc unzip kmod python3 python3-pip python3-wheel python3-setuptools\
    libssl-dev ruby-full git libz-dev libpq-dev python3-dev build-essential libffi-dev libssl-dev libxml2-dev libxslt-dev python-dev
RUN apt install --yes powershell golang
RUN mkdir -p /root/.local/share/powershell/Modules /root/.config/powershell /root/vghetto

ADD compchecker-v1-20210219.zip /tmp/compchecker.zip
ADD VMware_vRealize_CloudClient-4.7.0-13182508.zip /tmp/VMware_vRealize_CloudClient.zip
ADD VMware-ovftool-4.3.0-13981069-lin.x86_64.bundle /tmp/
ADD VMware-vix-disklib-6.7.0-8173251.x86_64.tar.gz /tmp/
ADD ucspowertoolcore_v2.5.3.0.zip /tmp/ucspowertoolcore.zip
ADD Microsoft.PowerShell_profile.ps1 /root/.config/powershell/Microsoft.PowerShell_profile.ps1

# RUN yes | /bin/bash /tmp/VMware-ovftool-4.3.0-13981069-lin.x86_64.bundle --required --console && rm -f /tmp/VMware-ovftool-4.3.0-13981069-lin.x86_64.bundle
RUN mv /tmp/vmware-vix-disklib-distrib /root/src/ && rm -rf /tmp/VMware-vix-disklib-distrib
RUN unzip /tmp/VMware_vRealize_CloudClient.zip -d /root && rm -rf /tmp/VMware_vRealize_CloudClient.zip
RUN unzip /tmp/compchecker.zip -d /root && rm -rf /tmp/compchecker.zip
RUN git clone https://github.com/lamw/vghetto-scripts.git /root/vghetto
RUN unzip /tmp/ucspowertoolcore.zip -d /root/.local/share/powershell/Modules  && rm -rf /tmp/ucspowertoolcore.zip

RUN pwsh -ex unrestricted -noni -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted && \
    pwsh -ex unrestricted -noni -Command Install-Module -Name AWSPowerShell,Az,Cisco.HXPowerCLI,Cisco.IMC,Cisco.UCS.Core,Cisco.UCSManager,Cody.PureStorage.Pure1,CredentialManager,IsilonPlatform,JiraPS,Pester,Posh-Cisco,posh-git,PoSH-SSH,PowerNSX,PSExcel,PSLogging,PSMultiLog,PSScriptAnalyzer,Unity-Powershell,VMware.PowerCLI,VPLEX-Powershell



# Install rbVmomi & RVC & RaaS CLI & vcloud-tools govc CLI  vca-cli & python modules
RUN pip3 install --upgrade pip setuptools wheel && \
    pip3 install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    pip3 install pyVim pyvmomi crypto pyopenssl pyvcloud ansible molecule
RUN gem install  --no-document  vcloud-tools rbvmomi rvc RaaS && go get github.com/vmware/govmomi/govc
RUN apt clean && apt autoremove --purge && rm -rf /var/lib/apt/lists*

# Install vCLI https://developercenter.vmware.com/web/dp/tool/vsphere_cli/6.5
#  VMware OVFTool http://vmware.com/go/ovftool,  VDDK,
#  Cloud Client https://my.vmware.com/group/vmware/geexit-download?downloadGroup=CLOUDCLIENT_420&productId=601
#  ESXi Compliancy Checker Flings
# Add William Lams awesome scripts from vGhetto Script Repository

# Run Bash when the image starts
CMD ["/usr/bin/pwsh"]
