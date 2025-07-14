# Docker Compose Verdaccio Single-Container

## Overview

Verdaccio NPM private registry single-instance containerized deployment solution, providing enterprise-grade NPM package management service, supporting proxy, caching, and private package publishing.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| verdaccio | verdaccio-server | 4873:4873 | all.verdaccio | NPM private registry |

## Access Information

### Web Interface

```bash
# Verdaccio Web Interface
http://localhost:4873
```

### NPM Configuration

```bash
# Set npm registry URL
npm config set registry http://localhost:4873

# Or set specific scope
npm config set @your-scope:registry http://localhost:4873

# Set nrm 
nrm add verdaccio http://localhost:4873
nrm use verdaccio
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
all.verdaccio:4873
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p verdaccio-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p verdaccio-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p verdaccio-single -f compose/docker-compose.yml ps
```

## Data Persistence

Data is stored in host directories:

```text
temp/
├── storage/      # NPM package storage
└── plugins/      # Plugin directory
```

## Environment Configuration

### Application Configuration

- **Image Version**: verdaccio/verdaccio:6.1.5
- **Default User**: hz_9
- **Default Password**: 123456
- **Upstream Registry**: npm, taobao

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

## NPM Usage Guide

### User Management

```bash
# Create user
npm adduser --registry http://localhost:4873

# Login user
npm login --registry http://localhost:4873

# Check current user
npm whoami --registry http://localhost:4873
```

### Package Management

```bash
# Publish package
npm publish --registry http://localhost:4873

# Install package
npm install package-name --registry http://localhost:4873

# Search package
npm search package-name --registry http://localhost:4873
```

### Scope Configuration

```bash
# Set organization scope
npm config set @myorg:registry http://localhost:4873

# Publish scoped package
npm publish --access public
```

## Configuration

### Configuration File

Configuration file located at `config/config.yaml`, includes:

- **Storage Configuration**: Package storage path
- **Authentication Configuration**: User authentication method
- **Upstream Registry**: npm, taobao mirror configuration
- **Package Permissions**: Publish and access permissions
- **Web Interface**: Enable status and title

### Upstream Registries

- **npmjs**: https://registry.npmjs.org/
- **taobao**: https://registry.npmmirror.com/

## Use Cases

1. **Enterprise Private Packages**: Internal component library management
2. **Proxy Caching**: Accelerate npm package downloads
3. **Offline Environment**: Intranet npm service
4. **Version Control**: Specific version package management
5. **Development Environment**: Local package testing

## Important Notes

1. Ensure port 4873 is not occupied
2. First startup requires creating admin user
3. Service restart required after configuration file changes
4. HTTPS recommended for production environments
5. Regularly backup storage directory
6. Monitor disk space usage
