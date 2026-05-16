# Docker Networking Commands and Interview Questions

> **Reference:** [Docker Interview Questions](https://codingcompiler.com/docker-interview-questions-answers/)

## Table of Contents

- [Container Operations](#container-operations)
- [Docker Network Management](#docker-network-management)
- [Docker Compose Template](#docker-compose-template)
- [Docker Interview Questions](#docker-interview-questions)

---

## Container Operations

### Create and Run Containers

```bash
# Run Nginx container in detached mode
docker container run -p 80:80 -d --name webhost nginx

# Run MySQL container with random root password
docker container run -d -p 3306:3306 --name db -e MYSQL_RANDOM_ROOT_PASSWORD=y mysql

# Run Apache HTTP Server
docker run -d -p 8080:80 --name webhost1 httpd
```

### Container Information

```bash
# View container logs
docker container logs <container-name>

# Get container process ID
docker container top <container-name>

# List running containers
docker container ls

# Get container IP address
docker container inspect --format '{{.NetworkSettings.IPAddress}}' <container-name>

# Get container configuration details
docker container inspect <container-name>

# Check port mapping
docker container port <container-name>
```

### Interactive Container Access

```bash
# Execute command in running container
docker container exec -it <container-name> bash
```

## Docker Network Management

### Network Commands

```bash
# Create a new network
docker network create my_net

# Run container in a specific network
docker container run -d --name new_webhost --network my_net nginx

# Connect container to network
docker network connect my_net <container-name>

# Disconnect container from network
docker network disconnect my_net <container-name>
```

### Container Communication

To ping between containers, you may need to install ping utility:

```bash
# Access container shell
docker container exec -it <container-name> bash

# Inside container, install ping
apt-get update
apt-get install iputils-ping

# Ping another container by name (within same network)
docker container exec -it container1 ping container2
```

## Docker Compose Template

```yaml
version: '3.8'

services:
  service-name:
    image: image-name:tag
    command: optional-command
    environment:
      - VAR_NAME=value
    ports:
      - "host-port:container-port"

  service-name2:
    image: another-image:tag

volumes:
  volume-name:

networks:
  network-name:
```

---

## Docker Interview Questions

### 1. What is Docker?

Docker is an open-source lightweight containerization technology that enables developers to package applications with all dependencies into standardized units called containers.

### 2. What is Docker Swarm?

Docker Swarm is Docker's native clustering and orchestration tool that groups multiple Docker hosts into a single virtual Docker host, enabling container management at scale.

### 3. What is Docker Hub?

Docker Hub is a cloud-based registry service that allows you to link code repositories, build images, and store/distribute Docker images.

### 4. What is a Hypervisor?

A hypervisor creates and manages virtual environments where guest virtual machines operate. It controls guest systems and allocates resources as necessary.

### 5. What is CNM?

CNM (Container Networking Model) is Docker's networking architecture specification that provides:
- Sandboxes for network isolation
- Endpoints for container connectivity
- Networks for endpoint communication

### 6. What is the Default Docker Network Driver?

The default network driver is `bridge`. To use a different driver:

```bash
docker network create --driver <driver-name> <network-name>
```

### 7. Which Network Driver for Docker Swarm?

Use the `overlay` network driver with Docker Swarm. It enables Swarm services to communicate across multiple Docker host daemons.

### 8. CMD vs ENTRYPOINT

| Aspect | CMD | ENTRYPOINT |
|--------|-----|------------|
| Purpose | Sets default command/parameters | Configures container as executable |
| Overridable | Can be overwritten at runtime | Requires `--entrypoint` flag to override |
| Use Case | Default behavior that may change | Fixed executable with variable arguments |

### 9. ADD vs COPY

| Aspect | COPY | ADD |
|--------|------|-----|
| Source | Local files/directories only | Local files/directories + URLs |
| TAR Handling | No extraction | Automatically extracts tar files |
| Best Practice | Preferred for simple copies | Use only when auto-extract is needed |

### 10. What is Docker Compose?

Docker Compose is a tool for defining and running multi-container Docker applications using YAML configuration files.

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down
```

### 11. Docker Save and Load

```bash
# Save image to tar archive
docker save <image-name> > image.tar

# Load image from tar archive
docker load < image.tar
```

### 12. Container States

| State | Description |
|-------|-------------|
| `created` | Container created but not started |
| `restarting` | Container is being restarted |
| `running` | Container is actively running |
| `paused` | Container processes are paused |
| `exited` | Container ran and completed |
| `dead` | Container failed to stop properly |

### 13. RUN vs CMD

| Aspect | RUN | CMD |
|--------|-----|-----|
| Execution | At build time | At container start |
| Result | Creates new image layer | Sets default startup command |
| Frequency | Multiple allowed | Only last one takes effect |

### 14. Dockerfile vs Docker Image

- **Dockerfile:** A text file containing instructions to build an image
- **Docker Image:** The built result from a Dockerfile, used to create containers
- **Docker Container:** A running instance of a Docker image
