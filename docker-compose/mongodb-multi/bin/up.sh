#!/bin/bash

# MongoDB Multi-Container Startup Script
# Start MongoDB multi-instance containers

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting MongoDB Multi-Container services..."
echo "Project root: ${root}"

# Start services
docker compose -p mongodb-multi -f "${root}/compose/docker-compose.yml" up -d

echo "MongoDB Multi-Container services started successfully!"
echo ""
echo "Connection URLs:"
echo "  Instance 1: mongodb://hz_9:123456@127.0.0.1:27017/hz_9?authSource=admin"
echo "  Instance 2: mongodb://hz_9:123456@127.0.0.1:27018/hz_9?authSource=admin"
echo "  Instance 3: mongodb://hz_9:123456@127.0.0.1:27019/hz_9?authSource=admin"
echo ""
echo "Check status: docker compose -p mongodb-multi ps"
