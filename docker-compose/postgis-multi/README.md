# Docker Compose PostGIS Multi-Container

## Overview

PostGIS multi-instance containerized deployment solution, providing three independent PostGIS instances for development and testing environments.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| postgis-1 | postgis-1 | 5432:5432 | all.postgis1 | Primary Instance |
| postgis-2 | postgis-2 | 5433:5432 | all.postgis2 | Replica 1 |
| postgis-3 | postgis-3 | 5434:5432 | all.postgis3 | Replica 2 |

## Database Connection Information

### Connection Strings

```bash
# PostGIS Instance 1
postgresql://hz_9:123456@127.0.0.1:5432/hz_9

# PostGIS Instance 2  
postgresql://hz_9:123456@127.0.0.1:5433/hz_9

# PostGIS Instance 3
postgresql://hz_9:123456@127.0.0.1:5434/hz_9
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
postgresql://hz_9:123456@all.postgis1:5432/hz_9
postgresql://hz_9:123456@all.postgis2:5432/hz_9
postgresql://hz_9:123456@all.postgis3:5432/hz_9
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p postgis-multi -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p postgis-multi -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p postgis-multi -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── db-1/data/    # PostGIS Instance 1 data
├── db-2/data/    # PostGIS Instance 2 data
└── db-3/data/    # PostGIS Instance 3 data
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

1. **Development Environment**: Local development and testing
2. **Cluster Simulation**: Simulating PostGIS cluster environment
3. **Data Isolation**: Different projects use different instances
4. **Spatial Data Processing**: Geographic Information System development

## Important Notes

1. Ensure ports 5432-5434 are not occupied
2. Ensure sufficient disk space for data storage
3. Change default password for production environments
4. Recommend regular data backups
5. PostGIS extension is automatically installed
