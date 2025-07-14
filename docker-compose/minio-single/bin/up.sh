#!/bin/bash

# MinIO Single-Container Startup Script
# Start MinIO single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting MinIO Single-Container service..."
echo "Project root: ${root}"

# Create data directory
mkdir -p "${root}/temp/minio/data"

# Start services
docker compose -p minio-single -f "${root}/compose/docker-compose.yml" up -d

echo "MinIO is starting..."
echo "Console: http://localhost:9001"
echo "API: http://localhost:9000"
echo "Username: hz_9"
echo "Password: 12345678"

# Wait for service to start
echo "Waiting for MinIO to be ready..."
sleep 10

# Check service status
docker compose -p minio-single -f "${root}/compose/docker-compose.yml" ps
