# Docker Compose RabbitMQ Cluster (Cluster + Load Balancing)

## Overview

RabbitMQ message queue cluster containerized deployment solution, providing highly available message delivery service with 3 RabbitMQ nodes, HAProxy load balancer and complete monitoring system.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| rabbitmq-1 | rabbitmq-1 | 5672:5672, 15672:15672 | all.rabbitmq-1 | RabbitMQ Node 1 |
| rabbitmq-2 | rabbitmq-2 | 5673:5672, 15673:15672 | all.rabbitmq-2 | RabbitMQ Node 2 |
| rabbitmq-3 | rabbitmq-3 | 5674:5672, 15674:15672 | all.rabbitmq-3 | RabbitMQ Node 3 |
| haproxy | rabbitmq-loadbalancer | 5675:5672, 15675:15672, 8404:8404 | all.rabbitmq-lb | Load Balancer |

## Access Information

### Load Balanced Connection (Recommended)

```bash
# RabbitMQ AMQP Connection (Load Balanced)
amqp://hz_9:123456@localhost:5675/

# RabbitMQ Management Interface (Load Balanced)
http://localhost:15675

# HAProxy Statistics Page
http://localhost:8404 (admin/123456)
```

### Single Node Access

```bash
# Node 1
amqp://hz_9:123456@localhost:5672/
http://localhost:15672

# Node 2  
amqp://hz_9:123456@localhost:5673/
http://localhost:15673

# Node 3
amqp://hz_9:123456@localhost:5674/
http://localhost:15674
```

### Network Internal Connection (Inter-container Communication)

```bash
# Load balanced connection
all.rabbitmq-lb:5672

# Direct node connection
all.rabbitmq-1:5672,all.rabbitmq-2:5672,all.rabbitmq-3:5672
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p rabbitmq-cluster -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p rabbitmq-cluster -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p rabbitmq-cluster -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── rabbitmq-1/
│   ├── data/     # RabbitMQ Node 1 data
│   └── logs/     # RabbitMQ Node 1 logs
├── rabbitmq-2/
│   ├── data/     # RabbitMQ Node 2 data
│   └── logs/     # RabbitMQ Node 2 logs
└── rabbitmq-3/
    ├── data/     # RabbitMQ Node 3 data
    └── logs/     # RabbitMQ Node 3 logs
```

## Environment Configuration

### Application Configuration

- **Image Version**: rabbitmq:4.1.2-management
- **Cluster Nodes**: 3 nodes
- **Default User**: hz_9
- **Default Password**: 123456
- **Virtual Host**: /
- **Load Balancer**: HAProxy 2.8

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

### Cluster Configuration

- **Cluster Mode**: Classic cluster
- **Erlang Cookie**: rabbitmq_cluster_cookie_hz9
- **Node Discovery**: Static configuration
- **Queue Mirroring**: Supported

## Cluster Management

### Cluster Status Check

```bash
# Check cluster status
docker exec rabbitmq-1 rabbitmqctl cluster_status

# Check node health
docker exec rabbitmq-1 rabbitmqctl node_health_check

# Check queue distribution
docker exec rabbitmq-1 rabbitmqctl list_queues name node
```

### High Availability Queue Configuration

```bash
# Create mirrored queue policy
docker exec rabbitmq-1 rabbitmqctl set_policy ha-all "^ha\." '{"ha-mode":"all"}'

# Create specific replica count policy
docker exec rabbitmq-1 rabbitmqctl set_policy ha-two "^two\." '{"ha-mode":"exactly","ha-params":2}'

# View policies
docker exec rabbitmq-1 rabbitmqctl list_policies
```

### Load Balancing Configuration

HAProxy configuration provides:

- **Round Robin Load Balancing**: AMQP connection distribution
- **Health Checks**: Automatic node status detection
- **Failover**: Automatic removal of failed nodes
- **Statistics Monitoring**: Real-time monitoring page

## Usage Guide

### Connection Examples (Load Balanced)

#### Python (pika)

```python
import pika

# Connect to load balancer
connection = pika.BlockingConnection(
    pika.ConnectionParameters(
        host='localhost',
        port=5675,  # Load balancer port
        virtual_host='/',
        credentials=pika.PlainCredentials('hz_9', '123456')
    )
)
```

#### Node.js (amqplib)

```javascript
const amqp = require('amqplib');

// Connect to load balancer
const connection = await amqp.connect('amqp://hz_9:123456@localhost:5675/');
```

#### Java (Spring AMQP)

```java
@Configuration
public class RabbitConfig {
    @Bean
    public ConnectionFactory connectionFactory() {
        CachingConnectionFactory factory = new CachingConnectionFactory();
        factory.setHost("localhost");
        factory.setPort(5675);  // Load balancer port
        factory.setUsername("hz_9");
        factory.setPassword("123456");
        factory.setVirtualHost("/");
        return factory;
    }
}
```

### High Availability Queue Usage

```python
import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost', 5675))
channel = connection.channel()

# Declare high availability queue
channel.queue_declare(
    queue='ha.important_queue',
    durable=True,           # Queue persistence
    arguments={
        'x-ha-policy': 'all',  # Mirror to all nodes
        'x-ha-policy-params': None
    }
)
```

## Monitoring and Operations

### HAProxy Statistics Monitoring

- **Access URL**: <http://localhost:8404>
- **Authentication**: admin / 123456
- **Monitoring Content**:
  - Node health status
  - Connection distribution statistics
  - Response time
  - Error rate statistics

### Cluster Monitoring Commands

```bash
# Check memory usage
docker exec rabbitmq-1 rabbitmqctl status | grep memory

# Check disk usage
docker exec rabbitmq-1 rabbitmqctl status | grep disk

# Check connections
docker exec rabbitmq-1 rabbitmqctl list_connections

# Check consumers
docker exec rabbitmq-1 rabbitmqctl list_consumers
```

## Disaster Recovery

### Node Failure

- **Automatic Handling**: HAProxy automatically removes failed nodes
- **Queue Mirroring**: Mirrored queues continue to provide service
- **Manual Recovery**: Failed nodes automatically rejoin cluster after restart

### Split Brain Handling

```bash
# Stop all nodes
docker compose down

# Start one node as master
docker compose up -d rabbitmq-1

# Wait for master node to start
sleep 30

# Start other nodes
docker compose up -d rabbitmq-2 rabbitmq-3
```

## Use Cases

1. **High Availability Message Queue**: Business-critical systems
2. **Large-scale Message Processing**: High concurrency scenarios
3. **Microservices Architecture**: Inter-service communication
4. **Event-driven Systems**: Asynchronous processing
5. **Load Balancing**: Request distribution

## Performance Optimization

### Cluster Optimization

- **Network Partitions**: Configure appropriate network partition handling strategy
- **Queue Distribution**: Reasonably distribute queues to different nodes
- **Memory Management**: Set appropriate memory watermarks
- **Disk Space**: Monitor disk usage

### Load Balancing Optimization

- **Connection Pooling**: Use connection pools to reduce connection overhead
- **Health Checks**: Adjust health check frequency
- **Timeout Settings**: Set reasonable connection timeouts

## Important Notes

1. Ensure ports 5672-5675, 15672-15675, 8404 are not occupied
2. Cluster startup takes time, recommend waiting 30 seconds before checking status
3. Recommend configuring persistent queues and messages for production
4. Regularly monitor cluster health status
5. Recommend configuring queue mirroring policies for high availability
6. Pay attention to Erlang Cookie security
7. Regularly backup important queue data
