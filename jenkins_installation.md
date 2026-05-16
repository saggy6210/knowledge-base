# Jenkins Installation Guide

> **Reference:** [Official Jenkins Documentation](https://jenkins.io/doc/)

## Table of Contents

- [Installation](#installation)
- [Initial Setup](#initial-setup)
- [Configuration](#configuration)
- [Useful Resources](#useful-resources)

---

## Installation

### Prerequisites

- Java JDK 8 or 11

### Quick Start (WAR File)

```bash
# Download Jenkins WAR file
wget https://get.jenkins.io/war-stable/latest/jenkins.war

# Run Jenkins
java -jar jenkins.war --httpPort=8080
```

### Access Jenkins

Open your browser and navigate to: `http://localhost:8080`

## Initial Setup

### Retrieve Initial Admin Password

The initial admin password is stored at:

```bash
cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Complete Setup Wizard

1. Enter the initial admin password
2. Install suggested plugins (or select specific plugins)
3. Create first admin user
4. Configure Jenkins URL

## Configuration

### System Configuration

- **Manage Jenkins** → **Configure System** for global settings
- **Manage Jenkins** → **Configure Global Security** for authentication

### Plugin Management

- **Manage Jenkins** → **Manage Plugins**

## Useful Resources

### Generate Epoch Milliseconds

Useful for timestamping in scripts:

```bash
echo $((`date +%s` * 1000 + `date +%-N` / 1000000))
```

### Related Documentation

- [Getting Started with Elasticsearch](https://medium.com/@ashish_fagna/getting-started-with-elasticsearch-creating-indices-inserting-values-and-retrieving-data-e3122e9b12c6)
- [Linux CPU, Disk, RAM Usage Scripts](https://unix.stackexchange.com/questions/69167/bash-script-that-print-cpu-usage-diskusage-ram-usage)
- [Collect Linux Data Using Custom JSON](https://blogs.technet.microsoft.com/mohammedabutaleb/2017/10/07/collect-linux-data-using-custom-json-data-source/)
