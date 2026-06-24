# Docker Compose RSSHub Single-Container

## Overview

RSSHub single-instance containerized deployment solution, providing a universal RSS feed generation service for simple development and testing environments.

## Service List

| Service Name | Container Name | Port Mapping | Network Alias | Purpose |
|--------------|----------------|--------------|---------------|---------|
| rsshub | rsshub | 1200:1200 | all.rsshub | Single instance |

## Access Information

### Access URLs

```bash
# RSSHub Service
http://localhost:1200

# Health Check
http://localhost:1200/healthz
```

### Network Internal Connection (Inter-container Communication)

```bash
# Connect via network alias
http://all.rsshub:1200
http://all.rsshub:1200/healthz
```

## Quick Start

### Start Services

```bash
# Start using script
./bin/up.sh

# Or use docker compose directly
docker compose -p rsshub-single -f compose/docker-compose.yml up -d
```

### Stop Services

```bash
# Stop using script
./bin/down.sh

# Or use docker compose directly
docker compose -p rsshub-single -f compose/docker-compose.yml down
```

### Check Status

```bash
docker compose -p rsshub-single -f compose/docker-compose.yml ps
```

## Environment Configuration

### Network Configuration

- **Network Name**: all
- **Network Type**: bridge
- **Inter-container Communication**: Supported

### RSSHub Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| NODE_ENV | production | Node.js environment |
| PORT | 1200 | Service listening port |
| CACHE_TYPE | memory | Cache type (memory/redis) |
| CACHE_EXPIRE | 600 | Cache TTL in seconds |
| NODE_NAME | rsshub | Node name identifier |
| LOGGER_LEVEL | info | Log level |
| NO_LOGFILES | true | Disable log files |

## Use Cases

1. **Self-hosted RSS Service**: Generate RSS feeds for websites without native RSS support
2. **Folo Integration**: Pair with Folo AI RSS Reader for modern reading workflows
3. **Development Environment**: Local RSS feed generation testing
4. **Content Aggregation**: Consolidate content from multiple sources

## Important Notes

1. Ensure port 1200 is not occupied before starting
2. Memory cache is used by default; add Redis for production deployments
3. For browser-rendered routes, consider adding Browserless/Chrome service
4. Set `ACCESS_KEY` environment variable to enable access key authentication for production
