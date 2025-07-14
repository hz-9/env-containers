#!/bin/bash

# PostGIS Multi-Container Startup Script
# Start PostGIS multi-instance containers

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting PostGIS Multi-Container services..."
echo "Project root: ${root}"

# Start services
docker compose -p postgis-multi -f "${root}/compose/docker-compose.yml" up -d

echo "PostGIS Multi-Container services started successfully!"
echo ""
echo "Connection URLs:"
echo "  Instance 1: postgresql://hz_9:123456@127.0.0.1:5432/hz_9"
echo "  Instance 2: postgresql://hz_9:123456@127.0.0.1:5433/hz_9"
echo "  Instance 3: postgresql://hz_9:123456@127.0.0.1:5434/hz_9"
echo ""
echo "Check status: docker compose -p postgis-multi ps"
