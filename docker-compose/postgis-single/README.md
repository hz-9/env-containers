# Docker Compose PostGIS Single-Container

## Overview

PostGIS single-instance containerized deployment solution, providing a PostGIS instance for simple development and testing environments.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| postgis | postgis | 5432:5432 | all.postgis | Single instance |

## Database Connection Information

### Connection String

```bash
# PostGIS instance
postgresql://hz_9:123456@127.0.0.1:5432/hz_9
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
postgresql://hz_9:123456@all.postgis:5432/hz_9
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p postgis-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p postgis-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p postgis-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
└── data/    # PostGIS instance data
```

## Environment Configuration

### Database Configuration

- **Image Version**: mdillon/postgis:9.6-alpine
- **Database Name**: hz_9
- **Username**: hz_9
- **Password**: 123456

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Use Cases

1. **Development Environment**: Simple local development and testing
2. **Prototype Development**: Rapid prototype validation
3. **Learning Environment**: PostGIS learning and testing
4. **Lightweight Deployment**: Resource-constrained environments

## Important Notes

1. Ensure port 5432 is not occupied
2. Ensure sufficient disk space for data storage
3. Change default password for production environments
4. Recommend regular data backups
5. PostGIS extension is automatically installed
