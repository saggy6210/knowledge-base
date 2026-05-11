# Elasticsearch Guide

## Table of Contents

- [Overview](#overview)
- [Core Concepts](#core-concepts)
- [Installation](#installation)
- [Configuration](#configuration)
- [Index Operations](#index-operations)
- [Data Operations](#data-operations)
- [Search Operations](#search-operations)

---

## Overview

Elasticsearch is a highly scalable open-source full-text search and analytics engine. It allows you to store, search, and analyze large volumes of data quickly and in near real-time.

## Core Concepts

| Concept | Description |
|---------|-------------|
| **Cluster** | Collection of one or more nodes that holds your entire data and provides federated indexing and search capabilities |
| **Node** | Single server that is part of your cluster, stores data, and participates in indexing and search |
| **Index** | Collection of documents with similar characteristics |
| **Type** | Logical partition of an index (deprecated in newer versions) |
| **Document** | Basic unit of information that can be indexed |

### Shards

An index can store large amounts of data exceeding single node hardware limits. Elasticsearch subdivides indexes into **shards**.

**Benefits of Sharding:**
- Horizontally split/scale content volume
- Distribute and parallelize operations across shards for increased throughput

### Replicas

Elasticsearch allows creating copies of index shards called **replicas**.

**Benefits of Replication:**
- High availability if a shard/node fails
- Scale out search volume/throughput (searches execute on all replicas in parallel)

## Installation

> **Reference:** [Official Installation Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html)

### Ubuntu Installation

```bash
# Add Elasticsearch repository
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

# Install Java (required)
sudo add-apt-repository ppa:openjdk-r/ppa --yes
sudo apt-get update
sudo apt-get install openjdk-8-jre openjdk-8-jre-headless openjdk-8-jdk -y

# Install Elasticsearch
sudo apt-get install elasticsearch -y

# Enable and start service
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
```

## Configuration

Configuration file: `/etc/elasticsearch/elasticsearch.yml`

### Key Settings

```yaml
# Data and log paths
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch

# Network settings
http.host: 0.0.0.0
http.port: 9200
transport.tcp.port: 9300

# Cluster discovery (for multi-node clusters)
discovery.zen.ping.unicast.hosts: ["node1-ip", "node2-ip", "node3-ip"]
```

### Restart After Configuration Changes

```bash
sudo systemctl restart elasticsearch
```

## Index Operations

### List All Indices

```bash
GET /_cat/indices?v
```

### Create an Index

```bash
PUT /index-name
{
  "settings": {
    "index": {
      "number_of_shards": 3,
      "number_of_replicas": 2
    }
  },
  "mappings": {
    "properties": {
      "timestamp": {
        "type": "date",
        "format": "epoch_millis||epoch_second"
      },
      "status": {
        "type": "keyword"
      },
      "count": {
        "type": "integer"
      }
    }
  }
}
```

### Delete an Index

```bash
DELETE /index-name
```

## Data Operations

### Add Document to Index

```bash
POST /index-name/_doc
{
  "field1": "value1",
  "field2": "value2"
}
```

### Bulk Load Data

```bash
curl -H "Content-Type: application/json" \
  -XPOST "localhost:9200/bank/_doc/_bulk?pretty&refresh" \
  --data-binary "@accounts.json"
```

### Sample Document Format

```json
{
  "account_number": 0,
  "balance": 16623,
  "firstname": "John",
  "lastname": "Doe",
  "age": 29,
  "gender": "M",
  "address": "123 Main Street",
  "employer": "Acme Corp",
  "email": "john.doe@example.com",
  "city": "Springfield",
  "state": "IL"
}
```

## Search Operations

### Basic Search

```bash
GET /bank/_search
{
  "query": {
    "match_all": {}
  }
}
```

### AWS Elasticsearch with Signed Requests

When using AWS Elasticsearch, use signed requests:

```bash
awscurl -XGET "https://your-es-endpoint/index-name/_search" \
  --secret_key $AWS_SECRET_ACCESS_KEY \
  --session_token $AWS_SESSION_TOKEN \
  --access_key $AWS_ACCESS_KEY_ID \
  --service es
```

> **Security Note:** Never hardcode AWS credentials. Use IAM roles, environment variables, or AWS credential files.
