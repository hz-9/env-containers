# Docker Compose Kafka Single-Container (KRaft Mode)

## Overview

Kafka single-instance containerized deployment solution, based on KRaft mode (no ZooKeeper required), providing a Kafka broker instance and modern Kafka UI web management interface.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| kafka | kafka-single | 9092:9092, 9093:9093 | all.kafka | Kafka Broker (KRaft mode) |
| kafka-ui | kafka-ui | 9080:8080 | all.kafka-ui | Kafka Web management interface |

## Access Information

### Kafka Connection

```bash
# Kafka connection string
localhost:9092
```

### Web Management Interface

```bash
# Kafka UI Web Interface (modern Kafka management)
http://localhost:9080
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.kafka:9092
# Or use container name
kafka-single:9092
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p kafka-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p kafka-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p kafka-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
└── kafka/
    ├── data/     # Kafka data directory (KRaft mode)
    └── logs/     # Kafka logs
```

## Environment Configuration

### Application Configuration

- **Kafka**: apache/kafka:3.9.1 (KRaft mode)
- **Kafka UI**: provectuslabs/kafka-ui:latest
- **Mode**: KRaft (no ZooKeeper required)
- **Replication Factor**: 1 (single instance)

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## KRaft Mode Advantages

1. **No ZooKeeper Required**: Simplified architecture, reduced dependencies
2. **Faster Startup**: Shorter startup time
3. **Less Resource Usage**: Lower memory and storage consumption
4. **Modern Architecture**: Recommended architecture for Kafka 3.0+

## Use Cases

1. **Development Environment**: Local development and testing
2. **Learning Environment**: Kafka learning and experimentation
3. **Prototype Development**: Rapid prototype validation
4. **Lightweight Deployment**: Resource-constrained environments
5. **Modern Architecture**: No ZooKeeper dependency

## Web Interface Configuration

### Kafka UI Configuration

- Access: <http://localhost:9080>
- Cluster Name: kafka-single
- Bootstrap Servers: kafka-single:9092
- Features: Topic management, consumer group monitoring, message browsing

## Common Operations

### Topic Management

```bash
# Create topic
docker exec kafka-single kafka-topics.sh --create --topic my-topic --bootstrap-server localhost:9092

# List topics
docker exec kafka-single kafka-topics.sh --list --bootstrap-server localhost:9092

# Describe topic details
docker exec kafka-single kafka-topics.sh --describe --topic my-topic --bootstrap-server localhost:9092
```

### Produce Messages

```bash
# Start producer
docker exec -it kafka-single kafka-console-producer.sh --topic my-topic --bootstrap-server localhost:9092
```

### Consume Messages

```bash
# Start consumer
docker exec -it kafka-single kafka-console-consumer.sh --topic my-topic --from-beginning --bootstrap-server localhost:9092
```

## Important Notes

1. Ensure ports 9092, 9093, 9080 are not occupied
2. KRaft mode does not require ZooKeeper, providing simpler architecture
3. Single instance does not provide high availability
4. Ensure sufficient disk space for message storage
5. Recommend cluster deployment for production environments
6. Recommend regular cleanup of expired messages
7. KRaft mode is the recommended architecture for Kafka 3.0+
