#!/bin/bash

# Nexus Single-Container Shutdown Script
# Stop Nexus single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Nexus Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p nexus-single -f "${root}/compose/docker-compose.yml" down --rmi local

echo "Nexus Single-Container service stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
