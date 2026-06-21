# Docker Compose Container Orchestration Specifications

Detailed image versions, port mappings, and conventions used across all environments.

## Environment Catalog

### Database Systems

| Environment    | Image                        | Port(s)             | Web UI | Type              |
| -------------- | ---------------------------- | ------------------- | ------ | ----------------- |
| postgis-single | `mdillon/postgis:9.6-alpine` | 5432                | —      | Single            |
| postgis-multi  | `mdillon/postgis:9.6-alpine` | 5432, 5433, 5434    | —      | Cluster (3 nodes) |
| mongodb-single | `mongo:4.0-xenial`           | 27017               | —      | Single            |
| mongodb-multi  | `mongo:4.0-xenial`           | 27017, 27018, 27019 | —      | Cluster (3 nodes) |

### Message Queues

| Environment      | Image                       | Port(s)                             | Web UI                                             | Type                        |
| ---------------- | --------------------------- | ----------------------------------- | -------------------------------------------------- | --------------------------- |
| kafka-single     | `apache/kafka:3.9.1`        | 9092, 9093                          | Kafka UI @ `:9080`                                 | Single (KRaft)              |
| kafka-cluster    | `apache/kafka:3.9.1`        | 9092–9097                           | Kafka UI @ `:9080`                                 | Cluster (3 nodes, KRaft)    |
| rabbitmq-single  | `rabbitmq:4.1.2-management` | 5672, 15672, 15692                  | Management UI @ `:15672`                           | Single                      |
| rabbitmq-cluster | `rabbitmq:4.1.2-management` | 5672–5675, 15672–15675, 25672–25674 | Management UI (per node) + HAProxy Stats @ `:8404` | Cluster (3 nodes + HAProxy) |

### Search Engines & Observability

| Environment           | Image                                                                                                  | Port(s)          | Web UI           | Type                       |
| --------------------- | ------------------------------------------------------------------------------------------------------ | ---------------- | ---------------- | -------------------------- |
| elasticsearch-single  | `elasticsearch:8.13.4` + `kibana:8.13.4`                                                               | 9200             | Kibana @ `:5601` | Single + Kibana            |
| elasticsearch-cluster | `elasticsearch:8.13.4` + `kibana:8.13.4`                                                               | 9200             | Kibana @ `:5601` | Cluster (3 nodes) + Kibana |
| elk-cluster           | `elasticsearch:8.13.4` + `kibana:8.13.4` + `logstash:8.13.4` + `filebeat:8.13.4` + `metricbeat:8.13.4` | 9200, 5601, 5044 | Kibana @ `:5601` | Full ELK Stack + Beats     |

> **Credentials**: `elastic` / `123456` (all Elastic environments). HTTPS enabled with auto-generated certificates.

### Storage Solutions

| Environment  | Image                                      | Port(s)                    | Web UI            | Type   |
| ------------ | ------------------------------------------ | -------------------------- | ----------------- | ------ |
| minio-single | `minio/minio:RELEASE.2025-05-24T17-08-30Z` | 9000 (API), 9001 (Console) | Console @ `:9001` | Single |

> **Credentials**: `hz_9` / `12345678`

### CI/CD & Repository Management

| Environment      | Image                        | Port(s)     | Web UI  | Type                                      |
| ---------------- | ---------------------------- | ----------- | ------- | ----------------------------------------- |
| jenkins-single   | `jenkinsci/blueocean:1.25.7` | 8080, 50000 | `:8080` | Single (root user, Docker socket mounted) |
| nexus-single     | `sonatype/nexus3:3.66.0`     | 8081        | `:8081` | Single (root user)                        |
| verdaccio-single | `verdaccio/verdaccio:6.1.5`  | 4873        | `:4873` | Single                                    |

> **Initial password** for Nexus can be retrieved via `docker exec nexus cat /nexus-data/admin.password`.

### Geospatial

| Environment      | Image                         | Port(s) | Web UI            | Type   |
| ---------------- | ----------------------------- | ------- | ----------------- | ------ |
| geoserver-single | `oscarfonts/geoserver:2.27.1` | 8080    | `:8080/geoserver` | Single |

> **Credentials**: `admin` / `geoserver`

### Service Discovery

| Environment       | Image           | Port(s)          | Web UI                 | Type                             |
| ----------------- | --------------- | ---------------- | ---------------------- | -------------------------------- |
| zookeeper-single  | `zookeeper:3.5` | 2181             | ZooNavigator @ `:9000` | Single + ZooNavigator            |
| zookeeper-cluster | `zookeeper:3.5` | 2181, 2182, 2183 | ZooNavigator @ `:9000` | Cluster (3 nodes) + ZooNavigator |

> ZooNavigator connection string (cluster): `zoo1:2181,zoo2:2181,zoo3:2181`

### AI / Machine Learning

| Environment            | Image                                        | Port(s) | Web UI  | Type                                           |
| ---------------------- | -------------------------------------------- | ------- | ------- | ---------------------------------------------- |
| stable-diffusion-webui | `universonic/stable-diffusion-webui:minimal` | 8080    | `:8080` | Single (requires NVIDIA GPU, `nvidia` runtime) |

## Data Volumes Convention

All environments store persistent data in a `temp/` directory under the respective environment folder. The only exception is configuration files that must be mounted directly from the project directory.

```
docker-compose/<environment>/
├── temp/          ← Persistent data (created at runtime)
│   ├── data/      ← Database / service data files
│   ├── logs/      ← Service log files
│   └── plugins/   ← Extension / plugin files (e.g., GeoServer extensions)
├── compose/
│   └── docker-compose.yml
└── bin/
    ├── up.sh
    └── down.sh
```

## Default Credentials

Unless otherwise noted, the following credentials apply:

| Service             | Username  | Password    |
| ------------------- | --------- | ----------- |
| General convention  | `hz_9`    | `123456`    |
| Elastic (Kibana)    | `elastic` | `123456`    |
| MinIO Console       | `hz_9`    | `12345678`  |
| RabbitMQ Management | `hz_9`    | `123456`    |
| GeoServer           | `admin`   | `geoserver` |
| HAProxy Stats       | `admin`   | `123456`    |

## Environment Configuration

Elastic-stack environments (`elasticsearch-single`, `elasticsearch-cluster`, `elk-cluster`) use a shared `.env` pattern:

| Variable                                         | Value            | Description                     |
| ------------------------------------------------ | ---------------- | ------------------------------- |
| `STACK_VERSION`                                  | `8.13.4`         | Elastic Stack version           |
| `ELASTIC_PASSWORD`                               | `123456`         | Elasticsearch password          |
| `KIBANA_PASSWORD`                                | `123456`         | Kibana system user password     |
| `CLUSTER_NAME`                                   | `docker-cluster` | Cluster name                    |
| `LICENSE`                                        | `basic`          | License level                   |
| `ES_MEM_LIMIT` / `KB_MEM_LIMIT` / `LS_MEM_LIMIT` | `1073741824`     | Memory limit (1 GB) per service |

# Docker Compose Container Orchestration Example Specifications

## Container Examples

- postgis(mdillon/postgis:9.6-alpine) multi-instance
- postgis(mdillon/postgis:9.6-alpine) multi-instance
- mongo(mongo:4.0-xenial) multi-instance
- mongo(mongo:4.0-xenial) single instance
- jenkins(jenkinsci/blueocean:1.25.7) single instance
- nexus(sonatype/nexus3:3.66.0) single instance
- verdaccio(verdaccio/verdaccio:6.1.5) single instance
- geoserver(oscarfonts/geoserver:2.27.1) single instance
- zookeeper(zookeeper:3.5) cluster + visualization
- zookeeper(zookeeper:3.5) single instance + visualization
- kafka(apache/kafka:3.9.1) cluster + visualization
- kafka(apache/kafka:3.9.1) single instance + visualization
- elasticsearch(docker.elastic.co/elasticsearch/elasticsearch:8.13.4+docker.elastic.co/kibana/kibana:8.13.4) cluster + visualization
- elasticsearch(docker.elastic.co/elasticsearch/elasticsearch:8.13.4+docker.elastic.co/kibana/kibana:8.13.4) single instance + visualization
- rabbit(rabbitmq:4.1.2) cluster + visualization
- rabbit(rabbitmq:4.1.2) single instance + visualization
- ELK cluster + visualization
- Minio(minio/minio:RELEASE.2025-05-24T17-08-30Z) single instance
- stable-diffusion-webui(universonic/stable-diffusion-webui:minimal) single instance + web interface

## Data Volumes

Except for configuration content that needs to be loaded in the current directory, all data volumes need to create a `temp` directory under the corresponding folder.

## Environment Variables

Default database and username can both use `hz_9`.
Default password can use `123456`.
