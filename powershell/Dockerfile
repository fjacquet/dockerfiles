FROM centos:latest
MAINTAINER Frederic Jacquet <fred@ljf.ch>
# Register the Microsoft RedHat repository
RUN cd  /etc/yum.repos.d/ && curl -L -O https://packages.microsoft.com/config/rhel/7/prod.repo 
RUN yum install -y deltarpm powershell  && yum -y update && yum clean all 
RUN  pwsh -ex unrestricted -noni -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted 
RUN  pwsh -ex unrestricted -noni -Command Install-Module -name PSExcel 
RUN  pwsh -ex unrestricted -noni -Command Install-Module -name VMware.PowerCLI
# Start PowerShell
ENTRYPOINT [ "pwsh" ]
#CMD [ "/bin/bash" ]