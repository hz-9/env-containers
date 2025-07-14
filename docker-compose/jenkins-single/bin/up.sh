#!/bin/bash

# Jenkins Single-Container Startup Script
# Start Jenkins single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Jenkins Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p jenkins-single -f "${root}/compose/docker-compose.yml" up -d

echo "Jenkins Single-Container service started successfully!"
echo ""
echo "Access URL:"
echo "  Web Interface: http://127.0.0.1:8080"
echo ""
echo "Initial setup:"
echo "  1. Wait for Jenkins to start (may take a few minutes)"
echo "  2. Get initial password: docker logs jenkins"
echo "  3. Open http://127.0.0.1:8080 and follow setup wizard"
echo ""
echo "Check status: docker compose -p jenkins-single ps"
