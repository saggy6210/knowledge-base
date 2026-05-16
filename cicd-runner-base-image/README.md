# CI/CD Runner Base Image

A Docker base image designed for CI/CD pipelines with pre-installed development tools including Java, Git, Azure CLI, Terraform, and Python.

## Overview

This image serves as a foundation for CI/CD runners (GitLab Runner, Jenkins agents, etc.) that need to execute builds, deployments, and infrastructure automation tasks.

## Pre-installed Tools

| Tool | Version | Description |
|------|---------|-------------|
| Java | OpenJDK 1.8 | Java Development Kit for building Java applications |
| Git | Latest | Version control for source code management |
| Azure CLI | Latest | Azure command-line interface for cloud deployments |
| Terraform | 0.11.8 | Infrastructure as Code tool |
| Python | 2.x | Python runtime (via pip) |

## Building the Image

### Basic Build

```bash
docker build -t cicd-runner:latest .
```

### Build with Proxy Configuration

If you're behind a corporate proxy:

```bash
docker build \
  --build-arg no_proxy_ip=<NO_PROXY_IP> \
  --build-arg proxy_ip=<HTTP_PROXY_IP> \
  -t localhost:5000/cicd-runner:1.0 .
```

**Parameters:**
- `<NO_PROXY_IP>`: IP address of your machine (bypass proxy)
- `<HTTP_PROXY_IP>`: IP address of your proxy server

## SSH Configuration

The Dockerfile expects SSH keys for Git operations. Place these files in the same directory as the Dockerfile before building:

```
id_rsa        # Private SSH key
id_rsa.pub    # Public SSH key  
known_hosts   # SSH known hosts file
```

> **Security Note:** Never commit SSH private keys to version control. Use CI/CD secrets or mounted volumes in production.

## Usage

### Pull Pre-built Image

```bash
docker pull sagar6210/base-java-git-azurecli-terraform-python
```

### Run Container

```bash
docker run -it cicd-runner:latest /bin/bash
```

### Use as GitLab Runner Base

In your `.gitlab-ci.yml`:

```yaml
image: sagar6210/base-java-git-azurecli-terraform-python

stages:
  - build
  - deploy

build:
  stage: build
  script:
    - java -version
    - terraform --version
    - az --version
```

## Environment Variables

| Variable | Value | Description |
|----------|-------|-------------|
| `JAVA_HOME` | `/etc/alternatives/jre/` | Java installation path |

## File Structure

```
cicd-runner-base-image/
├── Dockerfile      # Container build instructions
├── README.md       # This documentation
├── id_rsa          # (required) SSH private key
├── id_rsa.pub      # (required) SSH public key
└── known_hosts     # (required) SSH known hosts
```

## Updating the Image

To update tool versions, modify the Dockerfile:

1. **Terraform**: Update the download URL with new version
2. **Java**: Change the yum package version
3. **Azure CLI**: Always pulls latest via pip

## Related Documentation

- [Docker Basics](../docker_basics.md)
- [CI/CD Setup Notes](../cicd_setup_notes.md)
- [Docker Registry Push](../docker_registry_push.md)

