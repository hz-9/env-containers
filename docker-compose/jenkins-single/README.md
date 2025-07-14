# Docker Compose Jenkins Single-Container

## Overview

Jenkins single-instance containerized deployment solution, providing a Jenkins CI/CD instance for continuous integration and continuous deployment.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| jenkins | jenkins | 8080:8080, 50000:50000 | all.jenkins | CI/CD service |

## Access Information

### Web Interface

```bash
# Jenkins Web Interface
http://127.0.0.1:8080
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
http://all.jenkins:8080
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p jenkins-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p jenkins-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p jenkins-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── home/             # Jenkins home directory
├── docker.sock       # Docker socket
└── key/              # SSH keys
```

## Environment Configuration

### Application Configuration

- **Image Version**: jenkinsci/blueocean:1.25.7
- **User**: root
- **Platform**: linux/amd64
- **Web Port**: 8080
- **Agent Port**: 50000

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Initial Setup

### Get Initial Password

```bash
# View container logs to get initial password
docker logs jenkins

# Or directly view password file
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### Recommended Plugins

Recommended plugins to install:
- Git
- Docker Pipeline
- Blue Ocean
- Build Timeout
- Timestamper

## Use Cases

1. **CI/CD**: Continuous integration and continuous deployment
2. **Automated Testing**: Automatically run test suites
3. **Code Building**: Automated code building
4. **Deployment Pipeline**: Automated deployment workflows

## Important Notes

1. Ensure ports 8080 and 50000 are not occupied
2. Ensure sufficient disk space for build cache
3. Initial startup requires setup completion through web interface
4. Recommend regular backup of Jenkins configuration and data
5. Runs as root user to support Docker operations
