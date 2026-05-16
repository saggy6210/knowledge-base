# Nginx Reverse Proxy Configuration Guide

This guide covers setting up Nginx as a reverse proxy for web applications.

## Table of Contents

- [Basic Configuration](#basic-configuration)
- [Frontend with API Backend](#frontend-with-api-backend)
- [Simple Reverse Proxy](#simple-reverse-proxy)
- [Multi-Service Reverse Proxy](#multi-service-reverse-proxy)

---

## Basic Configuration

Add the following configuration to `/etc/nginx/nginx.conf`:

## Frontend with API Backend

This configuration serves a static frontend while proxying API requests to a backend server.

```nginx
events {
    worker_connections 4096;
}

http {
    upstream backend-server {
        server backend.example.local:8080;
        ip_hash;
    }

    server {
        listen 80;
        listen [::]:80;
        server_name app.example.local;

        # Frontend static files
        location / {
            proxy_redirect      off;
            proxy_set_header    X-Real-IP $remote_addr;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    X-Forwarded-Proto $scheme;
            proxy_set_header    Host $host;
            root                /var/www/my-application;
            index               index.html index.htm;
            try_files           $uri $uri/ /index.html;
        }

        # API proxy
        location /api {
            proxy_pass          http://backend-server;
            proxy_http_version  1.1;
            proxy_set_header    Upgrade $http_upgrade;
            proxy_set_header    Connection 'upgrade';
            proxy_set_header    Host $host;
            proxy_cache_bypass  $http_upgrade;
            proxy_set_header    X-Real-IP $remote_addr;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_buffering     off;
            proxy_buffer_size   128k;
            proxy_buffers       100 128k;
        }
    }
}

include /etc/nginx/sites-enabled/*;
```

---

## Simple Reverse Proxy

### Create Site Configuration

Create `/etc/nginx/sites-available/proxy`:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://<TARGET_HOST>:<PORT>;
    }
}
```

### Enable the Site

```bash
ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy
```

### Manage Nginx Service

```bash
# Check status
systemctl status nginx

# Start service
systemctl start nginx

# Stop service
systemctl stop nginx

# Reload configuration
systemctl reload nginx
```

---

## Multi-Service Reverse Proxy

This configuration routes traffic to multiple backend services (Prometheus and Grafana).

```nginx
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 4096;
}

http {
    sendfile on;
    large_client_header_buffers 4 32k;

    # Upstream definitions
    upstream prometheus {
        server localhost:9090;
    }

    upstream grafana {
        server localhost:3000;
    }

    server {
        listen 80;
        # For HTTPS, uncomment and configure:
        # listen 443 ssl;
        # ssl_certificate /etc/ssl/certs/your-cert.crt;
        # ssl_certificate_key /etc/ssl/private/your-cert.key;

        server_name monitoring.example.com;

        # Prometheus
        location /prometheus {
            proxy_pass          http://prometheus;
            proxy_redirect      off;
            proxy_http_version  1.1;
            proxy_cache_bypass  $http_upgrade;
            proxy_set_header    Upgrade $http_upgrade;
            proxy_set_header    Connection keep-alive;
            proxy_set_header    Host $host;
            proxy_set_header    X-Real-IP $remote_addr;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    X-Forwarded-Proto $scheme;
            proxy_set_header    X-Forwarded-Host $server_name;
            proxy_buffer_size   128k;
            proxy_buffers       4 256k;
            proxy_busy_buffers_size 256k;
        }

        # Grafana
        location /grafana {
            proxy_pass          http://grafana;
            proxy_set_header    Host $host;
            proxy_redirect      off;
            proxy_http_version  1.1;
            proxy_cache_bypass  $http_upgrade;
            proxy_set_header    Upgrade $http_upgrade;
            proxy_set_header    Connection keep-alive;
            proxy_set_header    X-Real-IP $remote_addr;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    X-Forwarded-Proto $scheme;
            proxy_set_header    X-Forwarded-Host $server_name;
            proxy_buffer_size   128k;
            proxy_buffers       4 256k;
            proxy_busy_buffers_size 256k;
        }
    }
}
```

---

## Common Proxy Headers

| Header | Description |
|--------|-------------|
| `X-Real-IP` | Original client IP address |
| `X-Forwarded-For` | Chain of proxy IP addresses |
| `X-Forwarded-Proto` | Original protocol (http/https) |
| `X-Forwarded-Host` | Original host requested by client |
| `Host` | Hostname from the request |

---

## Best Practices

1. **Use upstream blocks** for backend servers to enable load balancing
2. **Enable `proxy_http_version 1.1`** for WebSocket support
3. **Configure appropriate buffer sizes** based on your application needs
4. **Use HTTPS in production** with valid SSL certificates
5. **Set proper timeout values** for long-running requests
