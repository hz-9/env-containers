# Docker Compose Kafka Multi-Container (KRaft Cluster)

## Overview

Kafka cluster containerized deployment solution based on KRaft mode (no ZooKeeper required), providing three Kafka broker/controller instances and modern Kafka UI Web management interface.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| kafka-1 | kafka-1 | 9092:9092, 9093:9093 | all.kafka1 | Kafka Broker/Controller 1 |
| kafka-2 | kafka-2 | 9094:9092, 9095:9093 | all.kafka2 | Kafka Broker/Controller 2 |
| kafka-3 | kafka-3 | 9096:9092, 9097:9093 | all.kafka3 | Kafka Broker/Controller 3 |
| kafka-ui | kafka-ui | 9080:8080 | all.kafka-ui | Kafka Web Management Interface |

## Access Information

### Kafka Connection

```bash
# Kafka cluster connection string
localhost:9092,localhost:9094,localhost:9096
```

### Web Management Interface

```bash
# Kafka UI Web Interface (Modern Kafka Management)
http://localhost:9080
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.kafka1:9092,all.kafka2:9092,all.kafka3:9092
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p kafka-multi -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p kafka-multi -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p kafka-multi -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── kafka-1/
│   ├── data/     # Kafka Broker 1 data (KRaft)
│   └── logs/     # Kafka Broker 1 logs
├── kafka-2/
│   ├── data/     # Kafka Broker 2 data (KRaft)
│   └── logs/     # Kafka Broker 2 logs
└── kafka-3/
    ├── data/     # Kafka Broker 3 data (KRaft)
    └── logs/     # Kafka Broker 3 logs
```

## Environment Configuration

### Application Configuration

- **Kafka**: apache/kafka:3.9.1 (KRaft mode)
- **Kafka UI**: provectuslabs/kafka-ui:latest
- **Mode**: KRaft (no ZooKeeper required)
- **Replication Factor**: 3 (cluster mode)

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

### Cluster Configuration

- **Broker Count**: 3 brokers
- **Controller Count**: 3 controllers (each node is both Broker and Controller)
- **Replication Factor**: Recommended to set to 3
- **Partition Count**: Adjustable as needed

## KRaft Mode Advantages

1. **No ZooKeeper Required**: Simplified architecture, reduced operational complexity
2. **Faster Startup**: Shorter cluster startup time
3. **Less Resource Usage**: Lower memory and storage consumption
4. **Better Scalability**: Support for larger scale clusters
5. **Modern Architecture**: Recommended architecture for Kafka 3.0+

## Use Cases

1. **Message Queue**: High-throughput message delivery
2. **Log Collection**: Centralized log processing
3. **Event Stream Processing**: Real-time data stream processing
4. **Microservice Communication**: Asynchronous inter-service communication
5. **Data Pipeline**: Data ETL pipelines

## Kafka UI Usage

### Web Interface Features

- Access: <http://localhost:9080>
- Cluster Name: kafka-cluster  
- Bootstrap Servers: kafka-1:9092,kafka-2:9092,kafka-3:9092
- Features: Topic management, consumer group monitoring, message browsing, cluster monitoring

## Common Operations

### Topic Management

```bash
# Create topic (3 replicas)
docker exec kafka-1 kafka-topics.sh --create --topic my-topic --partitions 3 --replication-factor 3 --bootstrap-server localhost:9092

# List topics
docker exec kafka-1 kafka-topics.sh --list --bootstrap-server localhost:9092

# Describe topic details
docker exec kafka-1 kafka-topics.sh --describe --topic my-topic --bootstrap-server localhost:9092
```

### Produce Messages

```bash
# Start producer
docker exec -it kafka-1 kafka-console-producer.sh --topic my-topic --bootstrap-server localhost:9092
```

### Consume Messages

```bash
# Start consumer
docker exec -it kafka-1 kafka-console-consumer.sh --topic my-topic --from-beginning --bootstrap-server localhost:9092
```

## Important Notes

1. Ensure ports 9092, 9094, 9096, 9080 are not occupied
2. KRaft mode does not require ZooKeeper, providing simpler architecture
3. Cluster provides high availability, single point failures do not affect service
4. Ensure sufficient disk space for message storage
5. Recommend adjusting JVM parameters and resource configuration for production
6. Recommend regular cleanup of expired messages
7. KRaft mode is the recommended architecture for Kafka 3.0+
