#!/bin/bash

# GeoServer Single-Container Shutdown Script
# Stop GeoServer single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping GeoServer Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p geoserver-single -f "${root}/compose/docker-compose.yml" down --rmi local

echo "GeoServer Single-Container service stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
