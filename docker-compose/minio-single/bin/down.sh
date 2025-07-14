#!/bin/bash

# MinIO Single-Container Shutdown Script
# Stop MinIO single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping MinIO Single-Container service..."
echo "Project root: ${root}"

# Stop and remove services
docker compose -p minio-single -f "${root}/compose/docker-compose.yml" down
