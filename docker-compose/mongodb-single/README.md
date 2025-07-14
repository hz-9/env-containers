# Docker Compose MongoDB Single-Container

## Overview

MongoDB single-instance containerized deployment solution, providing a MongoDB instance for simple development and testing environments.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| mongodb | mongodb | 27017:27017 | all.mongodb | Single instance |

## Database Connection Information

### Connection String

```bash
# MongoDB instance
mongodb://hz_9:123456@127.0.0.1:27017/hz_9?authSource=admin
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
mongodb://hz_9:123456@all.mongodb:27017/hz_9?authSource=admin
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p mongodb-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p mongodb-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p mongodb-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
└── data/    # MongoDB instance data
```

## Environment Configuration

### Database Configuration

- **Image Version**: mongo:4.0-xenial
- **Database Name**: hz_9
- **Username**: hz_9
- **Password**: 123456
- **Authentication Database**: admin

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Use Cases

1. **Development Environment**: Simple local development testing
2. **Prototype Development**: Rapid prototype validation
3. **Learning Environment**: MongoDB learning and testing
4. **Lightweight Deployment**: Resource-constrained environments

## Important Notes

1. Ensure port 27017 is not occupied
2. Ensure sufficient disk space for data storage
3. Change default password for production environments
4. Recommend regular data backups
