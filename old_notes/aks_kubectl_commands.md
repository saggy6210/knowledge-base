# Azure Kubernetes Service (AKS) and kubectl Commands

> **Reference:** [Kubernetes Documentation](https://kubernetes.io/docs/concepts/)

## Table of Contents

- [Azure CLI Login](#azure-cli-login)
- [Azure Container Registry (ACR)](#azure-container-registry-acr)
- [Docker Build and Push](#docker-build-and-push)
- [kubectl Installation and Setup](#kubectl-installation-and-setup)
- [Kubernetes Dashboard](#kubernetes-dashboard)
- [Working with Namespaces](#working-with-namespaces)
- [Kubernetes Objects](#kubernetes-objects)

---

## Azure CLI Login

Log in to your Azure account and set the active subscription:

```bash
az login
az account set --subscription "SUBSCRIPTION_NAME"
```

## Azure Container Registry (ACR)

### Log in to ACR

```bash
az acr login --name <acrName>
```

### List ACR Login Servers

```bash
az acr list --resource-group <myResourceGroup> --query "[].{acrLoginServer:loginServer}" --output table
```

## Docker Build and Push

Build and push Docker images to your container registry:

```bash
docker build -t <loginServerName>/<appName>:<tag> .
docker push <loginServerName>/<appName>:<tag>
```

## kubectl Installation and Setup

### Install kubectl

```bash
az aks install-cli
```

### Get Cluster Credentials

```bash
az aks get-credentials --resource-group <myResourceGroup> --name <myAKSCluster>
```

### Verify Connection

```bash
kubectl get nodes
```

## Kubernetes Dashboard

Launch the Kubernetes dashboard for your AKS cluster:

```bash
az aks browse --resource-group <ResourceGroup> --name <AKS-NAME>
```

## Working with Namespaces

### List All Namespaces

```bash
kubectl get namespaces
```

### Default Namespaces

Kubernetes starts with three initial namespaces:

| Namespace | Description |
|-----------|-------------|
| `default` | Default namespace for objects with no other namespace |
| `kube-system` | Namespace for objects created by the Kubernetes system |
| `kube-public` | Automatically created and readable by all users (including unauthenticated). Reserved for cluster-wide visible resources |

### List Pods in a Specific Namespace

```bash
kubectl --namespace=<namespace-name> get pods
```

### Namespace and DNS

When you create a Service, Kubernetes creates a corresponding DNS entry:

```
<service-name>.<namespace-name>.svc.cluster.local
```

If a container uses only `<service-name>`, it resolves to the service local to that namespace.

## Kubernetes Objects

Kubernetes Objects are persistent entities that represent the state of your cluster. They describe:

- Containerized applications running (and on which nodes)
- Resources available to those applications
- Policies around application behavior (restart policies, upgrades, fault-tolerance)

### Required YAML Fields

When creating a Kubernetes object, you must set values for:

| Field | Description |
|-------|-------------|
| `apiVersion` | Kubernetes API version used to create the object |
| `kind` | Type of object to create |
| `metadata` | Data that uniquely identifies the object (name, UID, optional namespace) |
| `spec` | Describes the desired state of the object |
