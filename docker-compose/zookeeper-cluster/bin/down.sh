#!/bin/bash

# ZooKeeper Multi-Container Shutdown Script
# Stop ZooKeeper cluster containers

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping ZooKeeper Multi-Container services..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p zookeeper-cluster -f "${root}/compose/docker-compose.yml" down --rmi local

echo "ZooKeeper Multi-Container services stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
