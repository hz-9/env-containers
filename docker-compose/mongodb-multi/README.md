# Docker Compose MongoDB Multi-Container

## Overview

MongoDB multi-instance containerized deployment solution, providing three independent MongoDB instances for development and testing environments.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| mongodb-1 | mongodb-1 | 27017:27017 | all.mongodb1 | Primary Instance |
| mongodb-2 | mongodb-2 | 27018:27017 | all.mongodb2 | Replica 1 |
| mongodb-3 | mongodb-3 | 27019:27017 | all.mongodb3 | Replica 2 |

## Database Connection Information

### Connection Strings

```bash
# MongoDB Instance 1
mongodb://hz_9:123456@127.0.0.1:27017/hz_9?authSource=admin

# MongoDB Instance 2  
mongodb://hz_9:123456@127.0.0.1:27018/hz_9?authSource=admin

# MongoDB Instance 3
mongodb://hz_9:123456@127.0.0.1:27019/hz_9?authSource=admin
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
mongodb://hz_9:123456@all.mongodb1:27017/hz_9?authSource=admin
mongodb://hz_9:123456@all.mongodb2:27017/hz_9?authSource=admin
mongodb://hz_9:123456@all.mongodb3:27017/hz_9?authSource=admin
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p docker-compose-mongodb-multi -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p docker-compose-mongodb-multi -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p docker-compose-mongodb-multi -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── db-1/data/    # MongoDB Instance 1 data
├── db-2/data/    # MongoDB Instance 2 data
└── db-3/data/    # MongoDB Instance 3 data
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

1. **Development Environment**: Local development and testing
2. **Cluster Simulation**: Simulating MongoDB cluster environment
3. **Data Isolation**: Different projects use different instances
4. **Performance Testing**: Multi-instance load testing

## Important Notes

1. Ensure ports 27017-27019 are not occupied
2. Ensure sufficient disk space for data storage
3. Change default password for production environments
4. Recommend regular data backups
