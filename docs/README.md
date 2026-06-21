# Container Environments

A collection of production-ready Docker Compose configurations for rapidly setting up development environments. Each environment follows a standardized structure with consistent start/stop scripts.

## Quick Start

```bash
# Start any environment (e.g., MongoDB single-node)
cd docker-compose/mongodb-single
./bin/up.sh

# Stop it when done
./bin/down.sh
```

## Available Environments

### Database Systems

| Environment                              | Type                       | Image                        | Port        | Web UI |
| ---------------------------------------- | -------------------------- | ---------------------------- | ----------- | ------ |
| [PostGIS](docker-compose/postgis-single) | Single / Cluster (3 nodes) | `mdillon/postgis:9.6-alpine` | 5432–5434   | —      |
| [MongoDB](docker-compose/mongodb-single) | Single / Multi (3 nodes)   | `mongo:4.0-xenial`           | 27017–27019 | —      |

### Message Queues

| Environment                                | Type                                 | Image                       | Port                   | Web UI                        |
| ------------------------------------------ | ------------------------------------ | --------------------------- | ---------------------- | ----------------------------- |
| [Kafka](docker-compose/kafka-single)       | Single / Cluster (3 nodes, KRaft)    | `apache/kafka:3.9.1`        | 9092–9097              | Kafka UI @ `:9080`            |
| [RabbitMQ](docker-compose/rabbitmq-single) | Single / Cluster (3 nodes + HAProxy) | `rabbitmq:4.1.2-management` | 5672–5675, 15672–15675 | Management UI + HAProxy Stats |

### Search Engines & Observability

| Environment                                          | Type                                                     | Image                                                        | Port             | Web UI           |
| ---------------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------ | ---------------- | ---------------- |
| [Elasticsearch](docker-compose/elasticsearch-single) | Single / Cluster (3 nodes)                               | `elasticsearch:8.13.4`                                       | 9200             | Kibana @ `:5601` |
| [ELK Stack](docker-compose/elk-cluster)              | Cluster (ES + Logstash + Kibana + Filebeat + Metricbeat) | `elasticsearch:8.13.4` / `logstash:8.13.4` / `kibana:8.13.4` | 9200, 5601, 5044 | Kibana @ `:5601` |

### Storage Solutions

| Environment                          | Type   | Image                            | Port                       | Web UI            |
| ------------------------------------ | ------ | -------------------------------- | -------------------------- | ----------------- |
| [MinIO](docker-compose/minio-single) | Single | `minio/minio:RELEASE.2025-05-24` | 9000 (API), 9001 (Console) | Console @ `:9001` |

### CI/CD & Repository Management

| Environment                                  | Type               | Image                        | Port        | Web UI  |
| -------------------------------------------- | ------------------ | ---------------------------- | ----------- | ------- |
| [Jenkins](docker-compose/jenkins-single)     | Single (BlueOcean) | `jenkinsci/blueocean:1.25.7` | 8080, 50000 | `:8080` |
| [Nexus](docker-compose/nexus-single)         | Single             | `sonatype/nexus3:3.66.0`     | 8081        | `:8081` |
| [Verdaccio](docker-compose/verdaccio-single) | Single             | `verdaccio/verdaccio:6.1.5`  | 4873        | `:4873` |

### Geospatial

| Environment                                  | Type   | Image                         | Port | Web UI            |
| -------------------------------------------- | ------ | ----------------------------- | ---- | ----------------- |
| [GeoServer](docker-compose/geoserver-single) | Single | `oscarfonts/geoserver:2.27.1` | 8080 | `:8080/geoserver` |

### Service Discovery

| Environment                                  | Type                       | Image           | Port      | Web UI                 |
| -------------------------------------------- | -------------------------- | --------------- | --------- | ---------------------- |
| [ZooKeeper](docker-compose/zookeeper-single) | Single / Cluster (3 nodes) | `zookeeper:3.5` | 2181–2183 | ZooNavigator @ `:9000` |

### AI / Machine Learning

| Environment                                                     | Type                  | Image                                        | Port | Web UI  |
| --------------------------------------------------------------- | --------------------- | -------------------------------------------- | ---- | ------- |
| [Stable Diffusion WebUI](docker-compose/stable-diffusion-webui) | Single (GPU required) | `universonic/stable-diffusion-webui:minimal` | 8080 | `:8080` |

## Directory Structure

Every environment follows the same layout:

```bash
environment-name/
├── README.md          # Environment-specific documentation
├── bin/
│   ├── up.sh          # Start script (docker compose up -d)
│   └── down.sh        # Stop script  (docker compose down)
└── compose/
    └── docker-compose.yml  # Docker Compose configuration
```

## Conventions

- **Credentials** — Default username: `hz_9`, default password: `123456`
- **Data Volumes** — Persistent data is stored in a `temp/` directory under each environment folder (except for configuration files that must reside in the project directory)
- **Project Names** — Each Compose project uses the environment directory name as its `-p` project name

## Requirements

- Docker Engine (with Compose plugin)

## License

MIT — see the [LICENSE](LICENSE) file for details.

# Container Environments

A collection of Docker Compose configurations for quickly setting up development environments.

## Overview

This project provides ready-to-use Docker Compose configurations for various popular services and applications commonly used in development environments. Each configuration is designed to be simple to use with standardized start and stop scripts.

## Available Environments

The following container environments are available:

### Database Systems

- **MongoDB** (Single node and multi-node configurations)
- **PostGIS** (Single node and multi-node configurations)

### Message Queues

- **Kafka** (Single node and cluster configurations)
- **RabbitMQ** (Single node and cluster configurations)

### Search Engines

- **Elasticsearch** (Single node and cluster configurations)
- **ELK Stack** (Elasticsearch, Logstash, Kibana cluster with Filebeat and Metricbeat)

### Storage Solutions

- **MinIO** (Single node configuration)

### CI/CD & Repository Management

- **Jenkins** (Single node configuration)
- **Nexus** (Single node configuration)
- **Verdaccio** (Single node configuration - NPM registry)

### Geospatial

- **GeoServer** (Single node configuration)

### Service Discovery

- **ZooKeeper** (Single node and cluster configurations)

## Usage

Each environment is contained in its own directory with the following structure:

```bash
environment-name/
├── README.md          # Specific documentation for this environment
├── bin/
│   ├── up.sh          # Script to start the environment
│   └── down.sh        # Script to stop the environment
└── compose/
    └── docker-compose.yml  # Docker Compose configuration
```

### Starting an Environment

To start an environment, navigate to the environment directory and run the up script:

```bash
cd docker-compose/environment-name
./bin/up.sh
```

### Stopping an Environment

To stop an environment, navigate to the environment directory and run the down script:

```bash
cd docker-compose/environment-name
./bin/down.sh
```

## Requirements

- Docker Engine
- Docker Compose

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
