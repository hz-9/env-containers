#!/bin/bash

# Verdaccio Single-Container Shutdown Script
# Stop Verdaccio NPM private registry

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Verdaccio Single-Container service..."

# Stop services
docker compose -p verdaccio-single -f "${root}/compose/docker-compose.yml" down

echo "Verdaccio Single-Container service stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- NPM packages: ${root}/temp/storage/"
echo "- Plugins: ${root}/temp/plugins/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
