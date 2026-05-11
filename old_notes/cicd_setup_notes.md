# CI/CD Setup Notes

## Table of Contents

- [Git Configuration](#git-configuration)
- [Jenkins Installation](#jenkins-installation)
- [GitLab Runner Installation](#gitlab-runner-installation)
- [GitLab Runner Registration](#gitlab-runner-registration)
- [GitLab Runner Commands](#gitlab-runner-commands)
- [GitLab CI/CD Template](#gitlab-cicd-template)
- [Docker Installation and Configuration](#docker-installation-and-configuration)
- [Dockerfile Example](#dockerfile-example)
- [GitLab Runner Configuration](#gitlab-runner-configuration)

---

## Git Configuration

### Disable SSL Verification

> **Note:** Only use this in development environments when necessary.

```bash
git config --global http.sslVerify false
```

## Jenkins Installation

> **Reference:** [DigitalOcean Jenkins Installation Guide](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04)

### Check Linux Distribution

```bash
echo $(lsb_release -cs)
```

## GitLab Runner Installation

> **Reference:** [GitLab Runner Setup Guide](https://about.gitlab.com/2016/04/19/how-to-set-up-gitlab-runner-on-digitalocean/)

### Install on Ubuntu

```bash
# Add GitLab Runner GPG key
curl -L https://packages.gitlab.com/runner/gitlab-ci-multi-runner/gpgkey | sudo apt-key add -

# Update and install dependencies
sudo apt-get update
sudo apt-get install debian-archive-keyring
sudo apt-get install -y apt-transport-https

# Add repository (replace 'xenial' with your Ubuntu version)
sudo tee /etc/apt/sources.list.d/runner_gitlab-ci-multi-runner.list <<EOF
deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ xenial main
deb-src https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ xenial main
EOF

# Install GitLab Runner
sudo apt-get update
sudo apt-get install gitlab-runner
```

## GitLab Runner Registration

```bash
sudo gitlab-ci-multi-runner register
```

When prompted, provide:

| Prompt | Value |
|--------|-------|
| URL | Your GitLab instance URL |
| Token | Registration token from GitLab (Settings > CI/CD > Runners) |
| Description | Runner description (e.g., "azure") |
| Tags | Runner tags (e.g., "azure-build") |
| Executor | docker |
| Docker Image | Default image (e.g., "hello-world") |

### Unregister a Runner

```bash
sudo gitlab-runner unregister --url <GITLAB_URL> --token <RUNNER_TOKEN>
```

## GitLab Runner Commands

```bash
# Check runner status
sudo gitlab-ci-multi-runner status

# Verify runner configuration
sudo gitlab-ci-multi-runner verify

# List all runners
sudo gitlab-ci-multi-runner list
```

## GitLab CI/CD Template

Example `.gitlab-ci.yml` file:

```yaml
image: your-registry/your-image:tag

stages:
  - build
  - test
  - deploy

build:
  stage: build
  script:
    - echo "Build successful"
  tags:
    - azure-build

test:
  stage: test
  script:
    - echo "Tests passed"
  tags:
    - azure-build

deploy:
  stage: deploy
  script:
    - echo "Deployment successful"
  tags:
    - azure-build
```

## Docker Installation and Configuration

> **Reference:** [DigitalOcean Docker Installation Guide](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

### Configure Docker Proxy

Create proxy configuration files:

**/etc/systemd/system/docker.service.d/http-proxy.conf:**

```ini
[Service]
Environment="HTTP_PROXY=http://your-proxy-url:8080/" "NO_PROXY=localhost,127.0.0.1"
```

**/etc/systemd/system/docker.service.d/https-proxy.conf:**

```ini
[Service]
Environment="HTTPS_PROXY=http://your-proxy-url:8080"
```

**/etc/docker/daemon.json:**

```json
{
  "insecure-registries": ["localhost:5000"]
}
```

### Restart Docker Service

```bash
systemctl daemon-reload
sudo service docker restart
```

### Uninstall Docker Completely

```bash
sudo apt-get purge docker-engine
sudo apt-get autoremove --purge docker-engine
rm -rf /var/lib/docker  # Deletes all images, containers, and volumes
```

## Dockerfile Example

```dockerfile
FROM centos

# Build-time variables
ARG proxy_ip
ARG no_proxy_ip

# Set proxy environment variables
ENV no_proxy=${no_proxy_ip}
ENV http_proxy=${proxy_ip}:8080
ENV https_proxy=${proxy_ip}:8080

# Install Java
RUN yum update -y && \
    yum install -y git java-1.8.0-openjdk-devel && \
    yum clean all

# Set Java environment
ENV JAVA_HOME=/etc/alternatives/jre/

# Import certificates (update paths as needed)
COPY your-cert.crt .
RUN keytool -importcert -keystore $JAVA_HOME/lib/security/cacerts \
    -storepass <YOUR_KEYSTORE_PASSWORD> \
    -file your-cert.crt \
    -alias "cert-alias" \
    -noprompt

# Install Azure CLI
RUN yum check-update; \
    yum install -y gcc libffi-devel python-devel openssl-devel && \
    curl "https://bootstrap.pypa.io/get-pip.py" | python && \
    pip install --pre azure-cli

# Install Terraform
COPY terraform /usr/local/bin/

# Configure SSH (ensure proper permissions)
RUN mkdir -p /root/.ssh
COPY id_rsa.pub /root/.ssh/
COPY id_rsa /root/.ssh/
COPY known_hosts /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
```

## GitLab Runner Configuration

Example `config.toml`:

```toml
[[runners]]
  name = "azure"
  url = "<GITLAB_URL>"
  token = "<RUNNER_TOKEN>"
  executor = "docker"
  [runners.docker]
    tls_verify = false
    image = "hello-world"
    privileged = false
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
  [runners.cache]
```

> **Security Note:** Store sensitive values like tokens and passwords in environment variables or secrets management systems, not in configuration files.
