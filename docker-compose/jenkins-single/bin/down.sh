#!/bin/bash

# Jenkins Single-Container Shutdown Script
# Stop Jenkins single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Jenkins Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p jenkins-single -f "${root}/compose/docker-compose.yml" down --rmi local

echo "Jenkins Single-Container service stopped successfully!"
echo ""
echo "Note: Data volumes are preserved in ./temp/"
