#!/bin/bash

# ELK Cluster Startup Script
# Start ELK cluster (Elasticsearch, Kibana, Logstash, Filebeat, Metricbeat)

set -e

# Get project root directory
root=$(cd "$(dirname "$0")"; dirname "$(pwd)")

echo "Starting ELK Cluster services..."
echo "Project root: ${root}"

# Start services
docker compose -p elk-cluster --env-file "${root}/.env" -f "${root}/compose/docker-compose.yml" up -d

echo "ELK Cluster services started successfully!"
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
echo "  curl -u elastic:123456 -k https://localhost:9200/_cluster/health"
echo ""
echo "Data directory: ${root}/temp/"
echo "Check status: docker compose -p elk-cluster ps"
