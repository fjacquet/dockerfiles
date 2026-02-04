# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A collection of standalone Docker images for enterprise infrastructure and systems administration tools. Each top-level directory is an independent service with its own Dockerfile. There is no docker-compose or shared orchestration — each image is built and run independently.

## Build Commands

Each Dockerfile contains its build/run commands in a comment at the top. The general pattern:

```bash
# Build a single image
docker build . -t <service-name> --compress --rm --squash -f <service>/Dockerfile <service>/

# Example
docker build . -t ntp --compress --rm --squash -f ntp/Dockerfile ntp/
```

The CI test script (`test.sh`) automatically detects changed Dockerfiles via `git diff` and builds only those. It derives image name and tag from the directory structure.

## CI/CD

- **GitHub Actions** (`.github/workflows/build.yml`): Runs SonarCloud scan on push to master and PRs. Requires `SONAR_TOKEN` secret.
- **Snyk**: Vulnerability scanning via automated PRs from `snyk-fix-*` branches.
- **Legacy**: `.travis.yml` exists but is superseded by GitHub Actions.

## Architecture and Conventions

### Directory layout per service

```
<service>/
├── Dockerfile
├── README.md                  # Service-specific docs, env vars, usage
├── scripts/                   # Entrypoint and startup scripts
│   ├── docker-entrypoint.sh
│   └── run-*.sh / start.sh
└── container-image-root/      # Files copied into the image
```

### Base images

- **AlmaLinux (`almalinux:latest`)**: Primary base for most services (ntp, percona, mariadb, powershell, uemcli, wordpress, vnxcli)
- **Alpine**: Lightweight services (postfix, consul)
- **Photon**: VMware-optimized services (httpd, snmp, esxicompcheck)
- **Ubuntu**: Feature-rich services (vmutils, capanalysis)

### Dockerfile conventions

- All Dockerfiles start with a build command comment
- Use `LABEL MAINTAINER="Frederic Jacquet <fred@ljf.ch>"`
- Entrypoint patterns vary: service scripts, direct binary launch, or interactive bash shell
- Large vendor binaries (RPMs, zips, bundles) are committed directly in service directories

### Services

| Service | Purpose |
|---------|---------|
| capanalysis | Network packet capture analysis |
| consul | HashiCorp Consul service mesh |
| esxicompcheck | VMware ESXi compliance checker |
| httpd | Apache web server |
| mariadb | MariaDB database |
| ntp | NTP/Chrony time server |
| percona | Percona MySQL server |
| postfix | Mail transfer agent |
| powershell | PowerShell runtime with modules |
| snmp | SNMP utilities |
| uemcli | Dell EMC Unity CLI tools |
| vmutils | VMware utilities |
| vnxcli | Dell EMC VNX CLI tools |
| wordpress | WordPress CMS |
