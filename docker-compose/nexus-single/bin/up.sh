#!/bin/bash

# Nexus Single-Container Startup Script
# Start Nexus single instance container

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Nexus Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p nexus-single -f "${root}/compose/docker-compose.yml" up -d

echo "Nexus Single-Container service started successfully!"
echo ""
echo "Access URL:"
echo "  Web Interface: http://127.0.0.1:8081"
echo ""
echo "Initial setup:"
echo "  1. Wait for Nexus to start (may take several minutes)"
echo "  2. Get initial password: docker exec nexus cat /nexus-data/admin.password"
echo "  3. Open http://127.0.0.1:8081 and login with admin/<password>"
echo "  4. Follow the setup wizard to change password"
echo ""
echo "Check status: docker compose -p nexus-single ps"
