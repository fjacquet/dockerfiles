# This is VMware Command line tools and contrib
# docker build . -t powershell --rm
# docker run -ti powershell

# Stage 1: Install PowerShell and modules
FROM docker.io/library/almalinux:10 AS builder
ARG PS_VERSION=7.5.4
RUN dnf -y update && \
    dnf install -y curl tar gzip unzip libicu && \
    dnf clean all && \
    rm -rf /var/cache/dnf
# Install PowerShell from tar.gz (supports both amd64 and arm64)
RUN PS_ARCH=$([ "$(uname -m)" = "aarch64" ] && echo "arm64" || echo "x64") && \
    curl -L -o /tmp/powershell.tar.gz \
      "https://github.com/PowerShell/PowerShell/releases/download/v${PS_VERSION}/powershell-${PS_VERSION}-linux-${PS_ARCH}.tar.gz" && \
    mkdir -p /opt/microsoft/powershell/7 && \
    tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 && \
    chmod +x /opt/microsoft/powershell/7/pwsh && \
    ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh && \
    rm -f /tmp/powershell.tar.gz
# Install PowerShell modules from PSGallery
RUN pwsh -ex unrestricted -noni -Command " \
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module -Name AWSPowerShell; \
    Install-Module -Name CredentialManager; \
    Install-Module -Name IsilonPlatform; \
    Install-Module -Name JiraPS; \
    Install-Module -Name Pester; \
    Install-Module -Name PoSH-SSH; \
    Install-Module -Name posh-git; \
    Install-Module -Name PowerNSX; \
    Install-Module -Name PSExcel; \
    Install-Module -Name PSLogging; \
    Install-Module -Name PSScriptAnalyzer; \
    Install-Module -Name VMware.PowerCLI; \
    Install-Module -Name Unity-Powershell; \
    Install-Module -Name VPLEX-Powershell"
# Install UCS PowerTool Core
COPY ucspowertoolcore_v2.5.3.0.zip /tmp/ucspowertoolcore.zip
RUN mkdir -p /root/.local/share/powershell/Modules && \
    unzip /tmp/ucspowertoolcore.zip -d /root/.local/share/powershell/Modules && \
    rm -f /tmp/ucspowertoolcore.zip

# Stage 2: Minimal runtime
FROM docker.io/library/almalinux:10
LABEL maintainer="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.title="powershell" \
      org.opencontainers.image.description="PowerShell with VMware, Dell EMC, and AWS modules" \
      org.opencontainers.image.authors="Frederic Jacquet <fred@ljf.ch>" \
      org.opencontainers.image.source="https://github.com/fjacquet/dockerfiles"
# Register the Microsoft RHEL 10 repository for dotnet-sdk
RUN dnf -y update && \
    dnf install -y curl && \
    curl -sSL -O https://packages.microsoft.com/config/rhel/10/packages-microsoft-prod.rpm && \
    rpm -i packages-microsoft-prod.rpm && \
    rm -f packages-microsoft-prod.rpm && \
    dnf -y update && \
    dnf install -y libicu wget make git dotnet-sdk-8.0 && \
    curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe && \
    dnf clean all && \
    rm -rf /var/cache/dnf
# Copy PowerShell and modules from builder
COPY --from=builder /opt/microsoft/powershell /opt/microsoft/powershell
RUN ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
COPY --from=builder /root/.local/share/powershell /root/.local/share/powershell
RUN mkdir -p /root/.config/powershell
COPY Microsoft.PowerShell_profile.ps1 /root/.config/powershell/Microsoft.PowerShell_profile.ps1
WORKDIR /tmp
VOLUME /home
ENTRYPOINT [ "pwsh" ]
