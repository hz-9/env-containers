#!/bin/bash

# Elasticsearch Single-Container Shutdown Script
# Stop Elasticsearch single instance

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Stopping Elasticsearch Single-Container service..."

# Stop services
docker compose -p elasticsearch-single --env-file "${root}/.env" -f "${root}/compose/docker-compose.yml" down

echo "Elasticsearch Single-Container service stopped successfully!"
echo ""
echo "Data volume retention notice:"
echo "- Elasticsearch data: ${root}/temp/data/"
echo "- Elasticsearch logs: ${root}/temp/logs/"
echo "- Kibana data: ${root}/temp/kibana/"
echo ""
echo "To completely clean up data, manually delete the temp directory"
