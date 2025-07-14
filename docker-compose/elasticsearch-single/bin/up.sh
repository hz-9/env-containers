#!/bin/bash

# Elasticsearch Single-Container Startup Script
# Start Elasticsearch single instance + Kibana

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Elasticsearch Single-Container service..."
echo "Project root: ${root}"

# Start services
docker compose -p elasticsearch-single --env-file "${root}/.env"  -f "${root}/compose/docker-compose.yml" up -d

echo "Elasticsearch Single-Container service started successfully!"
echo ""
echo "Service Access Info:"
echo "  Elasticsearch: http://localhost:9200"
echo "  Kibana Web UI: http://localhost:5601"
echo ""
echo "Credentials:"
echo "  Username: elastic"
echo "  Password: 123456"
echo ""
echo "Health Check:"
echo "  curl http://localhost:9200/_cluster/health"
echo ""
echo "Data directory: ${root}/temp/"
echo "Check status: docker compose -p elasticsearch-single ps"
