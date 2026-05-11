# Kubernetes Installation on CentOS 7

This guide covers installing Kubernetes on CentOS 7 servers.

## Prerequisites

- Minimum 3 servers (1 master, 2 workers)
- Each server: 2+ CPUs, 2GB+ RAM
- Network connectivity between all nodes
- Root/sudo access

> **Note:** Commands 1-10 must be run on **all nodes** (master and workers).

---

## All Nodes Configuration

### 1. Elevate Privileges

```bash
sudo su
```

### 2. Disable SELinux

```bash
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
```

### 3. Enable br_netfilter Module

```bash
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
```

### 4. Disable Swap

```bash
swapoff -a

# Comment out swap line in /etc/fstab
vim /etc/fstab
# Add # before the swap line
```

### 5. Install Docker Prerequisites

```bash
yum install -y yum-utils device-mapper-persistent-data lvm2
```

### 6. Install Docker

```bash
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
```

### 7. Configure Docker Cgroup Driver

```bash
sed -i '/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/' /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl enable docker --now
```

### 8. Verify Docker Configuration

```bash
systemctl status docker
docker info | grep -i cgroup
```

### 9. Add Kubernetes Repository

```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
```

### 10. Install Kubernetes Components

```bash
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet
```

---

## Master Node Configuration

Run the following commands **only on the master node**.

### Initialize Kubernetes Cluster

```bash
kubeadm init --pod-network-cidr=10.244.0.0/16
```

### Configure kubectl for Current User

```bash
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

### Install Pod Network (Flannel)

```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

### Get Join Command for Worker Nodes

```bash
kubeadm token create --print-join-command
```

---

## Worker Node Configuration

Run the following command **on each worker node** using the token from the master:

```bash
kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>
```

---

## Verification

### Check Node Status (on Master)

```bash
kubectl get nodes
```

### Check System Pods

```bash
kubectl get pods --all-namespaces
```
