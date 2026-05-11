# Linux Shell Scripting Guide

A collection of commonly used Linux commands and shell scripting techniques.

## Table of Contents

- [Network Commands](#network-commands)
- [Text Processing](#text-processing)
- [User and Process Management](#user-and-process-management)
- [Date and Time](#date-and-time)
- [File Operations](#file-operations)
- [System Monitoring](#system-monitoring)
- [SSH Configuration](#ssh-configuration)

---

## Network Commands

### Check Routing Table

```bash
netstat -rn
```

### List Listening Ports

```bash
netstat -listen
# or
lsof -i
```

---

## Text Processing

### Print Specific Line and Convert to Uppercase

```bash
awk 'NR==<line-number>{print toupper($0)}' <filename>
```

### Replace Text in Files

Using `sed`:

```bash
sed -i "s/source_pattern/target_pattern/g" <filename>
```

Using `perl`:

```bash
perl -pi -e 's/source_pattern/target_pattern/g' <filename>
```

---

## User and Process Management

### Display Logged-in Users

```bash
w
```

### Check if a Process is Running

Returns `1` if the process is running, `0` otherwise:

```bash
status=$(ps -fu <username> | grep "<process_name>" | grep -v grep | wc -l)
```

---

## Date and Time

### Print Date in Custom Format

```bash
# Format: YYMMDDHHMMSS
date +%y%m%d%H%M%S

# Store in variable
DAT=$(date +%y%m%d%H%M%S)
```

---

## File Operations

### Delete Files Older Than N Days

Delete log files older than a specific number of days:

```bash
find . -type f -name "*.log*" -mtime +<days> -exec rm -rf {} \;
```

**Example:** Delete log files older than 20 days:

```bash
find . -type f -name "*.log*" -mtime +20 -exec rm -rf {} \;
```

---

## System Monitoring

### Check Server Uptime

```bash
uptime
```

Parse uptime information in scripts:

```bash
status=$(uptime)
current_time=$(echo $status | awk '{print $1}')
up_status=$(echo $status | awk '{print $2}')
up_since=$(echo $status | awk '{print $3}')
```

### Check RAM Usage

```bash
free -g -t
```

Parse memory information in scripts:

```bash
ram_size=$(free -g -t | grep buffer | tail -1)
used_size=$(echo $ram_size | awk '{print $3}')
free_size=$(echo $ram_size | awk '{print $4}')
```

---

## SSH Configuration

### Set Up Passwordless SSH Authentication

1. Create the `.ssh` directory:

   ```bash
   mkdir -p ~/.ssh
   ```

2. Generate an RSA key pair:

   ```bash
   ssh-keygen -t rsa
   ```

3. Copy the public key to the remote server:

   ```bash
   ssh-copy-id <user>@<remote_host>
   ```

4. Test the connection:

   ```bash
   ssh <remote_host>
   ```

### Copy Files Between Servers

Copy a single file:

```bash
scp <file> <target_host>:<directory_path>
```

Copy a directory recursively:

```bash
scp -r <directory>/ <target_host>:<directory_path>
```
