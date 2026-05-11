# Docker Registry: Build and Push Images

## Overview

This guide explains how to build and push Docker images to a private registry.

## Build and Push Workflow

### Step 1: Build the Application

```bash
gradlew clean build eclipse -PbuildEnv=az_tag
```

### Step 2: Build Docker Image

```bash
docker build -t <registry-url>/<image-name>:<version> .
```

### Step 3: Log in to Docker Registry

```bash
docker login <registry-url> -u <username> -p <password>
```

> **Security Warning:** Avoid passing passwords directly in the command line. Use one of these secure alternatives:
>
> ```bash
> # Option 1: Interactive login
> docker login <registry-url> -u <username>
>
> # Option 2: Use environment variable
> echo $DOCKER_PASSWORD | docker login <registry-url> -u <username> --password-stdin
>
> # Option 3: Use Docker credential helpers
> ```

### Step 4: Push Image to Registry

```bash
docker push <registry-url>/<image-name>:<version>
```

## Complete Example Script

```bash
#!/bin/bash
set -e

REGISTRY_URL="your-registry.example.com"
IMAGE_NAME="your-app"
VERSION="1.0.0"

# Build application
./gradlew clean build -PbuildEnv=az_tag

# Build Docker image
docker build -t ${REGISTRY_URL}/${IMAGE_NAME}:${VERSION} .

# Login and push (using stdin for password)
echo "${DOCKER_PASSWORD}" | docker login ${REGISTRY_URL} -u "${DOCKER_USERNAME}" --password-stdin
docker push ${REGISTRY_URL}/${IMAGE_NAME}:${VERSION}
```

> **Best Practice:** Store credentials in CI/CD secrets or a credential management system, never in plain text files or version control.
