
# This is VMware Command line tools and contrib
# docker build . -t powershell --compress --rm --squash
# docker run -ti powershell
FROM centos:7.5.1804
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# Register the Microsoft RedHat repository
WORKDIR /etc/yum.repos.d
RUN curl -L -O https://packages.microsoft.com/config/rhel/7/prod.repo 
# Project Mono
RUN curl https://download.mono-project.com/repo/centos7-stable.repo | tee mono-centos7-stable.repo
RUN rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
WORKDIR /tmp
# Get Centos
RUN yum install -y --setopt=tsflags=nodocs deltarpm powershell mono-complete nuget mono-devel unzip wget make git yum-utils dotnet-sdk-2.1.300-rc1-008673.x86_64 && \
    yum -y --setopt=tsflags=nodocs update && \
    yum clean all 
# Project UCS
RUN curl https://communities.cisco.com/servlet/JiveServlet/download/74217-3-149644/ucspowertoolcore.zip -o /tmp/ucspowertoolcore.zip 
RUN mkdir -p /root/.local/share/powershell/Modules && \
    unzip /tmp/ucspowertoolcore.zip  -d /root/.local/share/powershell/Modules  && \
    rm -rf /tmp/ucspowertoolcore.zip 
# Install from psgallery 
RUN pwsh -ex unrestricted -noni -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name AWSPowerShell 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name CredentialManager
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name IsilonPlatform 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name JiraPS
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name Pester
RUN pwsh -ex unrestricted -noni -Command Install-Module -name PoSH-SSH 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name posh-git
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name PowerNSX 
RUN pwsh -ex unrestricted -noni -Command Install-Module -name PSExcel 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name PSLogging
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name PSScriptAnalyzer
RUN pwsh -ex unrestricted -noni -Command Install-Module -name VMware.PowerCLI 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name Unity-Powershell 
RUN pwsh -ex unrestricted -noni -Command Install-Module -Name VPLEX-Powershell 
RUN echo "alias start-ucs=pwsh –NoExit –File ~/.local/share/powershell/Modules/Start-UcsPowerTool.ps1" >> ./.bashrc 
# Build Nutanix  soon
#RUN git clone https://github.com/nutanix/Powershell && cd Powershell && make deps && make
RUN echo "export LD_LIBRARY_PATH=/opt/shibboleth/lib64/:$LD_LIBRARY_PATH" >> ~/.bashrc
# Start PowerShell
VOLUME /home
ENTRYPOINT [ "pwsh" ]
#CMD [ "/bin/bash" ]