# Azure Storage Accounts Guide

## Table of Contents

- [Overview](#overview)
- [Types of Storage Accounts](#types-of-storage-accounts)
- [Access Tiers](#access-tiers)
- [Storage Redundancy Options](#storage-redundancy-options)

---

## Overview

Azure Storage provides scalable, durable cloud storage for blobs, files, queues, and tables.

## Types of Storage Accounts

| Account Type | Description | Access Tiers | Redundancy Options |
|--------------|-------------|--------------|-------------------|
| **General-purpose v2** | Recommended for blobs, files, queues, and tables | Hot, Cool, Archive | LRS, GRS, RA-GRS, ZRS, GZRS |
| **General-purpose v1** | Legacy account type for blobs, files, queues, and tables | N/A | LRS, GRS, RA-GRS |
| **BlockBlobStorage** | Premium performance for block blobs and append blobs | N/A | LRS, ZRS |
| **FileStorage** | Premium performance for files only | N/A | LRS, ZRS |
| **BlobStorage** | Legacy blob-only storage accounts | Hot, Cool, Archive | LRS, GRS, RA-GRS |

## Access Tiers

| Tier | Storage Cost | Access Cost | Use Case |
|------|--------------|-------------|----------|
| **Hot** | Higher | Lower | Frequently accessed data |
| **Cool** | Lower than Hot | Higher than Hot | Infrequently accessed data (stored for at least 30 days) |
| **Archive** | Lowest | Highest | Rarely accessed data (stored for at least 180 days). Early deletion charges apply |

> **Note:** Data must remain in the archive tier for at least 180 days or be subject to an early deletion charge.

## Storage Redundancy Options

Azure Storage accounts are always replicated three times in the primary region.

| Redundancy | Description | Use Case |
|------------|-------------|----------|
| **LRS (Locally Redundant Storage)** | Copies data synchronously three times within a single physical location in the primary region | Cost-effective, protects against local hardware failures |
| **ZRS (Zone-Redundant Storage)** | Replicates data synchronously across three Azure availability zones in the primary region | High availability within a region |
| **GRS (Geo-Redundant Storage)** | Uses LRS in primary region, then copies data asynchronously to a single physical location in a secondary region | Disaster recovery across regions |
| **GZRS (Geo-Zone-Redundant Storage)** | Uses ZRS in primary region, then copies data asynchronously to a single physical location in a secondary region | Maximum durability and availability |
