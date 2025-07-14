# Docker Compose MinIO Single-Container

## Overview

MinIO single-instance containerized deployment solution, providing a high-performance object storage service compatible with Amazon S3 API for simple development and testing environments.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| minio | minio-single | 9000:9000, 9001:9001 | all.minio | Single instance |

## Connection Information

### Access URLs

```bash
# MinIO Console (Web UI)
http://localhost:9001

# MinIO API Endpoint
http://localhost:9000
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
# Console: http://all.minio:9001
# API: http://all.minio:9000
```

### Default Credentials

- **Username**: hz_9
- **Password**: 12345678

## Quick Start

```bash
# Start services
./bin/up.sh

# Stop services
./bin/down.sh
```

## Data Directory

Data will be stored in the `./temp/minio/data` directory.

## Usage Instructions

1. After starting the service, access the MinIO console through your browser
2. Login using the default credentials
3. Create buckets and upload files
4. Supports S3-compatible API calls
