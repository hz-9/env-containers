#!/bin/bash

# PostGIS Multi-Container Shutdown Script
# Stop PostGIS multi-instance containers

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping PostGIS Multi-Container services..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p postgis-multi -f "${root}/compose/docker-compose.yml" down --rmi local

echo "PostGIS Multi-Container services stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
