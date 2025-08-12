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
