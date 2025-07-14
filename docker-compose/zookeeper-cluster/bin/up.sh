#!/bin/bash

# ZooKeeper Multi-Container Startup Script
# Start ZooKeeper cluster containers

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting ZooKeeper Multi-Container services..."
echo "Project root: ${root}"

# Start services
docker compose -p zookeeper-cluster -f "${root}/compose/docker-compose.yml" up -d

echo "ZooKeeper Multi-Container services started successfully!"
echo ""
echo "Access URLs:"
echo "  ZooKeeper Cluster: 127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183"
echo "  ZooNavigator Web: http://127.0.0.1:9000"
echo ""
echo "ZooNavigator Connection:"
echo "  Connection String: zoo1:2181,zoo2:2181,zoo3:2181"
echo ""
echo "Check status: docker compose -p zookeeper-cluster ps"
