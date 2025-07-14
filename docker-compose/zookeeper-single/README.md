# Docker Compose ZooKeeper Single-Container (Single Instance + Visualization)

## Overview

ZooKeeper single-instance containerized deployment solution, providing a ZooKeeper instance with ZooNavigator web management interface.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| zookeeper | zookeeper | 2181:2181 | all.zookeeper | ZooKeeper service |
| zoonavigator | zoonavigator | 9000:9000 | all.zoonavigator | Web management interface |

## Access Information

### ZooKeeper Connection

```bash
# ZooKeeper connection string
127.0.0.1:2181
```

### Web Management Interface

```bash
# ZooNavigator Web Interface
http://127.0.0.1:9000
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.zookeeper:2181
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p zookeeper-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p zookeeper-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p zookeeper-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
└── zookeeper/
    ├── data/     # ZooKeeper data
    └── logs/     # ZooKeeper logs
```

## Environment Configuration

### Application Configuration

- **Image Version**: zookeeper:3.5
- **Web Interface**: elkozmon/zoonavigator

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Use Cases

1. **Development Environment**: Simple development testing
2. **Learning Environment**: ZooKeeper learning and testing
3. **Lightweight Deployment**: Resource-constrained environments
4. **Configuration Management**: Simple configuration management needs

## Important Notes

1. Ensure ports 2181 and 9000 are not occupied
2. Single instance does not provide high availability
3. Ensure sufficient disk space for data storage
4. Recommend regular ZooKeeper data backups
5. Cluster deployment recommended for production environments
