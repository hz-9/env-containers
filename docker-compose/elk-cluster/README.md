# Docker Compose ELK Stack Cluster

## Overview

ELK Stack (Elasticsearch, Logstash, and Kibana) cluster deployment with security features enabled, providing comprehensive log aggregation, search, and visualization capabilities. This setup includes Beats components for data collection and monitoring.

## Service List

| Service Name | Container Name | Port Mapping | Network | Purpose |
|--------------|----------------|--------------|---------|---------|
| setup | elk-cluster-setup-1 | - | elastic | SSL certificate setup and initialization |
| elasticsearch | elk-cluster-elasticsearch-1 | 9200:9200 | elastic | Search and analytics engine |
| kibana | elk-cluster-kibana-1 | 5601:5601 | elastic | Data visualization and management |
| logstash | elk-cluster-logstash-1 | 5044:5044 | elastic | Data processing pipeline |
| metricbeat | elk-cluster-metricbeat-1 | - | elastic | Metrics collection and monitoring |
| filebeat | elk-cluster-filebeat-1 | - | elastic | Log file collection and forwarding |

## Access Information

### Elasticsearch API

```bash
# Elasticsearch HTTPS API (with SSL)
https://localhost:9200

# Authentication required
Username: elastic
Password: 123456 (configurable in .env)
```

### Kibana Web Interface

```bash
# Kibana Dashboard
http://localhost:5601

# Login credentials
Username: elastic
Password: 123456 (configurable in .env)
```

### Logstash

```bash
# Logstash beats input port
localhost:5044

# Logstash API
http://localhost:9600
```

## Configuration

### Environment Variables (.env)

```bash
# Security passwords
ELASTIC_PASSWORD=123456          # Password for elastic user
KIBANA_PASSWORD=123456           # Password for kibana_system user

# Version configuration
STACK_VERSION=8.13.4             # Elastic Stack version

# Cluster settings
CLUSTER_NAME=docker-cluster      # Elasticsearch cluster name
LICENSE=basic                    # License type (basic/trial)

# Port configuration
ES_PORT=9200                     # Elasticsearch HTTP port
KIBANA_PORT=5601                 # Kibana web interface port
LOGSTASH_PORT=5044               # Logstash beats input port

# Memory limits (in bytes)
ES_MEM_LIMIT=1073741824          # Elasticsearch memory limit (1GB)
KB_MEM_LIMIT=1073741824          # Kibana memory limit (1GB)
LS_MEM_LIMIT=1073741824          # Logstash memory limit (1GB)

# Security encryption key
ENCRYPTION_KEY=c34d38b3a14956121ff2170e5030b471551370178f43e5626eec58b04a30fae2
```

### Beats Configuration

#### Filebeat Configuration

- **Config File**: `filebeat/filebeat.yml`
- **Data Directory**: `temp/filebeat/data`
- **Ingest Data**: `filebeat/ingest-data/`

#### Metricbeat Configuration

- **Config File**: `metricbeat/metricbeat.yml`
- **Data Directory**: `temp/metricbeat/data`
- **System Monitoring**: CPU, Memory, Network, Docker containers

#### Logstash Configuration

- **Config File**: `logstash/logstash.conf`
- **Data Directory**: `temp/logstash/data`
- **Ingest Data**: `logstash/ingest-data/`

## Quick Start

### 1. Start Services

```bash
# Navigate to the project directory
cd docker-compose/elk-cluster

# Start all services
./bin/up.sh
```

### 2. Access Kibana

1. Open browser and navigate to: <http://localhost:5601>
2. Login with credentials:
   - Username: `elastic`
   - Password: `123456`

### 3. Verify Elasticsearch

```bash
# Check cluster health (with SSL)
curl -k -u elastic:123456 https://localhost:9200/_cluster/health

# List all indices
curl -k -u elastic:123456 https://localhost:9200/_cat/indices?v
```

### 4. Test Log Ingestion

```bash
# Send a test log to Logstash
echo '{"message": "Test log entry", "timestamp": "'$(date -Iseconds)'"}' | \
nc localhost 5044
```

## Data Persistence

Data is persisted in the following directories:

```bash
temp/
├── certs/                       # SSL certificates
├── elasticsearch/
│   ├── data/                    # Elasticsearch data
│   ├── logs/                    # Elasticsearch logs
│   └── plugins/                 # Elasticsearch plugins
├── kibana/
│   └── data/                    # Kibana data
├── logstash/
│   └── data/                    # Logstash data
├── metricbeat/
│   └── data/                    # Metricbeat data
└── filebeat/
    └── data/                    # Filebeat data
```

## Security Features

- **SSL/TLS Encryption**: Enabled for Elasticsearch communication
- **Authentication**: Built-in user management with elastic and kibana_system users
- **Certificate Management**: Automatic SSL certificate generation and management
- **Secure Communication**: All inter-service communication is encrypted

## Monitoring and Logging

### System Metrics (Metricbeat)

- Docker container metrics
- Host system metrics (CPU, Memory, Network)
- Elasticsearch cluster metrics

### Log Collection (Filebeat)

- Docker container logs
- System logs
- Application logs

### Log Processing (Logstash)

- Real-time log processing
- Data transformation and enrichment
- Multiple input/output plugins support

## Example Usage

### Python Application Integration

```python
import logging
from pythonjsonlogger import jsonlogger

# Configure JSON logging for Logstash
def setup_logging():
    logger = logging.getLogger()
    handler = logging.StreamHandler()
    formatter = jsonlogger.JsonFormatter(
        fmt='%(asctime)s %(name)s %(levelname)s %(message)s'
    )
    handler.setFormatter(formatter)
    logger.addHandler(handler)
    logger.setLevel(logging.INFO)
    return logger

# Usage example
logger = setup_logging()
logger.info("Application started", extra={"service": "my-app", "version": "1.0"})
```

### Node.js Application Integration

```javascript
const winston = require('winston');

// Configure Winston for Logstash
const logger = winston.createLogger({
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.Console(),
    new winston.transports.Http({
      host: 'localhost',
      port: 5044,
      path: '/'
    })
  ]
});

// Usage example
logger.info('Application event', {
  service: 'node-app',
  userId: '12345',
  action: 'user_login'
});
```

### Java Application Integration

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import net.logstash.logback.encoder.LogstashEncoder;

public class Application {
    private static final Logger logger = LoggerFactory.getLogger(Application.class);
    
    public static void main(String[] args) {
        // Configure logback-spring.xml for Logstash appender
        logger.info("Application started with user: {}", "admin");
    }
}
```

## Troubleshooting

### Common Issues

1. **Memory Issues**: Increase memory limits in .env file
2. **SSL Certificate Errors**: Ensure setup service completes successfully
3. **Port Conflicts**: Check if ports 9200, 5601, 5044 are available
4. **Permission Issues**: Ensure proper file permissions for mounted volumes

### Check Service Status

```bash
# Check all services status
docker-compose ps

# Check specific service logs
docker-compose logs elasticsearch
docker-compose logs kibana
docker-compose logs logstash
```

### Reset Data

```bash
# Stop services and remove data
./bin/down.sh
sudo rm -rf temp/
./bin/up.sh
```

## Advanced Configuration

### Custom Index Templates

```bash
# Create custom index template
curl -k -u elastic:123456 -X PUT "https://localhost:9200/_index_template/my-template" \
-H "Content-Type: application/json" -d '
{
  "index_patterns": ["my-logs-*"],
  "template": {
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  }
}'
```

### Custom Dashboards

1. Access Kibana at <http://localhost:5601>
2. Navigate to **Stack Management** > **Saved Objects**
3. Import custom dashboard configurations
4. Create visualizations and dashboards

## Performance Tuning

### Elasticsearch Optimization

```bash
# Adjust heap size (50% of available RAM, max 32GB)
ES_JAVA_OPTS="-Xms2g -Xmx2g"

# Optimize for SSD
index.store.type: niofs

# Adjust refresh interval for high-throughput scenarios
index.refresh_interval: 30s
```

### Logstash Pipeline Tuning

```ruby
# Increase pipeline workers
pipeline.workers: 4
pipeline.batch.size: 1000
pipeline.batch.delay: 50
```

## Stop Services

```bash
# Stop all services
./bin/down.sh
```

## Notes

- **First Startup**: Initial startup may take several minutes for SSL certificate generation
- **Memory Requirements**: Recommended minimum 4GB RAM for optimal performance
- **Security**: Change default passwords in production environments
- **Monitoring**: Use Kibana's built-in monitoring features for cluster health
- **Backup**: Implement regular backup strategies for Elasticsearch data
