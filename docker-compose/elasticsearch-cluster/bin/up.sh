#!/bin/bash

# Elasticsearch Cluster Startup Script
# Start Elasticsearch cluster (3 nodes) + Kibana

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting Elasticsearch Cluster..."
echo "Project root: ${root}"

# Start services
docker compose -p elasticsearch-cluster --env-file "${root}/.env" -f "${root}/compose/docker-compose.yml" up -d

echo "Waiting for cluster formation..."
sleep 45

echo "Elasticsearch Cluster started successfully!"
echo ""
echo "Service Access Info:"
echo "  Elasticsearch: https://localhost:9200"
echo "  Kibana Web UI: http://localhost:5601"
echo ""
echo "Credentials:"
echo "  Username: elastic"
echo "  Password: 123456"
echo ""
echo "Health Check:"
echo "  curl -k -u elastic:123456 https://localhost:9200/_cluster/health"
echo ""
echo "Data directory: ${root}/temp/"
echo "Check status: docker compose -p elasticsearch-cluster ps"
echo ""
echo "Cluster Health Check:"
echo "  curl http://localhost:9200/_cluster/health"
echo "  curl http://localhost:9200/_cat/nodes?v"
echo ""
echo "Data directories: ${root}/temp/es-*/"
echo "Check status: docker compose -p elasticsearch-cluster ps"
