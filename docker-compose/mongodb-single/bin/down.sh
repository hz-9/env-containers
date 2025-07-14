#!/bin/bash

# MongoDB Single-Container Shutdown Script
# Stop MongoDB single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping MongoDB Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p mongodb-single -f "${root}/compose/docker-compose.yml" down --rmi local

echo "MongoDB Single-Container service stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
