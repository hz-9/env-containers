#!/bin/bash

# MongoDB Multi-Container Shutdown Script
# Stop MongoDB multi-instance containers

set -e

# Get project root directory
root=$(cd `dirname $0`; dirname `pwd`)

echo "Stopping MongoDB Multi-Container services..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p mongodb-multi -f "${root}/compose/docker-compose.yml" down --rmi local

echo "MongoDB Multi-Container services stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
