# Docker Compose RabbitMQ Single-Container

## Overview

RabbitMQ message queue single-instance containerized deployment solution, providing reliable message delivery service, including management interface and Prometheus monitoring metrics.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| rabbitmq | rabbitmq-single | 5672:5672, 15672:15672, 15692:15692 | all.rabbitmq | RabbitMQ message queue |

## Access Information

### AMQP Connection

```bash
# RabbitMQ AMQP Connection
amqp://hz_9:123456@localhost:5672/
```

### Web Management Interface

```bash
# RabbitMQ Management UI
http://localhost:15672
```

### Monitoring Metrics

```bash
# Prometheus metrics
http://localhost:15692/metrics
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.rabbitmq:5672
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p rabbitmq-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p rabbitmq-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p rabbitmq-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── data/         # RabbitMQ data directory
└── logs/         # RabbitMQ log directory
```

## Environment Configuration

### Application Configuration

- **Image Version**: rabbitmq:4.1.2-management
- **Default User**: hz_9
- **Default Password**: 123456
- **Virtual Host**: /
- **Enabled Plugins**: management, prometheus

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

### Port Configuration

- **AMQP Port**: 5672
- **Management Interface Port**: 15672
- **Prometheus Port**: 15692

## Usage Guide

### Connection Examples

#### Python (pika)

```python
import pika

# Establish connection
connection = pika.BlockingConnection(
    pika.ConnectionParameters(
        host='localhost',
        port=5672,
        virtual_host='/',
        credentials=pika.PlainCredentials('hz_9', '123456')
    )
)
channel = connection.channel()

# Declare queue
channel.queue_declare(queue='hello')

# Send message
channel.basic_publish(exchange='', routing_key='hello', body='Hello World!')

# Close connection
connection.close()
```

#### Node.js (amqplib)

```javascript
const amqp = require('amqplib');

async function main() {
  // Establish connection
  const connection = await amqp.connect('amqp://hz_9:123456@localhost:5672/');
  const channel = await connection.createChannel();
  
  // Declare queue
  await channel.assertQueue('hello');
  
  // Send message
  channel.sendToQueue('hello', Buffer.from('Hello World!'));
  
  // Close connection
  await connection.close();
}

main().catch(console.error);
```

#### Java (Spring AMQP)

```java
@Configuration
public class RabbitConfig {
    @Bean
    public ConnectionFactory connectionFactory() {
        CachingConnectionFactory factory = new CachingConnectionFactory();
        factory.setHost("localhost");
        factory.setPort(5672);
        factory.setUsername("hz_9");
        factory.setPassword("123456");
        factory.setVirtualHost("/");
        return factory;
    }
}
```

### Management Interface Operations

1. **Access Management Interface**: <http://localhost:15672>
2. **Login Credentials**: hz_9 / 123456
3. **Main Features**:
   - Queue management
   - Exchange configuration
   - Binding relationships
   - User permissions
   - Virtual hosts
   - Monitoring statistics

### Common Commands

```bash
# View queue status
docker exec rabbitmq-single rabbitmqctl list_queues

# View exchanges
docker exec rabbitmq-single rabbitmqctl list_exchanges

# View bindings
docker exec rabbitmq-single rabbitmqctl list_bindings

# View users
docker exec rabbitmq-single rabbitmqctl list_users

# View virtual hosts
docker exec rabbitmq-single rabbitmqctl list_vhosts
```

## Use Cases

1. **Asynchronous Message Processing**: Decouple system components
2. **Task Queues**: Background task processing
3. **Event Notification**: Event-driven architecture
4. **Load Balancing**: Request distribution
5. **Microservice Communication**: Inter-service messaging

## Performance Optimization

### Memory Configuration

- Default memory limit: 40% available RAM
- Production environment recommendation: `RABBITMQ_VM_MEMORY_HIGH_WATERMARK`

### Disk Space

- Default disk alarm threshold: 50MB
- Production environment recommendation: `RABBITMQ_DISK_FREE_LIMIT`

## Important Notes

1. Ensure ports 5672, 15672, 15692 are not occupied
2. Single instance does not provide high availability
3. Cluster deployment recommended for production environments
4. Regularly monitor memory and disk usage
5. Recommend enabling message persistence
6. Regularly backup important queue data
