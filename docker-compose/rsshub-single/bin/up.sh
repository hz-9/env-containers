#!/bin/bash

# RSSHub Single-Container Startup Script
# Start RSSHub single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting RSSHub Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p rsshub-single -f "${root}/compose/docker-compose.yml" up -d

echo "RSSHub is starting..."
echo "URL: http://localhost:1200"
echo "Health: http://localhost:1200/healthz"

# Wait for service to start
echo "Waiting for RSSHub to be ready..."
sleep 5

# Check service status
docker compose -p rsshub-single -f "${root}/compose/docker-compose.yml" ps
