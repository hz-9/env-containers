#!/bin/bash

# PostGIS Single-Container Shutdown Script
# Stop PostGIS single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping PostGIS Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p postgis-single -f "${root}/compose/docker-compose.yml" down --rmi local

echo "PostGIS Single-Container service stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
