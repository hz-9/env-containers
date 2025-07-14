#!/bin/bash

# ZooKeeper Single-Container Shutdown Script
# Stop ZooKeeper single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping ZooKeeper Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p zookeeper-single -f "${root}/compose/docker-compose.yml" down --rmi local

echo "ZooKeeper Single-Container service stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
