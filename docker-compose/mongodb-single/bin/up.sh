#!/bin/bash

# MongoDB Single-Container Startup Script
# Start MongoDB single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting MongoDB Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p mongodb-single -f "${root}/compose/docker-compose.yml" up -d

echo "MongoDB Single-Container service started successfully!"
echo ""
echo "Connection URL:"
echo "  Instance: mongodb://hz_9:123456@127.0.0.1:27017/hz_9?authSource=admin"
echo ""
echo "Check status: docker compose -p mongodb-single ps"
