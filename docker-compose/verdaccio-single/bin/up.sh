#!/bin/bash

# Verdaccio Single-Container Startup Script
# Start Verdaccio NPM private registry

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Verdaccio Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p verdaccio-single -f "${root}/compose/docker-compose.yml" up -d

echo "Verdaccio Single-Container service started successfully!"
echo ""
echo "Verdaccio NPM Registry Info:"
echo "  Web UI: http://localhost:4873"
echo "  Registry URL: http://localhost:4873"
echo ""
echo "NPM Configuration:"
echo "  # Set registry"
echo "  npm config set registry http://localhost:4873"
echo "  # Or use specific scope"
echo "  npm config set @your-scope:registry http://localhost:4873"
echo ""
echo "Create User:"
echo "  npm adduser --registry http://localhost:4873"
echo ""
echo "Data directory: ${root}/temp/storage/"
echo "Check status: docker compose -p verdaccio-single ps"
