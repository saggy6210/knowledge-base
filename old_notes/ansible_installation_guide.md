# Ansible Installation Guide

> **Reference:** [Official Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation on Ubuntu](#installation-on-ubuntu)
- [Post-Installation Setup](#post-installation-setup)
- [Additional Resources](#additional-resources)

---

## Prerequisites

- Ubuntu server with sudo privileges
- Internet connectivity

## Installation on Ubuntu

Run the following commands to install Ansible:

```bash
# Update package index
sudo apt-get update

# Install required dependencies
sudo apt-get install software-properties-common

# Add Ansible PPA repository
sudo apt-add-repository ppa:ansible/ansible

# Update package index again
sudo apt-get update

# Install Ansible
sudo apt-get install ansible
```

## Post-Installation Setup

### Configure SSH Public Key

1. Generate SSH key pair (if not already created):

   ```bash
   ssh-keygen -t rsa
   ```

2. Copy the public key to destination servers:

   ```bash
   ssh-copy-id user@destination-server
   ```

### Configure Inventory

Add the IP addresses or hostnames of destination VMs to the Ansible hosts file:

```bash
sudo nano /etc/ansible/hosts
```

Example inventory:

```ini
[webservers]
192.168.1.10
192.168.1.11

[databases]
db.example.com
```

## Additional Resources

- [Ansible Ad-Hoc Commands Guide](https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html)
- [Ansible Playbooks Documentation](https://docs.ansible.com/ansible/latest/playbook_guide/index.html)
