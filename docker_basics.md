# Docker Basics

A comprehensive guide to Docker fundamentals, concepts, and commonly used commands.

## Table of Contents

- [Core Concepts](#core-concepts)
- [Installation](#installation)
- [Proxy Configuration](#proxy-configuration)
- [Basic Commands](#basic-commands)
- [Image Management](#image-management)
- [Container Management](#container-management)
- [Building Images](#building-images)
- [Docker Hub Operations](#docker-hub-operations)

---

## Core Concepts

| Concept | Description |
|---------|-------------|
| **Image** | A lightweight, stand-alone, executable package that includes everything needed to run software: code, runtime, libraries, environment variables, and config files |
| **Container** | A runtime instance of an image |
| **Docker Compose** | A YAML file that defines how Docker containers should behave in production |
| **Docker Swarm** | Multi-container, multi-machine applications made possible by joining multiple machines into a "Dockerized" cluster |

## Installation

> **Reference:** [DigitalOcean Docker Installation Guide](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

### Pre-built Image with DevOps Tools

Pull an image with Java, Git, Azure CLI, Terraform, and Python pre-installed:

```bash
docker pull sagar6210/base-java-git-azurecli-terraform-python
```

## Proxy Configuration

If you're behind a corporate proxy, configure Docker to use it.

### HTTP Proxy Configuration

Create `/etc/systemd/system/docker.service.d/http-proxy.conf`:

```ini
[Service]
Environment="HTTP_PROXY=http://proxy-ip:port/" "NO_PROXY=<HOST_IP>"
```

### HTTPS Proxy Configuration

Create `/etc/systemd/system/docker.service.d/https-proxy.conf`:

```ini
[Service]
Environment="HTTPS_PROXY=http://proxy-ip:port/"
```

### Apply Configuration

```bash
systemctl daemon-reload
sudo service docker restart
```

---

## Basic Commands

### System Information

| Command | Description |
|---------|-------------|
| `docker version` | Get Docker version |
| `docker info` | Get Docker information (images, containers, CPU, memory, etc.) |
| `docker system df` | Show Docker disk usage |

### Cleanup Commands

| Command | Description |
|---------|-------------|
| `docker system prune` | Remove unused containers, images, and networks |
| `docker system prune -a --volumes` | Remove all unused data including volumes |

---

## Image Management

### Listing Images

```bash
docker images
```

### Deleting Images

```bash
# Delete all images
docker rmi $(docker images -q)
```

### Building Images

```bash
docker build -t imagename:tag .
```

### Tagging Images

```bash
docker tag imagename username/repository:tag
```

---

## Container Management

### Listing Containers

| Command | Description |
|---------|-------------|
| `docker ps -a` | List all running and stopped containers |
| `docker ps -a -f status=running` | List only running containers |
| `docker ps -aq` | List container IDs only |

### Running Containers

```bash
# Run container
docker run -t imagename:tag

# Run container in detached mode with port mapping
docker run -d -p 4000:80 imagename:tag
```

### Stopping and Removing Containers

```bash
# Stop container
docker container stop container_id

# Delete all containers
docker rm $(docker ps -a -q)
```

---

## Building Images

### Basic Build

```bash
docker build -t imagename:tag .
```

### Build with Proxy Arguments

When working behind a proxy, pass build arguments:

```bash
docker build \
  --build-arg no_proxy_ip=<NO_PROXY> \
  --build-arg proxy_ip=<HTTP_PROXY_IP> \
  -t localhost:5000/azure-java:1.5 .
```

**Parameters:**
- `<NO_PROXY>` - IP address of your machine
- `<HTTP_PROXY_IP>` - IP address of your proxy server

---

## Docker Hub Operations

### Login and Push

```bash
# Login to Docker Hub
docker login

# Tag the image
docker tag image username/repository:tag

# Push to Docker Hub
docker push username/repository:tag
```

### Pull from Registry

```bash
docker pull username/dockerimage:tag
```

---

## Related Documentation

- [Docker Networking Commands](docker_networking_commands.md)
- [Docker Registry Push](docker_registry_push.md)
- [CI/CD Runner Base Image](cicd-runner-base-image/)
