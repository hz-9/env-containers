#!/bin/bash

# PostGIS Single-Container Startup Script
# Start PostGIS single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting PostGIS Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p postgis-single -f "${root}/compose/docker-compose.yml" up -d

echo "PostGIS Single-Container service started successfully!"
echo ""
echo "Connection URL:"
echo "  Instance: postgresql://hz_9:123456@127.0.0.1:5432/hz_9"
echo ""
echo "Check status: docker compose -p postgis-single ps"
