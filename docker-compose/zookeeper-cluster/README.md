# Docker Compose ZooKeeper Cluster (Cluster + Visualization)

## Overview

ZooKeeper cluster containerized deployment solution, providing a cluster of three ZooKeeper instances with ZooNavigator Web management interface.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| zoo1 | zoo1 | 2181:2181 | all.zoo1 | ZooKeeper Node 1 |
| zoo2 | zoo2 | 2182:2181 | all.zoo2 | ZooKeeper Node 2 |
| zoo3 | zoo3 | 2183:2181 | all.zoo3 | ZooKeeper Node 3 |
| zoonavigator | zoonavigator | 9000:9000 | all.zoonavigator | Web Management Interface |

## Access Information

### ZooKeeper Connection

```bash
# ZooKeeper cluster connection string
127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183
```

### Web Management Interface

```bash
# ZooNavigator Web Interface
http://127.0.0.1:9000
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.zoo1:2181,all.zoo2:2181,all.zoo3:2181
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p zookeeper-multi -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p zookeeper-multi -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p zookeeper-multi -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── zoo1/
│   ├── data/     # ZooKeeper Node 1 data
│   └── logs/     # ZooKeeper Node 1 logs
├── zoo2/
│   ├── data/     # ZooKeeper Node 2 data
│   └── logs/     # ZooKeeper Node 2 logs
└── zoo3/
    ├── data/     # ZooKeeper Node 3 data
    └── logs/     # ZooKeeper Node 3 logs
```

## Environment Configuration

### Application Configuration

- **Image Version**: zookeeper:3.5
- **Cluster Nodes**: 3 nodes
- **Web Interface**: elkozmon/zoonavigator

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Cluster Configuration

### ZooKeeper Node Configuration

- **Node 1**: ID=1, Port=2181
- **Node 2**: ID=2, Port=2182  
- **Node 3**: ID=3, Port=2183

### Cluster Connection Configuration

Each node is configured with complete cluster information, supporting high availability.

## Use Cases

1. **Distributed Coordination**: Providing coordination services for distributed applications
2. **Configuration Management**: Centralized application configuration management
3. **Service Discovery**: Service registration and discovery
4. **Distributed Locking**: Implementing distributed lock mechanisms
5. **Kafka Dependency**: Serving as coordination service for Kafka

## Important Notes

1. Ensure ports 2181-2183 and 9000 are not occupied
2. Cluster requires odd number of nodes (recommended 3 or 5)
3. Ensure sufficient disk space for data storage
4. Recommend regular backup of ZooKeeper data
5. Recommend adjusting JVM parameters for production environments
