# Elasticsearch Cluster

Docker Compose-based Elasticsearch cluster orchestration, including 3 Elasticsearch nodes and 1 Kibana instance.

## Service Components

### Elasticsearch Cluster
- **es01**: Master Node 1, Port 9200
- **es02**: Master Node 2  
- **es03**: Master Node 3
- **kibana**: Kibana Visualization Interface, Port 5601

### Technical Specifications
- **Elasticsearch Version**: 8.13.4
- **Kibana Version**: 8.13.4
- **Cluster Name**: docker-cluster
- **Security**: SSL/TLS encryption and authentication enabled
- **Load Balancing**: Kibana connects to all Elasticsearch nodes

## Quick Start

### Start Cluster
```bash
cd docker-compose/elasticsearch-multi
./bin/up.sh
```

### Stop Cluster
```bash
./bin/down.sh
```

## Access Information

### Web Interface
- **Kibana**: http://localhost:5601
- **Elasticsearch API**: https://localhost:9200

### Authentication
- **Username**: elastic
- **Password**: 123456

### API Testing
```bash
# Check cluster health
curl -k -u elastic:123456 https://localhost:9200/_cluster/health

# View cluster node information  
curl -k -u elastic:123456 https://localhost:9200/_cat/nodes?v

# View cluster status
curl -k -u elastic:123456 https://localhost:9200/_cluster/stats?pretty
```

## Data Persistence

Data volumes are mounted to the `temp/` directory:

```
temp/
├── certs/              # SSL/TLS certificates
├── esdata01/           # Node 1 data
├── eslogs01/           # Node 1 logs  
├── esplugins01/        # Node 1 plugins
├── esdata02/           # Node 2 data
├── eslogs02/           # Node 2 logs
├── esplugins02/        # Node 2 plugins
├── esdata03/           # Node 3 data
├── eslogs03/           # Node 3 logs
├── esplugins03/        # Node 3 plugins
└── kibanadata/         # Kibana data
```

## Cluster Features

### High Availability
- 3-node cluster ensures data redundancy
- Automatic failover and recovery
- Shards distributed across multiple nodes

### Security Configuration
- SSL/TLS encrypted transmission
- Authentication and authorization
- Automatic certificate generation

### Performance Configuration
- Memory locking to avoid swapping
- Optimized JVM heap size
- Health checks and monitoring

## Environment Variables

Customizable configuration in `.env` file:

```bash
# Basic Configuration
ELASTIC_PASSWORD=123456          # elastic user password
KIBANA_PASSWORD=123456           # kibana_system user password  
STACK_VERSION=8.13.4             # Elastic Stack version
CLUSTER_NAME=docker-cluster      # cluster name

# Port Configuration
ES_PORT=9200                     # Elasticsearch port
KIBANA_PORT=5601                 # Kibana port

# Memory Limits (bytes)
ES_MEM_LIMIT=1073741824         # Elasticsearch memory limit (1GB)
KB_MEM_LIMIT=1073741824         # Kibana memory limit (1GB)

# License Type
LICENSE=basic                    # License type (basic/trial)
```

## Use Cases

### Production Environment

- Large-scale log analysis
- Real-time search services  
- Data visualization and monitoring
- High availability requirements

### Development and Testing

- Cluster functionality testing
- Performance benchmarking
- Multi-node configuration validation
- Disaster recovery drills

## Operations

### Check Service Status

```bash
docker compose -p elasticsearch-multi ps
```

### View Logs

```bash
# View all service logs
docker compose -p elasticsearch-multi logs

# View specific node logs
docker logs es01
docker logs kibana
```

### Restart Services

```bash
# Restart entire cluster
./bin/down.sh && ./bin/up.sh

# Restart single node
docker compose -p elasticsearch-multi restart es01
```

### Cluster Scaling

To add more nodes:

1. Add new node configuration in docker-compose.yml
2. Update certificate configuration to include new nodes
3. Adjust cluster initial master node list

## Important Notes

1. **System Requirements**: Ensure sufficient memory (recommended 4GB+)
2. **Port Conflicts**: Ensure ports 9200 and 5601 are not occupied
3. **Certificate Management**: SSL certificates are automatically generated on first startup
4. **Data Backup**: Regularly backup important data in temp/ directory
5. **Memory Settings**: Adjust memory limits according to actual hardware
6. **Network Configuration**: Uses custom network hz_9 by default

## Troubleshooting

### Common Issues

1. **Startup Failure**: Check port usage and memory resources
2. **Certificate Errors**: Delete temp/certs directory to regenerate
3. **Connection Timeout**: Wait for all nodes to fully start (about 2-3 minutes)
4. **Out of Memory**: Adjust memory limits in .env file

### Log Analysis

```bash
# View detailed startup logs
docker compose -p elasticsearch-multi logs -f

# Check specific node status
docker logs es01 --tail 100
```
