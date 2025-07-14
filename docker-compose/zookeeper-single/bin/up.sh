#!/bin/bash

# ZooKeeper Single-Container Startup Script
# Start ZooKeeper single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting ZooKeeper Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p zookeeper-single -f "${root}/compose/docker-compose.yml" up -d

echo "ZooKeeper Single-Container service started successfully!"
echo ""
echo "Access URLs:"
echo "  ZooKeeper: 127.0.0.1:2181"
echo "  ZooNavigator Web: http://127.0.0.1:9000"
echo ""
echo "ZooNavigator Connection:"
echo "  Connection String: zookeeper:2181"
echo ""
echo "Check status: docker compose -p zookeeper-single ps"
