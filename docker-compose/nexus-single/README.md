# Docker Compose Nexus Single-Container

## Overview

Nexus Repository Manager single-instance containerized deployment solution, providing a Nexus repository management instance for managing software packages and artifacts.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| nexus | nexus | 8081:8081 | all.nexus | Repository management |

## Access Information

### Web Interface

```bash
# Nexus Web Interface
http://127.0.0.1:8081
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
http://all.nexus:8081
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p nexus-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p nexus-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p nexus-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
└── data/    # Nexus data directory
```

## Environment Configuration

### Application Configuration

- **Image Version**: sonatype/nexus3:3.66.0
- **User**: root
- **Platform**: linux/amd64
- **Web Port**: 8081

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## Initial Setup

### Get Initial Password

```bash
# View initial password file
docker exec nexus cat /nexus-data/admin.password
```

### Default Credentials

- **Username**: admin
- **Password**: Retrieved via above command

## Repository Configuration

### Supported Repository Types

- **Maven**: Java project dependency management
- **NPM**: Node.js package management
- **Docker**: Docker image repository
- **PyPI**: Python package management
- **NuGet**: .NET package management

### Common Repository Configuration

```bash
# Maven Central Proxy
Name: maven-central
Remote storage: https://repo1.maven.org/maven2/

# NPM Proxy
Name: npm-proxy
Remote storage: https://registry.npmjs.org
```

## Use Cases

1. **Dependency Management**: Managing project dependencies
2. **Private Repository**: Storing enterprise internal artifacts
3. **Proxy Repository**: Proxying public repositories to improve download speed
4. **Version Management**: Managing different versions of software packages

## Important Notes

1. Ensure port 8081 is not occupied
2. First startup requires several minutes for initialization
3. Ensure sufficient disk space for repository data storage
4. Recommend regular backup of Nexus data
5. Recommend configuring HTTPS for production environments
6. Memory limits can be adjusted as needed
