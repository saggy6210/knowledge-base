# DevOps Interview Preparation Guide

## Table of Contents

- [Kubernetes](#kubernetes)
- [Docker](#docker)
- [Jenkins](#jenkins)
- [Git](#git)
- [Linux](#linux)
- [Cloud Platforms](#cloud-platforms)
- [CI/CD](#cicd)

---

## Kubernetes

> **Reference:** [Kubernetes Documentation](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

### What is Kubernetes?

Kubernetes is a portable, extensible, open-source platform for managing containerized workloads and services. It facilitates both declarative configuration and automation.

- **Open-sourced by Google** in 2014
- **Current version:** Check [kubernetes.io](https://kubernetes.io) for latest

### Evolution of Deployment

| Era | Description | Challenges |
|-----|-------------|------------|
| **Traditional** | Applications on physical servers | No resource boundaries, allocation issues |
| **Virtualized** | Multiple VMs on single physical server | Better isolation, but overhead |
| **Container** | Lightweight, portable containers | Requires orchestration at scale |

### Kubernetes Capabilities

| Feature | Description |
|---------|-------------|
| **Service Discovery & Load Balancing** | Expose containers via DNS or IP; automatic load distribution |
| **Storage Orchestration** | Automatically mount storage systems (local, cloud, etc.) |
| **Automated Rollouts/Rollbacks** | Declare desired state; Kubernetes manages transitions |
| **Automatic Bin Packing** | Fit containers onto nodes based on resource requirements |
| **Self-Healing** | Restart failed containers, replace unhealthy ones, kill unresponsive ones |
| **Secret & Config Management** | Store and manage sensitive information securely |

### Control Plane Components

| Component | Description |
|-----------|-------------|
| **kube-apiserver** | Front end for Kubernetes control plane; exposes the API |
| **etcd** | Consistent, highly-available key-value store for cluster data |
| **kube-scheduler** | Watches for new Pods and selects nodes for them |
| **kube-controller-manager** | Runs controller processes (Node, Replication, Endpoints, Service Account) |

### Node Components

| Component | Description |
|-----------|-------------|
| **kubelet** | Agent on each node ensuring containers run in Pods |
| **kube-proxy** | Network proxy implementing Kubernetes Service concept |
| **Container Runtime** | Software running containers (Docker, containerd, CRI-O) |

### Cluster Addons

- **DNS:** Cluster DNS server for Kubernetes services
- **Web UI (Dashboard):** Web-based UI for cluster management
- **Container Resource Monitoring:** Records container metrics
- **Cluster-level Logging:** Saves container logs to central store

---

## Docker

See [docker_networking_commands.md](docker_networking_commands.md) for detailed Docker commands and interview questions.

---

## Jenkins

See [jenkins_installation.md](jenkins_installation.md) for Jenkins setup.

---

## Git

See [git_commands.md](git_commands.md) for Git commands reference.

---

## Linux

See [linux_shell_scripting.md](linux_shell_scripting.md) for Linux scripting guide.

---

## Cloud Platforms

### AWS
- EC2, S3, RDS, Lambda, EKS, ECS

### Azure
- Virtual Machines, Blob Storage, AKS, Azure Functions

### GCP
- Compute Engine, Cloud Storage, GKE, Cloud Functions

---

## CI/CD

See [cicd_setup_notes.md](cicd_setup_notes.md) for CI/CD pipeline setup.
