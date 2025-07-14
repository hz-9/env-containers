# Docker Compose Elasticsearch Single-Container

## Overview

Elasticsearch single-instance containerized deployment solution, providing full-text search and analytics engine services, including Kibana visualization interface.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| elasticsearch | elasticsearch-single | 9200:9200, 9300:9300 | all.elasticsearch | Elasticsearch search engine |
| kibana | kibana-single | 5601:5601 | all.kibana | Kibana visualization interface |

## Access Information

### Elasticsearch API

```bash
# Elasticsearch REST API
http://localhost:9200
```

### Kibana Web Interface

```bash
# Kibana visualization interface
http://localhost:5601
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.elasticsearch:9200
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p elasticsearch-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p elasticsearch-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p elasticsearch-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── data/         # Elasticsearch data directory
├── logs/         # Elasticsearch log directory
└── kibana/       # Kibana data directory
```

## Environment Configuration

### Application Configuration

- **Elasticsearch**: docker.elastic.co/elasticsearch/elasticsearch:8.13.4
- **Kibana**: docker.elastic.co/kibana/kibana:8.13.4
- **Cluster Mode**: Single node mode
- **Security Configuration**: Disabled (for development convenience)
- **Default User**: elastic
- **Default Password**: 123456

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

### Port Configuration

- **HTTP Port**: 9200
- **Transport Port**: 9300
- **Kibana Port**: 5601

## Usage Guide

### Basic API Operations

#### Health Check

```bash
# Cluster health status
curl http://localhost:9200/_cluster/health

# Node information
curl http://localhost:9200/_cat/nodes?v

# Index list
curl http://localhost:9200/_cat/indices?v
```

#### Index Operations

```bash
# Create index
curl -X PUT http://localhost:9200/my_index

# View index settings
curl http://localhost:9200/my_index/_settings

# Delete index
curl -X DELETE http://localhost:9200/my_index
```

#### Document Operations

```bash
# Add document
curl -X POST http://localhost:9200/my_index/_doc/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Hello World", "content": "This is a test document"}'

# Get document
curl http://localhost:9200/my_index/_doc/1

# Search documents
curl -X GET http://localhost:9200/my_index/_search \
  -H "Content-Type: application/json" \
  -d '{"query": {"match": {"title": "Hello"}}}'
```

### Programming Language Clients

#### Python (elasticsearch-py)

```python
from elasticsearch import Elasticsearch

# Create connection
es = Elasticsearch([{'host': 'localhost', 'port': 9200}])

# Create index
es.indices.create(index='my_index', ignore=400)

# Add document
doc = {
    'title': 'Hello World',
    'content': 'This is a test document',
    'timestamp': '2024-01-01T00:00:00'
}
es.index(index='my_index', id=1, body=doc)

# Search documents
res = es.search(index='my_index', body={'query': {'match': {'title': 'Hello'}}})
print(res['hits']['hits'])
```

#### Node.js (@elastic/elasticsearch)

```javascript
const { Client } = require('@elastic/elasticsearch');

// Create connection
const client = new Client({ node: 'http://localhost:9200' });

async function run() {
  // Create index
  await client.indices.create({ index: 'my_index' }, { ignore: [400] });
  
  // Add document
  await client.index({
    index: 'my_index',
    id: 1,
    body: {
      title: 'Hello World',
      content: 'This is a test document'
    }
  });
  
  // Search documents
  const response = await client.search({
    index: 'my_index',
    body: {
      query: {
        match: { title: 'Hello' }
      }
    }
  });
  
  console.log(response.body.hits.hits);
}

run().catch(console.log);
```

#### Java (Elasticsearch Java Client)

```java
import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.ElasticsearchTransport;
import co.elastic.clients.transport.rest_client.RestClientTransport;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;

// Create connection
RestClient restClient = RestClient.builder(
    new HttpHost("localhost", 9200)).build();

ElasticsearchTransport transport = new RestClientTransport(
    restClient, new JacksonJsonpMapper());

ElasticsearchClient client = new ElasticsearchClient(transport);

// Create index
client.indices().create(c -> c.index("my_index"));

// Add document
MyDocument doc = new MyDocument("Hello World", "This is a test document");
client.index(i -> i.index("my_index").id("1").document(doc));

// Search documents
SearchResponse<MyDocument> response = client.search(s -> s
    .index("my_index")
    .query(q -> q
        .match(t -> t
            .field("title")
            .query("Hello")
        )
    ), MyDocument.class);
```

### Kibana Usage Guide

#### Data Exploration

1. **Access Kibana**: <http://localhost:5601>
2. **Create Index Pattern**: Management → Index Patterns
3. **Data Discovery**: Discover page
4. **Visualization**: Visualize page
5. **Dashboard**: Dashboard page

#### Dev Tools Console

```json
# Execute in Kibana Dev Tools
GET /_cluster/health

POST /my_index/_doc/1
{
  "title": "Hello Kibana",
  "content": "This is created from Kibana"
}

GET /my_index/_search
{
  "query": {
    "match_all": {}
  }
}
```

## Performance Tuning

### JVM Settings

Default setting `-Xms1g -Xmx1g`, recommended adjustment for production:

```yaml
environment:
  - "ES_JAVA_OPTS=-Xms4g -Xmx4g"
```

### System Settings

```bash
# Increase virtual memory limit
sudo sysctl -w vm.max_map_count=262144

# Permanent setting
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf
```

## Use Cases

1. **Full-text Search**: Document and content search
2. **Log Analysis**: Application log analysis
3. **Data Analytics**: Business data analysis
4. **Monitoring Metrics**: System monitoring data storage
5. **Recommendation System**: Search recommendation engine

## Important Notes

1. Ensure ports 9200, 9300, 5601 are not occupied
2. Single node mode does not provide high availability
3. Cluster deployment recommended for production environments
4. Pay attention to setting appropriate JVM memory size
5. Regularly backup important index data
6. Monitor disk space usage
7. Enable security features for production environments
