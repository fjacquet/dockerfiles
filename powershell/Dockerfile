
# This is VMware Command line tools and contrib
# docker build . -t powershell --compress --rm --squash
# docker run -ti powershell
FROM centos:latest
LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"
# Register the Microsoft RedHat repository
RUN dnf -y update
WORKDIR /etc/yum.repos.d
RUN curl -L -O https://packages.microsoft.com/config/rhel/8/prod.repo
# Project Mono
RUN curl https://download.mono-project.com/repo/centos8-stable.repo | tee mono-centos8-stable.repo
RUN rpm --import "https://download.mono-project.com/repo/xamarin.gpg"
RUN curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
WORKDIR /tmp
# Get Centos
# RUN dnf install -y --setopt=tsflags=nodocs deltarpm powershell mono-complete nuget mono-devel unzip wget make git yum-utils dotnet-sdk-2.1.300-rc1-008673.x86_64 && \
#     dnf -y --setopt=tsflags=nodocs update && \
    # dnf clean all
RUN dnf install -y drpm powershell unzip wget make git yum-utils  mono-devel dotnet-sdk-5.0 && \
    dnf clean all
# Project UCS
# RUN curl https://communities.cisco.com/servlet/JiveServlet/download/74217-3-149644/ucspowertoolcore.zip -o /tmp/ucspowertoolcore.zip
# RUN mkdir -p /root/.local/share/powershell/Modules && \
#     unzip /tmp/ucspowertoolcore.zdocker run -ti powershellip  -d /root/.local/share/powershell/Modules  && \
#     rm -rf /tmp/ucspowertoolcore.zip
# # Install from psgallery
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
# RUN echo "alias start-ucs=pwsh –NoExit –File ~/.local/share/powershell/Modules/Start-UcsPowerTool.ps1" >> ./.bashrc
# # Build Nutanix  soon
# #RUN git clone https://github.com/nutanix/Powershell && cd Powershell && make deps && make
# RUN echo "export LD_LIBRARY_PATH=/opt/shibboleth/lib64/:$LD_LIBRARY_PATH" >> ~/.bashrc
# Start PowerShell
VOLUME /home
ENTRYPOINT [ "pwsh" ]
# CMD [ "/bin/bash" ]