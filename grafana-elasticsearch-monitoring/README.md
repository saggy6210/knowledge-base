# Grafana Elasticsearch Monitoring Stack

A Docker-based monitoring solution using Elasticsearch for data storage and Grafana for visualization. Includes a shell script to collect and push system metrics.

## Overview

This project demonstrates:
- Setting up Elasticsearch and Grafana using Docker Compose
- Collecting system metrics (CPU, memory, disk) via shell script
- Storing metrics in Elasticsearch
- Visualizing data in Grafana dashboards

## Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────┐
│  statuscheck.sh │────▶│  Elasticsearch   │◀────│   Grafana   │
│  (Metrics)      │     │  (Data Store)    │     │  (Dashboard)│
└─────────────────┘     └──────────────────┘     └─────────────┘
```

## Quick Start

### 1. Start the Stack

```bash
docker-compose up -d
```

### 2. Access Services

| Service | URL | Default Credentials |
|---------|-----|---------------------|
| Grafana | http://localhost:3000 | admin / admin |
| Elasticsearch | http://localhost:9200 | N/A |

### 3. Create Elasticsearch Index

Use Postman or curl to create the index with mapping:

```bash
curl -X PUT "http://localhost:9200/test_index" -H "Content-Type: application/json" -d '
{
  "mappings": {
    "data": {
      "properties": {
        "timestamp": {
          "type": "date"
        }
      }
    }
  }
}'
```

### 4. Configure Grafana Data Source

1. Login to Grafana (http://localhost:3000)
2. Go to **Configuration** → **Data Sources**
3. Add **Elasticsearch** data source:
   - URL: `http://elasticsearch:9200`
   - Index name: `test_index`
   - Time field name: `timestamp`

### 5. Run Metrics Collection

```bash
./statuscheck.sh
```

## Docker Compose Services

### Elasticsearch

- **Image:** `docker.elastic.co/elasticsearch/elasticsearch:6.2.4`
- **Ports:** 9200 (HTTP), 9300 (Transport)
- **Memory:** 512MB heap size
- **Persistence:** `./data/esdata1`

### Grafana

- **Image:** `grafana/grafana:5.1.0`
- **Port:** 3000
- **Persistence:** `./data/grafana`

## Metrics Collected

The `statuscheck.sh` script collects:

| Metric | Description |
|--------|-------------|
| `hostname` | Server hostname |
| `status` | System up/down status (1/0) |
| `cpuload` | Current CPU load percentage |
| `totalRam` | Total RAM in MB |
| `usedRam` | Used RAM in MB |
| `diskPerc` | Disk usage percentage |
| `diskused` | Disk space used |
| `disk_total` | Total disk space |
| `reboot_required` | Whether reboot is required (1/0) |
| `timestamp` | Collection timestamp |

## Automated Collection with Cron

Set up automated metrics collection every 5 minutes:

```bash
crontab -e
```

Add the following line:

```
*/5 * * * * /path/to/statuscheck.sh
```

## File Structure

```
grafana-elasticsearch-monitoring/
├── docker-compose.yml  # Service definitions
├── statuscheck.sh      # Metrics collection script
├── README.md           # This documentation
├── payload.json        # (generated) Metrics payload
└── data/               # (generated) Persistent data
    ├── esdata1/        # Elasticsearch data
    └── grafana/        # Grafana data
```

## Troubleshooting

### Elasticsearch won't start

Check memory lock settings:
```bash
sudo sysctl -w vm.max_map_count=262144
```

### Permission issues with volumes

The docker-compose runs Grafana as root user (`user: "0"`) to avoid permission issues.

### Check Elasticsearch health

```bash
curl http://localhost:9200/_cluster/health?pretty
```

## Related Documentation

- [Elasticsearch Guide](../elasticsearch_guide.md)
- [Docker Basics](../docker_basics.md)
