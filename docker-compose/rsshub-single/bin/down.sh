#!/bin/bash

# RSSHub Single-Container Shutdown Script
# Stop RSSHub single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping RSSHub Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p rsshub-single -f "${root}/compose/docker-compose.yml" down

echo "RSSHub Single-Container service stopped successfully!"
